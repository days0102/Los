/*
    LD 脚本  使用：gcc T XXX.ld
*/

/* OUTPUT_ARCH(arch) 命令指定输出文件所适用的计算机体系架构 */
OUTPUT_ARCH("riscv")

/* ENTRY(symbol) 命令用于设置入口点,参数为一个label */
ENTRY(_start)   /* _start define at init/entry.S */

/*
MEMORY
{
    name [(attr)]: ORIGIN=origin,LENGTH=len
    .....
}
指定内存区域位置、大小
*/
MEMORY
{
	ram   (wxa!ri) : ORIGIN = 0x80000000, LENGTH = 128M
}


/*
SECTIONS
{
     sections-command
     sections-command
     ......
}
*/
SECTIONS
{
    /*
    PROVIDE(symbol=expression)
    赋值
    */
    .text : {   /* 需要空格 */
        PROVIDE(textstart = . );
        *(.text .text.*)
        PROVIDE(textend = . );
    }>ram

    .rodata : {
		PROVIDE(rodatastart = .);
		*(.rodata .rodata.*)
		PROVIDE(rodataend = .);
	} >ram

    .data : {
        . = ALIGN(4096); 
		PROVIDE(datastart = .);
        *(.sdata .sdata.*)
		*(.data .data.*)
		PROVIDE(dataend = .);
    }>ram

    .bss : {
        PROVIDE(bssstart = .);
		*(.sbss .sbss.*)
		*(.bss .bss.*)
		*(COMMON)
		PROVIDE(bssend = .);
    }>ram

    PROVIDE(memstart = ORIGIN(ram));
    PROVIDE(memend = ORIGIN(ram)+LENGTH(ram));

    PROVIDE(end = .);
    PROVIDE(heapstart = .);
    PROVIDE(heapsize = memend-heapstart);
}