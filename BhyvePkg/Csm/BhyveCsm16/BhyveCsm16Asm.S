/*
 * Copyright (c) 2015, Pluribus Networks, Inc.
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

#define CODE64_SEL      0x0008
#define DATA64_SEL      0x0010
#define CODE16_SEL      0x0018
#define DATA16_SEL      0x0020

#define PAGE_PRESENT    (1 << 0)
#define PAGE_WRITE      (1 << 1)
#define PAGE_SIZE       (1 << 7)

#define sizeofEFI_IA32_REGISTER_SET             48
#define offsetofEFI_IA32_REGISTER_SET_X_AX      0
#define offsetofEFI_IA32_REGISTER_SET_E_EAX     0
#define offsetofEFI_IA32_REGISTER_SET_X_BX      4
#define offsetofEFI_IA32_REGISTER_SET_E_EBX     4
#define offsetofEFI_IA32_REGISTER_SET_X_CX      8
#define offsetofEFI_IA32_REGISTER_SET_E_ECX     8
#define offsetofEFI_IA32_REGISTER_SET_X_DX      12
#define offsetofEFI_IA32_REGISTER_SET_E_EDX     12
#define offsetofEFI_IA32_REGISTER_SET_E_ESI     16
#define offsetofEFI_IA32_REGISTER_SET_E_EDI     20
#define offsetofEFI_IA32_REGISTER_SET_X_FLAGS   24
#define offsetofEFI_IA32_REGISTER_SET_X_ES      28
#define offsetofEFI_IA32_REGISTER_SET_X_CS      30
#define offsetofEFI_IA32_REGISTER_SET_X_SS      32
#define offsetofEFI_IA32_REGISTER_SET_X_DS      34
#define offsetofEFI_IA32_REGISTER_SET_X_FS      36
#define offsetofEFI_IA32_REGISTER_SET_X_GS      38
#define offsetofEFI_IA32_REGISTER_SET_X_BP      40
#define offsetofEFI_IA32_REGISTER_SET_X_SP      44


        .code16
        .org 0x0
        .global IVT
IVT:    .word   InterruptVectorEntry0x00 - IVT, 0xf000  /* 0x00 */
        .word   InterruptVectorEntry0x01 - IVT, 0xf000  /* 0x01 */
        .word   InterruptVectorEntry0x02 - IVT, 0xf000  /* 0x02 */
        .word   InterruptVectorEntry0x03 - IVT, 0xf000  /* 0x03 */
        .word   InterruptVectorEntry0x04 - IVT, 0xf000  /* 0x04 */
        .word   InterruptVectorEntry0x05 - IVT, 0xf000  /* 0x05 */
        .word   InterruptVectorEntry0x06 - IVT, 0xf000  /* 0x06 */
        .word   InterruptVectorEntry0x07 - IVT, 0xf000  /* 0x07 */
        .word   InterruptVectorEntry0x08 - IVT, 0xf000  /* 0x08 */
        .word   InterruptVectorEntry0x09 - IVT, 0xf000  /* 0x09 */
        .word   InterruptVectorEntry0x0a - IVT, 0xf000  /* 0x0a */
        .word   InterruptVectorEntry0x0b - IVT, 0xf000  /* 0x0b */
        .word   InterruptVectorEntry0x0c - IVT, 0xf000  /* 0x0c */
        .word   InterruptVectorEntry0x0d - IVT, 0xf000  /* 0x0d */
        .word   InterruptVectorEntry0x0e - IVT, 0xf000  /* 0x0e */
        .word   InterruptVectorEntry0x0f - IVT, 0xf000  /* 0x0f */
        .word   InterruptVectorEntry0x10 - IVT, 0xf000  /* 0x10 */
        .word   InterruptVectorEntry0x11 - IVT, 0xf000  /* 0x11 */
        .word   InterruptVectorEntry0x12 - IVT, 0xf000  /* 0x12 */
        .word   InterruptVectorEntry0x13 - IVT, 0xf000  /* 0x13 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x14 */
        .word   InterruptVectorEntry0x15 - IVT, 0xf000  /* 0x15 */
        .word   InterruptVectorEntry0x16 - IVT, 0xf000  /* 0x16 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x17 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x18 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x19 */
        .word   InterruptVectorEntry0x1a - IVT, 0xf000  /* 0x1a */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x1b */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x1c */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x1d */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x1e */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x1f */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x20 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x21 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x22 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x23 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x24 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x25 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x26 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x27 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x28 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x29 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x2a */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x2b */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x2c */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x2d */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x2e */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x2f */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x30 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x31 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x32 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x33 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x34 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x35 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x36 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x37 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x38 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x39 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x3a */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x3b */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x3c */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x3d */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x3e */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x3f */
        .word   InterruptVectorEntry0x40 - IVT, 0xf000   /* 0x40 */
        .word   InterruptVectorEntry0x41 - IVT, 0xf000   /* 0x41 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x42 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x43 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x44 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x45 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x46 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x47 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x48 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x49 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x4a */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x4b */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x4c */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x4d */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x4e */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x4f */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x50 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x51 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x52 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x53 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x54 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x55 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x56 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x57 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x58 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x59 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x5a */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x5b */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x5c */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x5d */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x5e */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x5f */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x60 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x61 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x62 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x63 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x64 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x65 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x66 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x67 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x68 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x69 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x6a */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x6b */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x6c */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x6d */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x6e */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x6f */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x70 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x71 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x72 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x73 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x74 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x75 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x76 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x77 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x78 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x79 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x7a */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x7b */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x7c */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x7d */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x7e */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x7f */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x80 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x81 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x82 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x83 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x84 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x85 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x86 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x87 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x88 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x89 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x8a */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x8b */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x8c */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x8d */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x8e */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x8f */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x90 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x91 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x92 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x93 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x94 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x95 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x96 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x97 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x98 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x99 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x9a */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x9b */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x9c */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x9d */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x9e */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0x9f */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xa0 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xa1 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xa2 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xa3 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xa4 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xa5 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xa6 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xa7 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xa8 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xa9 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xaa */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xab */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xac */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xad */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xae */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xaf */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xb0 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xb1 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xb2 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xb3 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xb4 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xb5 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xb6 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xb7 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xb8 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xb9 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xba */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xbb */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xbc */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xbd */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xbe */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xbf */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xc0 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xc1 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xc2 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xc3 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xc4 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xc5 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xc6 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xc7 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xc8 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xc9 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xca */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xcb */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xcc */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xcd */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xce */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xcf */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xd0 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xd1 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xd2 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xd3 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xd4 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xd5 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xd6 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xd7 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xd8 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xd9 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xda */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xdb */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xdc */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xdd */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xde */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xdf */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xe0 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xe1 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xe2 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xe3 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xe4 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xe5 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xe6 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xe7 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xe8 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xe9 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xea */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xeb */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xec */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xed */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xee */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xef */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xf0 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xf1 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xf2 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xf3 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xf4 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xf5 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xf6 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xf7 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xf8 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xf9 */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xfa */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xfb */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xfc */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xfd */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xfe */
        .word   InterruptVectorEntryNop - IVT, 0xf000   /* 0xff */

        /*
         * Register AX denotes the function that is requested.
         */
        .global CsmEntry
CsmEntry:
        cli

        /*
         * Juggle the stack to make to it 'iret'-able.
         */
        sub     $2, %sp
        pushf
        push    %bp
        push    %ax
        mov     %sp, %bp
        mov     8(%bp), %ax
        mov     %ax, 6(%bp)
        mov     10(%bp), %ax
        mov     %ax, 8(%bp)
        mov     4(%bp), %ax
        mov     %ax, 10(%bp)
        pop     %ax
        pop     %bp
        add     $2, %sp

        /* Backup stack. */
        push    %bp
        mov     %sp, %bp

        sub     $(sizeofEFI_IA32_REGISTER_SET), %sp
        mov     %eax, (offsetofEFI_IA32_REGISTER_SET_E_EAX-sizeofEFI_IA32_REGISTER_SET)(%bp)
        mov     %ebx, (offsetofEFI_IA32_REGISTER_SET_E_EBX-sizeofEFI_IA32_REGISTER_SET)(%bp)
        mov     %ecx, (offsetofEFI_IA32_REGISTER_SET_E_ECX-sizeofEFI_IA32_REGISTER_SET)(%bp)
        mov     %edx, (offsetofEFI_IA32_REGISTER_SET_E_EDX-sizeofEFI_IA32_REGISTER_SET)(%bp)
        mov     %esi, (offsetofEFI_IA32_REGISTER_SET_E_ESI-sizeofEFI_IA32_REGISTER_SET)(%bp)
        mov     %edi, (offsetofEFI_IA32_REGISTER_SET_E_EDI-sizeofEFI_IA32_REGISTER_SET)(%bp)
        mov     %es, (offsetofEFI_IA32_REGISTER_SET_X_DS-sizeofEFI_IA32_REGISTER_SET)(%bp)
        mov     %es, (offsetofEFI_IA32_REGISTER_SET_X_ES-sizeofEFI_IA32_REGISTER_SET)(%bp)
        mov     %fs, (offsetofEFI_IA32_REGISTER_SET_X_FS-sizeofEFI_IA32_REGISTER_SET)(%bp)
        mov     %gs, (offsetofEFI_IA32_REGISTER_SET_X_GS-sizeofEFI_IA32_REGISTER_SET)(%bp)

        /* Translate stack pointer */
        mov     %ss, %eax
        shll    $4, %eax
        addl    %esp, %eax

        /*  Set up segment registers. */
        xor     %dx, %dx
        mov     %dx, %ss
        mov     %dx, %ds
        mov     %dx, %es
        mov     %dx, %fs
        mov     %dx, %gs
        cld

        /* Set up new stack and save miscellaneous registers. */
        mov     $(0x7000 - 0x8), %sp
        pushl   %eax
        mov     %cr3, %ecx
        pushl   %ecx

        /*  Point edi to free space. */
        mov     $0x8000, %edi

        /*  Zero out the 24KB buffer. */
        push    %di
        mov     $6144, %ecx
        xor     %eax, %eax
        cld
        rep stos %eax,(%di)
        pop     %di

        push    %di
        lea     0x1000(%di), %eax       /* Put the address of the Page Directory Pointer Table Entry in to EAX. */
        mov     %eax, %ebx
        or      $(PAGE_PRESENT | PAGE_WRITE), %eax
        mov     %eax, (%edi)

        add     $0x1000, %edi
        xor     %esi, %esi
        xor     %ecx, %ecx
1:
        cmp     $4, %ecx
        je      4f

        add     $0x1000, %edi
        mov     %edi, %eax              /* Put the address of the Page Directory in to EAX.*/
        or      $(PAGE_PRESENT | PAGE_WRITE), %eax
        mov     %eax, (%ebx,%ecx,8)

        xor     %edx, %edx
2:
        cmp     $512, %edx
        je      3f

        mov     %esi, %eax
        or      $(PAGE_PRESENT | PAGE_WRITE | PAGE_SIZE), %eax
        mov     %eax, (%edi,%edx,8)
        add     $0x200000, %esi

        inc     %edx
        jmp     2b
3:      inc     %ecx
        jmp     1b
4:
        pop     %di

        /* Load GDT */
        addr32 lgdt     (GDT.Pointer)

        mov     %cr0, %eax
#define PE_BIT  0x1
        or      $PE_BIT, %eax
        mov     %eax, %cr0

        jmp     1f
1:
        /* Setup %ds, %ss and %es to address 4gb of linear memory */
        mov     $(DATA64_SEL), %ax
        mov     %ax, %ds
        mov     %ax, %ss
        mov     %ax, %es

        /* Load a zero length IDT so that any NMI causes a triple fault. */
        addr32 lidt     (IDT.Pointer)

        /* Enter long mode. */
        mov     %edi, %edx              /* Point CR3 at the PML4. */
        mov     %edx, %cr3

        mov     $0x6a0, %eax            /* Set the PAE and PGE bit. */
        mov     %eax, %cr4

        mov     $0xC0000080, %ecx       /* Read from the EFER MSR. */
        rdmsr
        or      $0x100, %eax            /* Set the LME bit. */
        wrmsr

        mov     %cr0, %ebx              /* Activate long mode - */
        or      $0x80000000, %ebx       /* - by enabling paging and */
        mov     %ebx, %cr0              /* - protection simultaneously. */

        /* Setup %cs with 64 bit segment */
        data32 ljmp     $CODE64_SEL, $(1f)
1:
        .code64
        /* For good measure reload other segments */
        mov     $DATA64_SEL, %eax
        mov     %eax, %ss
        mov     %eax, %ds
        mov     %eax, %es

        mov     4(%rsp), %rdi
        call    CsmMain

        cli
        lgdt    (GDT.Pointer64)
        /* Load CS with 16 bit segment and flush the instruction cache. */
        push    $CODE16_SEL
        push    $(2f - 0xf0000)
        retfq

        .code16
        /* Disable paging. */
2:      mov     %cr0, %edx
        and     $0x7FFFFFFF, %edx
        mov     %edx, %cr0

        /* Flush the TLB. */
        xor     %edx, %edx
        mov     %edx, %cr3

        mov     $DATA16_SEL, %edx       /* Load DS with 16 bit segment */
        mov     %edx, %ss
        mov     %edx, %ds
        mov     %edx, %es
        mov     %edx, %fs
        mov     %edx, %gs

        addr32 lidt     (IVT.Pointer)

        /* Disable protection */
        mov     %cr0, %edx
        and     $0xFFFFFFFE, %edx
        mov     %edx, %cr0

        /* Disable long mode */
        mov     $0xC0000080, %ecx
        rdmsr
        btcl    $8, %eax
        wrmsr

        /* Clear PAE and PGE bits. */
	/*
        mov     %cr4, %eax
        and     $~0xa0, %eax
        mov     %eax, %cr4
	*/

        ljmp    $0xf000, $(3f - 0xf0000)

3:      xor     %dx, %dx
        mov     %dx, %ss
        mov     %dx, %ds
        mov     %dx, %es
        mov     %dx, %fs
        mov     %dx, %gs

        /* Restore stack and miscellaneous registers. */
        popl    %edx
        mov     %edx, %cr3

        popl    %edx
        mov     %dx, %sp
        add     $(sizeofEFI_IA32_REGISTER_SET), %sp
        shrl    $16, %edx
        shll    $12, %edx
        mov     %dx, %ss

        mov     (offsetofEFI_IA32_REGISTER_SET_E_EAX-sizeofEFI_IA32_REGISTER_SET)(%bp), %eax
        mov     (offsetofEFI_IA32_REGISTER_SET_E_EBX-sizeofEFI_IA32_REGISTER_SET)(%bp), %ebx
        mov     (offsetofEFI_IA32_REGISTER_SET_E_ECX-sizeofEFI_IA32_REGISTER_SET)(%bp), %ecx
        mov     (offsetofEFI_IA32_REGISTER_SET_E_EDX-sizeofEFI_IA32_REGISTER_SET)(%bp), %edx
        mov     (offsetofEFI_IA32_REGISTER_SET_E_ESI-sizeofEFI_IA32_REGISTER_SET)(%bp), %esi
        mov     (offsetofEFI_IA32_REGISTER_SET_E_EDI-sizeofEFI_IA32_REGISTER_SET)(%bp), %edi
        mov     (offsetofEFI_IA32_REGISTER_SET_X_DS-sizeofEFI_IA32_REGISTER_SET)(%bp), %ds
        mov     (offsetofEFI_IA32_REGISTER_SET_X_ES-sizeofEFI_IA32_REGISTER_SET)(%bp), %es
        mov     (offsetofEFI_IA32_REGISTER_SET_X_FS-sizeofEFI_IA32_REGISTER_SET)(%bp), %fs
        mov     (offsetofEFI_IA32_REGISTER_SET_X_GS-sizeofEFI_IA32_REGISTER_SET)(%bp), %gs

        pop     %bp
        iret

        .align 8
IVT.Pointer:
        .word   0x3ff
        .long   0

        .align 8
IDT:
IDT.End:
IDT.Pointer:
        .word (IDT.End - IDT)           /* 16-bit Size (Limit) of IDT. */
        .long (IDT)                     /* 32-bit Base Address of IDT. */

        .align 8
GDT:
GDT.NULL:       /* Null Descriptor - should be present. */
        .word   0x0000
        .word   0x0000
        .byte   0x0
        .byte   0x0
        .byte   0x0
        .byte   0x0
GDT.Code64:     /* 64-bit code descriptor. */
        .word   0xffff  /* limit (low) */
        .word   0x0000  /* base (low) */
        .byte   0x0     /* base (middle) */
        .byte   0x9b    /* present, ring 0, type='code, read, accessed' */
        .byte   0xaf    /* G=1, 64-bit code segment, limit (high) */
        .byte   0x0     /* base (high) */
GDT.Data64:     /* 64-bit data descriptor. */
        .word   0xffff  /* limit (low */
        .word   0x0000  /* base (low) */
        .byte   0x0     /* base (middle) */
        .byte   0x93    /* present, ring 0, type='data, read/write,accessed' */
        .byte   0xcf    /* G=1, B=1, limit (high) */
        .byte   0x0     /* base (high) */
GDT.Code16:     /* 16-bit code descriptor. */
        .word   0xffff  /* limit (low) */
        .word   0x0000  /* base (low) */
        .byte   0xf     /* base (middle) */
        .byte   0x9b    /* present, ring 0, type='code, read, accessed' */
        .byte   0x8f    /* G=1, limit (high) */
        .byte   0x0     /* base (high) */
GDT.Data16:     /* 16-bit data descriptor. */
        .word   0xffff  /* limit (low) */
        .word   0x0000  /* base (low) */
        .byte   0x0     /* base (middle) */
        .byte   0x93    /* present, ring 0, type='data, read/write,accessed' */
        .byte   0x8f    /* G=1, B=0, limit (high) */
        .byte   0x0     /* base (high) */
GDT.End:

GDT.Pointer:
        .word (GDT.End - GDT) - 1       /* 16-bit Size (Limit) of GDT. */
        .long (GDT)                     /* 32-bit Base Address of GDT. */
GDT.Pointer64:
        .word (GDT.End - GDT) - 1       /* 16-bit Size (Limit) of GDT. */
        .quad (GDT)                     /* 64-bit Base Address of GDT. */

        .code16
RealToLong:
        cli

        /* Backup stack. */
        push    %ebp
        mov     %sp, %bp

        sub     $(sizeofEFI_IA32_REGISTER_SET), %sp
        mov     %eax, (offsetofEFI_IA32_REGISTER_SET_E_EAX-sizeofEFI_IA32_REGISTER_SET)(%bp)
        mov     %ebx, (offsetofEFI_IA32_REGISTER_SET_E_EBX-sizeofEFI_IA32_REGISTER_SET)(%bp)
        mov     %ecx, (offsetofEFI_IA32_REGISTER_SET_E_ECX-sizeofEFI_IA32_REGISTER_SET)(%bp)
        mov     %edx, (offsetofEFI_IA32_REGISTER_SET_E_EDX-sizeofEFI_IA32_REGISTER_SET)(%bp)
        mov     %esi, (offsetofEFI_IA32_REGISTER_SET_E_ESI-sizeofEFI_IA32_REGISTER_SET)(%bp)
        mov     %edi, (offsetofEFI_IA32_REGISTER_SET_E_EDI-sizeofEFI_IA32_REGISTER_SET)(%bp)
        mov     %ds, (offsetofEFI_IA32_REGISTER_SET_X_DS-sizeofEFI_IA32_REGISTER_SET)(%bp)
        mov     %es, (offsetofEFI_IA32_REGISTER_SET_X_ES-sizeofEFI_IA32_REGISTER_SET)(%bp)
        mov     %fs, (offsetofEFI_IA32_REGISTER_SET_X_FS-sizeofEFI_IA32_REGISTER_SET)(%bp)
        mov     %gs, (offsetofEFI_IA32_REGISTER_SET_X_GS-sizeofEFI_IA32_REGISTER_SET)(%bp)
        xor     %eax, %eax
        mov     (0)(%bp), %eax
        mov     %eax, (offsetofEFI_IA32_REGISTER_SET_X_BP-sizeofEFI_IA32_REGISTER_SET)(%bp)
        mov     (4+4+2+2)(%bp), %ax
        mov     %eax, (offsetofEFI_IA32_REGISTER_SET_X_FLAGS-sizeofEFI_IA32_REGISTER_SET)(%bp)

        /* Save stack pointer and segment */
        mov     %ss, %eax
        shll    $16, %eax
        addl    %esp, %eax

        /*  Set up %ds so we can access the GDT. */
        mov     $0xf000, %dx
        mov     %dx, %ds

        /* Load GDT */
        addr32 lgdt     (GDT.Pointer - 0xf0000)

        /* Enter protected mode. */
        mov     %cr0, %edx
#define PE_BIT  0x1
        or      $PE_BIT, %edx
        mov     %edx, %cr0

        jmp     1f
1:
        /* Setup %ds, %ss and %es to address 4gb of linear memory */
        mov     $(DATA16_SEL), %dx
        mov     %dx, %ds
        mov     %dx, %ss
        mov     %dx, %es

        /* Set up new stack and save miscellaneous registers. */
        addr32 mov      mStack, %esp
        mov     %esp, %ebp
        sub     $8, %esp
        mov     %eax, -4(%ebp)
        mov     %cr3, %ecx
        mov     %ecx, -8(%ebp)

        /* Load a zero length IDT so that any NMI causes a triple fault. */
        addr32 lidt     (IDT.Pointer)

        /* Enter long mode. */
        addr32 mov      mPML4, %edx     /* Point CR3 at the PML4. */
        mov     %edx, %cr3

        mov     $0x6a0, %eax             /* Set the PAE and PGE bit. */
        mov     %eax, %cr4

        mov     $0xC0000080, %ecx       /* Read from the EFER MSR. */
        rdmsr
        or      $0x100, %eax            /* Set the LME bit. */
        wrmsr

        mov     %cr0, %ebx              /* Activate long mode - */
        or      $0x80000000, %ebx       /* - by enabling paging and */
        mov     %ebx, %cr0              /* - protection simultaneously. */

        /* Setup %cs with 64 bit segment */
        data32 ljmp     $CODE64_SEL, $(1f)
1:
        .code64
        /* For good measure reload other segments */
        mov     $DATA64_SEL, %eax
        mov     %eax, %ss
        mov     %eax, %ds
        mov     %eax, %es

        lidt    mIDT

        /* Translate stack */
        mov     4(%rsp), %eax
        mov     %rax, %rdi
        shll    $16, %eax
        shrl    $16, %eax
        shrl    $16, %edi
        shll    $4, %edi
        add     %eax, %edi
        mov     sizeofEFI_IA32_REGISTER_SET+4(%rdi), %eax
        call    *%rax

LongToReal:
        cli
        lgdt    (GDT.Pointer64)

        /* Load CS with 16 bit segment and flush the instruction cache. */
        push    $CODE16_SEL
        push    $(2f - 0xf0000)
        retfq

        .code16
        /* Disable paging. */
2:      mov     %cr0, %edx
        and     $0x7FFFFFFF, %edx
        mov     %edx, %cr0

        /* Flush the TLB. */
        xor     %edx, %edx
        mov     %edx, %cr3

        mov     $DATA16_SEL, %edx       /* Load DS with 16 bit segment */
        mov     %edx, %ss
        mov     %edx, %ds
        mov     %edx, %es
        mov     %edx, %fs
        mov     %edx, %gs

        addr32 lidt     (IVT.Pointer)

        /* Disable protection. */
        mov     %cr0, %edx
        and     $0xFFFFFFFE, %edx
        mov     %edx, %cr0

        /* Disable long mode */
        mov     $0xC0000080, %ecx
        rdmsr
        btcl    $8, %eax
        wrmsr

        /* Clear PAE and PGE bits. */
	/*
        mov     %cr4, %eax
        and     $~0xA0, %eax
        mov     %eax, %cr4
	*/

        ljmp    $0xf000, $(3f - 0xf0000)

3:      xor     %dx, %dx
        mov     %dx, %ss
        mov     %dx, %ds
        mov     %dx, %es
        mov     %dx, %fs
        mov     %dx, %gs

        /* Restore stack and miscellaneous registers. */
        mov     %esp, %ebp
        mov     (%ebp), %edx
        mov     %edx, %cr3
        mov     4(%ebp), %edx

        movzx   %dx, %esp
        add     $(sizeofEFI_IA32_REGISTER_SET), %sp
        mov     %sp, %bp
        shrl    $16, %edx
        mov     %dx, %ss

        mov     (offsetofEFI_IA32_REGISTER_SET_X_FLAGS-sizeofEFI_IA32_REGISTER_SET)(%bp), %eax
        mov     %ax, (4+4+2+2)(%bp)
        mov     (offsetofEFI_IA32_REGISTER_SET_X_BP-sizeofEFI_IA32_REGISTER_SET)(%bp), %eax
        mov     %eax, (0)(%bp)
        mov     (offsetofEFI_IA32_REGISTER_SET_E_EAX-sizeofEFI_IA32_REGISTER_SET)(%bp), %eax
        mov     (offsetofEFI_IA32_REGISTER_SET_E_EBX-sizeofEFI_IA32_REGISTER_SET)(%bp), %ebx
        mov     (offsetofEFI_IA32_REGISTER_SET_E_ECX-sizeofEFI_IA32_REGISTER_SET)(%bp), %ecx
        mov     (offsetofEFI_IA32_REGISTER_SET_E_EDX-sizeofEFI_IA32_REGISTER_SET)(%bp), %edx
        mov     (offsetofEFI_IA32_REGISTER_SET_E_ESI-sizeofEFI_IA32_REGISTER_SET)(%bp), %esi
        mov     (offsetofEFI_IA32_REGISTER_SET_E_EDI-sizeofEFI_IA32_REGISTER_SET)(%bp), %edi
        mov     (offsetofEFI_IA32_REGISTER_SET_X_DS-sizeofEFI_IA32_REGISTER_SET)(%bp), %ds
        mov     (offsetofEFI_IA32_REGISTER_SET_X_ES-sizeofEFI_IA32_REGISTER_SET)(%bp), %es
        mov     (offsetofEFI_IA32_REGISTER_SET_X_FS-sizeofEFI_IA32_REGISTER_SET)(%bp), %fs
        mov     (offsetofEFI_IA32_REGISTER_SET_X_GS-sizeofEFI_IA32_REGISTER_SET)(%bp), %gs

        pop     %ebp
        add     $4, %sp         /* throw away argument */
        iret

        .code64
.global JumpLongModeToRealMode
JumpLongModeToRealMode:
        movzx   %di, %rsp
        jmp     LongToReal

        .code64
InterruptVectorNop:
        ret

        .code16
InterruptVectorEntry0x00:
        data32 push     $(InterruptVector0x00)
        jmp     RealToLong
InterruptVectorEntry0x01:
        data32 push     $(InterruptVector0x01)
        jmp     RealToLong
InterruptVectorEntry0x02:
        data32 push     $(InterruptVector0x02)
        jmp     RealToLong
InterruptVectorEntry0x03:
        data32 push     $(InterruptVector0x03)
        jmp     RealToLong
InterruptVectorEntry0x04:
        data32 push     $(InterruptVector0x04)
        jmp     RealToLong
InterruptVectorEntry0x05:
        data32 push     $(InterruptVector0x05)
        jmp     RealToLong
InterruptVectorEntry0x06:
        data32 push     $(InterruptVector0x06)
        jmp     RealToLong
InterruptVectorEntry0x07:
        data32 push     $(InterruptVector0x07)
        jmp     RealToLong
InterruptVectorEntry0x08:
        data32 push     $(InterruptVector0x08)
        jmp     RealToLong
InterruptVectorEntry0x09:
        data32 push     $(InterruptVector0x09)
        jmp     RealToLong
InterruptVectorEntry0x0a:
        data32 push     $(InterruptVector0x0a)
        jmp     RealToLong
InterruptVectorEntry0x0b:
        data32 push     $(InterruptVector0x0b)
        jmp     RealToLong
InterruptVectorEntry0x0c:
        data32 push     $(InterruptVector0x0c)
        jmp     RealToLong
InterruptVectorEntry0x0d:
        data32 push     $(InterruptVector0x0d)
        jmp     RealToLong
InterruptVectorEntry0x0e:
        data32 push     $(InterruptVector0x0e)
        jmp     RealToLong
InterruptVectorEntry0x0f:
        data32 push     $(InterruptVector0x0f)
        jmp     RealToLong
InterruptVectorEntry0x10:
        data32 push     $(InterruptVector0x10)
        jmp     RealToLong
InterruptVectorEntry0x11:
        data32 push     $(InterruptVector0x11)
        jmp     RealToLong
InterruptVectorEntry0x12:
        data32 push     $(InterruptVector0x12)
        jmp     RealToLong
InterruptVectorEntry0x13:
        data32 push     $(InterruptVector0x13)
        jmp     RealToLong
InterruptVectorEntry0x15:
        data32 push     $(InterruptVector0x15)
        jmp     RealToLong
InterruptVectorEntry0x16:
        data32 push     $(InterruptVector0x16)
        jmp     RealToLong
InterruptVectorEntry0x1a:
        data32 push     $(InterruptVector0x1a)
        jmp     RealToLong
InterruptVectorEntry0x40:
        data32 push     $(InterruptVector0x08)
        jmp     RealToLong
InterruptVectorEntry0x41:
        data32 push     $(InterruptVector0x09)
        jmp     RealToLong
InterruptVectorEntryNop:
        data32 push     $(InterruptVectorNop)
        jmp     RealToLong


        .code64
        .global X64InterruptVectorEntry0x40
X64InterruptVectorEntry0x40:
        pushq   %rbp
        movq    %rsp, %rbp

        pushfq
        pushq   %rdi
        pushq   %rsi
        pushq   %rax
        pushq   %rbx
        pushq   %rcx
        pushq   %rdx
        pushq   %r8
        pushq   %r9
        pushq   %r10
        pushq   %r11
        pushq   %r12
        pushq   %r13
        pushq   %r14
        pushq   %r15

        call    InterruptVector0x08

        popq    %r15
        popq    %r14
        popq    %r13
        popq    %r12
        popq    %r11
        popq    %r10
        popq    %r9
        popq    %r8
        popq    %rdx
        popq    %rcx
        popq    %rbx
        popq    %rax
        popq    %rsi
        popq    %rdi
        popfq

        movq     %rbp, %rsp
        popq     %rbp
        iretq

        .global X64InterruptVectorEntry0x41
X64InterruptVectorEntry0x41:
        pushq   %rbp
        movq    %rsp, %rbp

        pushfq
        pushq   %rdi
        pushq   %rsi
        pushq   %rax
        pushq   %rbx
        pushq   %rcx
        pushq   %rdx
        pushq   %r8
        pushq   %r9
        pushq   %r10
        pushq   %r11
        pushq   %r12
        pushq   %r13
        pushq   %r14
        pushq   %r15

        call    InterruptVector0x09

        popq    %r15
        popq    %r14
        popq    %r13
        popq    %r12
        popq    %r11
        popq    %r10
        popq    %r9
        popq    %r8
        popq    %rdx
        popq    %rcx
        popq    %rbx
        popq    %rax
        popq    %rsi
        popq    %rdi
        popfq

        movq     %rbp, %rsp
        popq     %rbp
        iretq

