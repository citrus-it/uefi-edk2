/*
 * Copyright (c) 2004 - 2012, Intel Corporation. All rights reserved.<BR>
 * Copyright (c) 2014, Pluribus Networks, Inc.
 *
 * This program and the accompanying materials are licensed and made
 * available under the terms and conditions of the BSD License which
 * accompanies this distribution.  The full text of the license may be
 * found at http://opensource.org/licenses/bsd-license.php
 *
 * THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS"
 * BASIS, WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER
 * EXPRESS OR IMPLIED.
 */

#include <Uefi.h>

#include "BhyveCsm16.h"
#include "Debug.h"

#define MAX_DEBUG_MESSAGE_LENGTH  256

//
// Print primitives
//
#define PREFIX_SIGN           BIT1
#define PREFIX_BLANK          BIT2
#define LONG_TYPE             BIT4
#define OUTPUT_UNICODE        BIT6
#define FORMAT_UNICODE        BIT8
#define PAD_TO_WIDTH          BIT9
#define ARGUMENT_UNICODE      BIT10
#define PRECISION             BIT11
#define ARGUMENT_REVERSED     BIT12
#define COUNT_ONLY_NO_PRINT   BIT13

UINTN DebugLevel = DBG_INFO;

//
// Record date and time information
//
typedef struct {
  UINT16  Year;
  UINT8   Month;
  UINT8   Day;
  UINT8   Hour;
  UINT8   Minute;
  UINT8   Second;
  UINT8   Pad1;
  UINT32  Nanosecond;
  INT16   TimeZone;
  UINT8   Daylight;
  UINT8   Pad2;
} TIME;

///
/// Define the maximum number of characters that are required to
/// encode with a NULL terminator a decimal, hexadecimal, GUID,
/// or TIME value.
///
///  Maximum Length Decimal String     = 28
///    "-9,223,372,036,854,775,808"
///  Maximum Length Hexadecimal String = 17
///    "FFFFFFFFFFFFFFFF"
///  Maximum Length GUID               = 37
///    "00000000-0000-0000-0000-000000000000"
///  Maximum Length TIME               = 18
///    "12/12/2006  12:12"
///
#define MAXIMUM_VALUE_CHARACTERS  38

///
/// Flags bitmask values use in UnicodeValueToString() and
/// AsciiValueToString()
///
#define LEFT_JUSTIFY      0x01
#define COMMA_TYPE        0x08
#define PREFIX_ZERO       0x20
#define RADIX_HEX         0x80

CONST CHAR8 mHexStr[] = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};

STATIC UINTN
EFIAPI
BasePrintLibSPrint (
  OUT CHAR8        *StartOfBuffer,
  IN  UINTN        BufferSize,
  IN  UINTN        Flags,
  IN  CONST CHAR8  *FormatString,
  ...
  );

STATIC UINT16
ReadUnaligned16 (
  IN CONST UINT16              *Buffer
  )
{
#if 0
  ASSERT (Buffer != NULL);
#endif

  return *Buffer;
}

STATIC UINT32
ReadUnaligned32 (
  IN CONST UINT32              *Buffer
   )
{
#if 0
  ASSERT (Buffer != NULL);
#endif

  return *Buffer;
}

STATIC UINT64
InternalMathDivRemU64x32 (
  IN      UINT64                    Dividend,
  IN      UINT32                    Divisor,
  OUT     UINT32                    *Remainder OPTIONAL
  )
{
  if (Remainder != NULL) {
    *Remainder = (UINT32)(Dividend % Divisor);
  }
  return Dividend / Divisor;
}

STATIC UINT64
DivU64x32Remainder (
  IN      UINT64                    Dividend,
  IN      UINT32                    Divisor,
  OUT     UINT32                    *Remainder  OPTIONAL
  )
{
#if 0
  ASSERT (Divisor != 0);
#endif
  return InternalMathDivRemU64x32 (Dividend, Divisor, Remainder);
}

STATIC CHAR8 *
BasePrintLibFillBuffer (
  OUT CHAR8   *Buffer,
  IN  CHAR8   *EndBuffer,
  IN  INTN    Length,
  IN  UINTN   Character,
  IN  INTN    Increment
			)
{
  INTN  Index;

  for (Index = 0; Index < Length && Buffer < EndBuffer; Index++) {
    *Buffer = (CHAR8) Character;
    if (Increment != 1) {
      *(Buffer + 1) = (CHAR8)(Character >> 8);
    }
    Buffer += Increment;
  }

  return Buffer;
}

STATIC CHAR8 *
BasePrintLibValueToString (
  IN OUT CHAR8  *Buffer,
  IN INT64      Value,
  IN UINTN      Radix
  )
{
  UINT32  Remainder;

  //
  // Loop to convert one digit at a time in reverse order
  //
  *Buffer = 0;
  do {
    Value = (INT64)DivU64x32Remainder ((UINT64)Value, (UINT32)Radix, &Remainder);
    *(++Buffer) = mHexStr[Remainder];
  } while (Value != 0);

  //
  // Return pointer of the end of filled buffer.
  //
  return Buffer;
}

STATIC UINTN
EFIAPI
BasePrintLibSPrintMarker (
  OUT CHAR8        *Buffer,
  IN  UINTN        BufferSize,
  IN  UINTN        Flags,
  IN  CONST CHAR8  *Format,
  IN  VA_LIST      VaListMarker,   OPTIONAL
  IN  BASE_LIST    BaseListMarker  OPTIONAL
  )
{
  CHAR8             *OriginalBuffer;
  CHAR8             *EndBuffer;
  CHAR8             ValueBuffer[MAXIMUM_VALUE_CHARACTERS];
  UINT32            BytesPerOutputCharacter;
  UINTN             BytesPerFormatCharacter;
  UINTN             FormatMask;
  UINTN             FormatCharacter;
  UINTN             Width;
  UINTN             Precision;
  INT64             Value;
  CONST CHAR8       *ArgumentString;
  UINTN             Character;
  GUID              *TmpGuid;
  TIME              *TmpTime;
  UINTN             Count;
  UINTN             ArgumentMask;
  INTN              BytesPerArgumentCharacter;
  UINTN             ArgumentCharacter;
  BOOLEAN           Done;
  UINTN             Index;
  CHAR8             Prefix;
  BOOLEAN           ZeroPad;
  BOOLEAN           Comma;
  UINTN             Digits;
  UINTN             Radix;
  RETURN_STATUS     Status;
  UINT32            GuidData1;
  UINT16            GuidData2;
  UINT16            GuidData3;
  UINTN             LengthToReturn;

  //
  // If you change this code be sure to match the 2 versions of this function.
  // Nearly identical logic is found in the BasePrintLib and 
  // DxePrintLibPrint2Protocol (both PrintLib instances).
  //

  if ((Flags & COUNT_ONLY_NO_PRINT) != 0) {
    if (BufferSize == 0) {
      Buffer = NULL;
    }
  } else {
    //
    // We can run without a Buffer for counting only.
    //
    if (BufferSize == 0) {
      return 0;
    }
#if 0
    ASSERT (Buffer != NULL);
#endif
  }

  if ((Flags & OUTPUT_UNICODE) != 0) {
    BytesPerOutputCharacter = 2;
  } else {
    BytesPerOutputCharacter = 1;
  }

  LengthToReturn = 0;

  //
  // Reserve space for the Null terminator.
  //
  BufferSize--;
  OriginalBuffer = Buffer;

  //
  // Set the tag for the end of the input Buffer.
  //
  EndBuffer      = Buffer + BufferSize * BytesPerOutputCharacter;

  if ((Flags & FORMAT_UNICODE) != 0) {
    //
    // Make sure format string cannot contain more than PcdMaximumUnicodeStringLength
    // Unicode characters if PcdMaximumUnicodeStringLength is not zero. 
    //
#if 0
    ASSERT (StrSize ((CHAR16 *) Format) != 0);
#endif
    BytesPerFormatCharacter = 2;
    FormatMask = 0xffff;
  } else {
    //
    // Make sure format string cannot contain more than PcdMaximumAsciiStringLength
    // Ascii characters if PcdMaximumAsciiStringLength is not zero. 
    //
#if 0
    ASSERT (AsciiStrSize (Format) != 0);
#endif
    BytesPerFormatCharacter = 1;
    FormatMask = 0xff;
  }

  //
  // Get the first character from the format string
  //
  FormatCharacter = ((*Format & 0xff) | (*(Format + 1) << 8)) & FormatMask;

  //
  // Loop until the end of the format string is reached or the output buffer is full
  //
  while (FormatCharacter != 0 && Buffer < EndBuffer) {
    //
    // Clear all the flag bits except those that may have been passed in
    //
    Flags &= (OUTPUT_UNICODE | FORMAT_UNICODE | COUNT_ONLY_NO_PRINT);

    //
    // Set the default width to zero, and the default precision to 1
    //
    Width     = 0;
    Precision = 1;
    Prefix    = 0;
    Comma     = FALSE;
    ZeroPad   = FALSE;
    Count     = 0;
    Digits    = 0;

    switch (FormatCharacter) {
    case '%':
      //
      // Parse Flags and Width
      //
      for (Done = FALSE; !Done; ) {
        Format += BytesPerFormatCharacter;
        FormatCharacter = ((*Format & 0xff) | (*(Format + 1) << 8)) & FormatMask;
        switch (FormatCharacter) {
        case '.': 
          Flags |= PRECISION; 
          break;
        case '-': 
          Flags |= LEFT_JUSTIFY; 
          break;
        case '+': 
          Flags |= PREFIX_SIGN;  
          break;
        case ' ': 
          Flags |= PREFIX_BLANK; 
          break;
        case ',': 
          Flags |= COMMA_TYPE; 
          break;
        case 'L':
        case 'l': 
          Flags |= LONG_TYPE;    
          break;
        case '*':
          if ((Flags & PRECISION) == 0) {
            Flags |= PAD_TO_WIDTH;
            if (BaseListMarker == NULL) {
              Width = VA_ARG (VaListMarker, UINTN);
            } else {
              Width = BASE_ARG (BaseListMarker, UINTN);
            }
          } else {
            if (BaseListMarker == NULL) {
              Precision = VA_ARG (VaListMarker, UINTN);
            } else {
              Precision = BASE_ARG (BaseListMarker, UINTN);
            }
          }
          break;
        case '0':
          if ((Flags & PRECISION) == 0) {
            Flags |= PREFIX_ZERO;
          }
        case '1':
        case '2':
        case '3':
        case '4':
        case '5':
        case '6':
        case '7':
        case '8':
        case '9':
          for (Count = 0; ((FormatCharacter >= '0') &&  (FormatCharacter <= '9')); ){
            Count = (Count * 10) + FormatCharacter - '0';
            Format += BytesPerFormatCharacter;
            FormatCharacter = ((*Format & 0xff) | (*(Format + 1) << 8)) & FormatMask;
          }
          Format -= BytesPerFormatCharacter;
          if ((Flags & PRECISION) == 0) {
            Flags |= PAD_TO_WIDTH;
            Width = Count;
          } else {
            Precision = Count;
          }
          break;
       
        case '\0':
          //
          // Make no output if Format string terminates unexpectedly when
          // looking up for flag, width, precision and type. 
          //
          Format   -= BytesPerFormatCharacter;
          Precision = 0;
          //
          // break skipped on purpose.
          //
        default:
          Done = TRUE;
          break;
        }
      } 

      //
      // Handle each argument type
      //
      switch (FormatCharacter) {
      case 'p':
        //
        // Flag space, +, 0, L & l are invalid for type p.
        //
        Flags &= ~(PREFIX_BLANK | PREFIX_SIGN | PREFIX_ZERO | LONG_TYPE);
        if (sizeof (VOID *) > 4) {
          Flags |= LONG_TYPE;
        }
        //
        // break skipped on purpose
        //
      case 'X':
        Flags |= PREFIX_ZERO;
        //
        // break skipped on purpose
        //
      case 'x':
        Flags |= RADIX_HEX;
        //
        // break skipped on purpose
        //
      case 'd':
        if ((Flags & LONG_TYPE) == 0) {
          //
          // 'd','x', and 'X' that are not preceded by 'l' or 'L' are assumed to be type "int".
          // This assumption is made so the format string definition is compatible with the ANSI C
          // Specification for formatted strings.  It is recommended that the Base Types be used 
          // everywhere, but in this one case, compliance with ANSI C is more important, and 
          // provides an implementation that is compatible with that largest possible set of CPU 
          // architectures.  This is why the type "int" is used in this one case.
          //
          if (BaseListMarker == NULL) {
            Value = VA_ARG (VaListMarker, int);
          } else {
            Value = BASE_ARG (BaseListMarker, int);
          }
        } else {
          if (BaseListMarker == NULL) {
            Value = VA_ARG (VaListMarker, INT64);
          } else {
            Value = BASE_ARG (BaseListMarker, INT64);
          }
        }
        if ((Flags & PREFIX_BLANK) != 0) {
          Prefix = ' ';
        }
        if ((Flags & PREFIX_SIGN) != 0) {
          Prefix = '+';
        }
        if ((Flags & COMMA_TYPE) != 0) {
          Comma = TRUE;
        }
        if ((Flags & RADIX_HEX) == 0) {
          Radix = 10;
          if (Comma) {
            Flags &= (~PREFIX_ZERO);
            Precision = 1;
          }
          if (Value < 0) {
            Flags |= PREFIX_SIGN;
            Prefix = '-';
            Value = -Value;
          }
        } else {
          Radix = 16;
          Comma = FALSE;
          if ((Flags & LONG_TYPE) == 0 && Value < 0) {
            //
            // 'd','x', and 'X' that are not preceded by 'l' or 'L' are assumed to be type "int".
            // This assumption is made so the format string definition is compatible with the ANSI C
            // Specification for formatted strings.  It is recommended that the Base Types be used 
            // everywhere, but in this one case, compliance with ANSI C is more important, and 
            // provides an implementation that is compatible with that largest possible set of CPU 
            // architectures.  This is why the type "unsigned int" is used in this one case.
            //
            Value = (unsigned int)Value;
          }
        }
        //
        // Convert Value to a reversed string
        //
        Count = BasePrintLibValueToString (ValueBuffer, Value, Radix) - ValueBuffer;
        if (Value == 0 && Precision == 0) {
          Count = 0;
        }
        ArgumentString = (CHAR8 *)ValueBuffer + Count;
        
        Digits = Count % 3;
        if (Digits != 0) {
          Digits = 3 - Digits;
        }
        if (Comma && Count != 0) {
          Count += ((Count - 1) / 3);
        }
        if (Prefix != 0) {
          Count++;
          Precision++;
        }
        Flags |= ARGUMENT_REVERSED;
        ZeroPad = TRUE;
        if ((Flags & PREFIX_ZERO) != 0) {
          if ((Flags & LEFT_JUSTIFY) == 0) {
            if ((Flags & PAD_TO_WIDTH) != 0) {
              if ((Flags & PRECISION) == 0) {
                Precision = Width;
              }
            }
          }
        }
        break;

      case 's':
      case 'S':
        Flags |= ARGUMENT_UNICODE;
        //
        // break skipped on purpose
        //
      case 'a':
        if (BaseListMarker == NULL) {
          ArgumentString = VA_ARG (VaListMarker, CHAR8 *);
        } else {
          ArgumentString = BASE_ARG (BaseListMarker, CHAR8 *);
        }
        if (ArgumentString == NULL) {
          Flags &= (~ARGUMENT_UNICODE);
          ArgumentString = "<null string>";
        }
        //
        // Set the default precision for string to be zero if not specified.
        //
        if ((Flags & PRECISION) == 0) {
          Precision = 0;
        }
        break;

      case 'c':
        if (BaseListMarker == NULL) {
          Character = VA_ARG (VaListMarker, UINTN) & 0xffff;
        } else {
          Character = BASE_ARG (BaseListMarker, UINTN) & 0xffff;
        }
        ArgumentString = (CHAR8 *)&Character;
        Flags |= ARGUMENT_UNICODE;
        break;

      case 'g':
        if (BaseListMarker == NULL) {
          TmpGuid = VA_ARG (VaListMarker, GUID *);
        } else {
          TmpGuid = BASE_ARG (BaseListMarker, GUID *);
        }
        if (TmpGuid == NULL) {
          ArgumentString = "<null guid>";
        } else {
          GuidData1 = ReadUnaligned32 (&(TmpGuid->Data1));
          GuidData2 = ReadUnaligned16 (&(TmpGuid->Data2));
          GuidData3 = ReadUnaligned16 (&(TmpGuid->Data3));
          BasePrintLibSPrint (
            ValueBuffer,
            MAXIMUM_VALUE_CHARACTERS, 
            0,
            "%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x",
            GuidData1,
            GuidData2,
            GuidData3,
            TmpGuid->Data4[0],
            TmpGuid->Data4[1],
            TmpGuid->Data4[2],
            TmpGuid->Data4[3],
            TmpGuid->Data4[4],
            TmpGuid->Data4[5],
            TmpGuid->Data4[6],
            TmpGuid->Data4[7]
            );
          ArgumentString = ValueBuffer;
        }
        break;

      case 't':
        if (BaseListMarker == NULL) {
          TmpTime = VA_ARG (VaListMarker, TIME *); 
        } else {
          TmpTime = BASE_ARG (BaseListMarker, TIME *); 
        }
        if (TmpTime == NULL) {
          ArgumentString = "<null time>";
        } else {
          BasePrintLibSPrint (
            ValueBuffer,
            MAXIMUM_VALUE_CHARACTERS,
            0,
            "%02d/%02d/%04d  %02d:%02d",
            TmpTime->Month,
            TmpTime->Day,
            TmpTime->Year,
            TmpTime->Hour,
            TmpTime->Minute
            );
          ArgumentString = ValueBuffer;
        }
        break;

#if 0
      case 'r':
        if (BaseListMarker == NULL) {
          Status = VA_ARG (VaListMarker, RETURN_STATUS);
        } else {
          Status = BASE_ARG (BaseListMarker, RETURN_STATUS);
        }
        ArgumentString = ValueBuffer;
        if (RETURN_ERROR (Status)) {
          //
          // Clear error bit
          //
          Index = Status & ~MAX_BIT;
          if (Index > 0 && Index <= ERROR_STATUS_NUMBER) {
            ArgumentString = mStatusString [Index + WARNING_STATUS_NUMBER];
          }
        } else {
          Index = Status;
          if (Index <= WARNING_STATUS_NUMBER) {
            ArgumentString = mStatusString [Index];
          }
        }
        if (ArgumentString == ValueBuffer) {
          BasePrintLibSPrint ((CHAR8 *) ValueBuffer, MAXIMUM_VALUE_CHARACTERS, 0, "%08X", Status);
        }
        break;
#endif

      case '\r':
        Format += BytesPerFormatCharacter;
        FormatCharacter = ((*Format & 0xff) | (*(Format + 1) << 8)) & FormatMask;
        if (FormatCharacter == '\n') {
          //
          // Translate '\r\n' to '\r\n'
          //
          ArgumentString = "\r\n";
        } else {
          //
          // Translate '\r' to '\r'
          //
          ArgumentString = "\r";
          Format   -= BytesPerFormatCharacter;
        }
        break;

      case '\n':
        //
        // Translate '\n' to '\r\n' and '\n\r' to '\r\n'
        //
        ArgumentString = "\r\n";
        Format += BytesPerFormatCharacter;
        FormatCharacter = ((*Format & 0xff) | (*(Format + 1) << 8)) & FormatMask;
        if (FormatCharacter != '\r') {
          Format   -= BytesPerFormatCharacter;
        }
        break;

      case '%':
      default:
        //
        // if the type is '%' or unknown, then print it to the screen
        //
        ArgumentString = (CHAR8 *)&FormatCharacter;
        Flags |= ARGUMENT_UNICODE;
        break;
      }
      break;
 
    case '\r':
      Format += BytesPerFormatCharacter;
      FormatCharacter = ((*Format & 0xff) | (*(Format + 1) << 8)) & FormatMask;
      if (FormatCharacter == '\n') {
        //
        // Translate '\r\n' to '\r\n'
        //
        ArgumentString = "\r\n";
      } else {
        //
        // Translate '\r' to '\r'
        //
        ArgumentString = "\r";
        Format   -= BytesPerFormatCharacter;
      }
      break;

    case '\n':
      //
      // Translate '\n' to '\r\n' and '\n\r' to '\r\n'
      //
      ArgumentString = "\r\n";
      Format += BytesPerFormatCharacter;
      FormatCharacter = ((*Format & 0xff) | (*(Format + 1) << 8)) & FormatMask;
      if (FormatCharacter != '\r') {
        Format   -= BytesPerFormatCharacter;
      }
      break;

    default:
      ArgumentString = (CHAR8 *)&FormatCharacter;
      Flags |= ARGUMENT_UNICODE;
      break;
    }

    //
    // Retrieve the ArgumentString attriubutes
    //
    if ((Flags & ARGUMENT_UNICODE) != 0) {
      ArgumentMask = 0xffff;
      BytesPerArgumentCharacter = 2;
    } else {
      ArgumentMask = 0xff;
      BytesPerArgumentCharacter = 1;
    }
    if ((Flags & ARGUMENT_REVERSED) != 0) {
      BytesPerArgumentCharacter = -BytesPerArgumentCharacter;
    } else {
      //
      // Compute the number of characters in ArgumentString and store it in Count
      // ArgumentString is either null-terminated, or it contains Precision characters
      //
      for (Count = 0; Count < Precision || ((Flags & PRECISION) == 0); Count++) {
        ArgumentCharacter = ((ArgumentString[Count * BytesPerArgumentCharacter] & 0xff) | ((ArgumentString[Count * BytesPerArgumentCharacter + 1]) << 8)) & ArgumentMask;
        if (ArgumentCharacter == 0) {
          break;
        }
      }
    }

    if (Precision < Count) {
      Precision = Count;
    }

    //
    // Pad before the string
    //
    if ((Flags & (PAD_TO_WIDTH | LEFT_JUSTIFY)) == (PAD_TO_WIDTH)) {
      LengthToReturn += ((Width - Precision) * BytesPerOutputCharacter);
      if ((Flags & COUNT_ONLY_NO_PRINT) == 0 && Buffer != NULL) {
        Buffer = BasePrintLibFillBuffer (Buffer, EndBuffer, Width - Precision, ' ', BytesPerOutputCharacter);
      }
    }

    if (ZeroPad) {
      if (Prefix != 0) {
        LengthToReturn += (1 * BytesPerOutputCharacter);
        if ((Flags & COUNT_ONLY_NO_PRINT) == 0 && Buffer != NULL) {
          Buffer = BasePrintLibFillBuffer (Buffer, EndBuffer, 1, Prefix, BytesPerOutputCharacter);
        }
      }
      LengthToReturn += ((Precision - Count) * BytesPerOutputCharacter);
      if ((Flags & COUNT_ONLY_NO_PRINT) == 0 && Buffer != NULL) {
        Buffer = BasePrintLibFillBuffer (Buffer, EndBuffer, Precision - Count, '0', BytesPerOutputCharacter);
      }
    } else {
      LengthToReturn += ((Precision - Count) * BytesPerOutputCharacter);
      if ((Flags & COUNT_ONLY_NO_PRINT) == 0 && Buffer != NULL) {
        Buffer = BasePrintLibFillBuffer (Buffer, EndBuffer, Precision - Count, ' ', BytesPerOutputCharacter);
      }
      if (Prefix != 0) {
        LengthToReturn += (1 * BytesPerOutputCharacter);
        if ((Flags & COUNT_ONLY_NO_PRINT) == 0 && Buffer != NULL) {
          Buffer = BasePrintLibFillBuffer (Buffer, EndBuffer, 1, Prefix, BytesPerOutputCharacter);
        }
      }
    }

    //
    // Output the Prefix character if it is present
    //
    Index = 0;
    if (Prefix != 0) {
      Index++;
    }

    //
    // Copy the string into the output buffer performing the required type conversions
    //
    while (Index < Count) {
      ArgumentCharacter = ((*ArgumentString & 0xff) | (*(ArgumentString + 1) << 8)) & ArgumentMask;

      LengthToReturn += (1 * BytesPerOutputCharacter);
      if ((Flags & COUNT_ONLY_NO_PRINT) == 0 && Buffer != NULL) {
        Buffer = BasePrintLibFillBuffer (Buffer, EndBuffer, 1, ArgumentCharacter, BytesPerOutputCharacter);
      }
      ArgumentString    += BytesPerArgumentCharacter;
      Index++;
      if (Comma) {
        Digits++;
        if (Digits == 3) {
          Digits = 0;
          Index++;
          if (Index < Count) {
            LengthToReturn += (1 * BytesPerOutputCharacter);
            if ((Flags & COUNT_ONLY_NO_PRINT) == 0 && Buffer != NULL) {
              Buffer = BasePrintLibFillBuffer (Buffer, EndBuffer, 1, ',', BytesPerOutputCharacter);
            }
          }
        }
      }
    }

    //
    // Pad after the string
    //
    if ((Flags & (PAD_TO_WIDTH | LEFT_JUSTIFY)) == (PAD_TO_WIDTH | LEFT_JUSTIFY)) {
      LengthToReturn += ((Width - Precision) * BytesPerOutputCharacter);
      if ((Flags & COUNT_ONLY_NO_PRINT) == 0 && Buffer != NULL) {
        Buffer = BasePrintLibFillBuffer (Buffer, EndBuffer, Width - Precision, ' ', BytesPerOutputCharacter);
      }
    }

    //
    // Get the next character from the format string
    //
    Format += BytesPerFormatCharacter;

    //
    // Get the next character from the format string
    //
    FormatCharacter = ((*Format & 0xff) | (*(Format + 1) << 8)) & FormatMask;
  }

  if ((Flags & COUNT_ONLY_NO_PRINT) != 0) {
    return (LengthToReturn / BytesPerOutputCharacter);
  }

#if 0
  ASSERT (Buffer != NULL);
#endif
  //
  // Null terminate the Unicode or ASCII string
  //
  BasePrintLibFillBuffer (Buffer, EndBuffer + BytesPerOutputCharacter, 1, 0, BytesPerOutputCharacter);
  //
  // Make sure output buffer cannot contain more than PcdMaximumUnicodeStringLength
  // Unicode characters if PcdMaximumUnicodeStringLength is not zero. 
  //
#if 0
  ASSERT ((((Flags & OUTPUT_UNICODE) == 0)) || (StrSize ((CHAR16 *) OriginalBuffer) != 0));
#endif
  //
  // Make sure output buffer cannot contain more than PcdMaximumAsciiStringLength
  // ASCII characters if PcdMaximumAsciiStringLength is not zero. 
  //
#if 0
  ASSERT ((((Flags & OUTPUT_UNICODE) != 0)) || (AsciiStrSize (OriginalBuffer) != 0));
#endif

  return ((Buffer - OriginalBuffer) / BytesPerOutputCharacter);
}

STATIC UINTN
EFIAPI
BasePrintLibSPrint (
  OUT CHAR8        *StartOfBuffer,
  IN  UINTN        BufferSize,
  IN  UINTN        Flags,
  IN  CONST CHAR8  *FormatString,
  ...
  )
{
  VA_LIST  Marker;
  UINTN    NumberOfPrinted;

  VA_START (Marker, FormatString);
  NumberOfPrinted = BasePrintLibSPrintMarker (StartOfBuffer, BufferSize, Flags, FormatString, Marker, NULL);
  VA_END (Marker);
  return NumberOfPrinted;
}

STATIC UINTN
EFIAPI
AsciiVSPrint (
  OUT CHAR8         *StartOfBuffer,
  IN  UINTN         BufferSize,
  IN  CONST CHAR8   *FormatString,
  IN  VA_LIST       Marker
  )
{
  return BasePrintLibSPrintMarker (StartOfBuffer, BufferSize, 0, FormatString, Marker, NULL);
}

#ifdef  DEBUG_PORT
VOID
EFIAPI
DebugPrint (
  IN  CONST CHAR8  *Format,
  ...
  )
{
  CHAR8    Buffer[MAX_DEBUG_MESSAGE_LENGTH];
  VA_LIST  Marker;
  UINT8    *Ptr;

  VA_START (Marker, Format);
  AsciiVSPrint (Buffer, sizeof (Buffer), Format, Marker);
  VA_END (Marker);

  for (Ptr = (UINT8 *) Buffer; *Ptr; Ptr++) {
    IoWrite32 (DEBUG_PORT, *Ptr);
  }
}
#endif
