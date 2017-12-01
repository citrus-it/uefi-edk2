#
#  Copyright (c) 2014, Pluribus Networks, Inc.
#
#  This program and the accompanying materials are licensed and made
#  available under the terms and conditions of the BSD License which
#  accompanies this distribution.  The full text of the license may be
#  found at http://opensource.org/licenses/bsd-license.php
#
#  THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS"
#  BASIS, WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER
#  EXPRESS OR IMPLIED.
#

CC         ?= gcc
LD	   ?= ld
OBJCOPY    ?= objcopy
ASFLAGS    = -m64 -nostdinc -nostdlib -ffreestanding
CFLAGS     = -m64 -nostdinc -nostdlib -ffreestanding \
             -fno-common -fshort-wchar -mno-red-zone \
             -mno-mmx -mno-sse -Wimplicit-function-declaration

CPPFLAGS   =  -DEFIAPI="__attribute__((ms_abi))" \
              -DNO_BUILTIN_VA_FUNCS \
              ${DEBUG_PORT} \
              -DBUILD_DATE=${BUILD_DATE} \
              -I${WORKSPACE}/MdePkg/Include \
              -I${WORKSPACE}/MdePkg/Include/X64 \
              -I${WORKSPACE}/IntelFrameworkPkg/Include \
              -I${WORKSPACE}/BhyvePkg/Include

OBJECTS    = Bin/BhyveCsm16Asm.o \
             Bin/BhyveCsm16.o \
             Bin/Bios.o \
             Bin/Legacy8254.o \
             Bin/Keyboard.o \
             Bin/Memory.o \
             Bin/Mmu.o \
             Bin/Printf.o \
             Bin/String.o \
             Bin/Video.o \
             Bin/ter-u16n-IBM-CP437.o

DEBUG_PORT = -DDEBUG_PORT=0x220

BUILD_DATE = \"$(shell date +%D)\"

MKDIR      = mkdir -p

all: init Bin/BhyveCsm16.bin

init:
	@$(MKDIR) Bin

Bin/%.c: %.bdf
	awk -f bdf_to_c.awk $< > $@

Bin/%.o: %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<

Bin/%.o: %.S
	$(CC) $(ASFLAGS) $(CPPFLAGS) -c -o $@ $<

Bin/BhyveCsm16.bin: linker.lds $(OBJECTS)
	$(LD) -Tlinker.lds -m elf_x86_64_sol2 -o Bin/BhyveCsm16.raw.o -Map Bin/BhyveCsm16.bin.map $(OBJECTS)
	$(OBJCOPY) --only-section .raw --output-target binary --pad-to 0x100000 Bin/BhyveCsm16.raw.o Bin/BhyveCsm16.bin

clean:
	$(RM) $(OBJECTS) Bin/BhyveCsm16.raw.o Bin/BhyveCsm16.bin.map
