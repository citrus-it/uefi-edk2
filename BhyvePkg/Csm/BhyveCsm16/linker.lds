/*
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

OUTPUT_FORMAT("elf64-x86-64-sol2")
OUTPUT_ARCH(i386:x86-64)

SECTIONS
{
    .raw 0xf0000 : {
        *(.text)
        *(.data)
        *(.rodata)
        *(.bss)
        _end = .;
        . = 0xfff5;
        *(.tail)
    } = 0x00

    /DISCARD/ : {    
        *(.note*)
        *(.comment*)
	*(.iplt)
	*(.igot.plt)
	*(.rela*)
	*(.eh_frame)
    }
}
