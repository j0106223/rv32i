ENTRY(_start)
SECTIONS
{
  . = 0;
  .text : { *(.text) }
  . = 0x0200;
  .data : { *(.data) }
  .bss : { *(.bss) }
}