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
        
        /* usertrap  */
        . = ALIGN(4096);
        *(traptext)  /* 把 usertrap.S 放到这里 */
    }>ram

    .data : {
        . = ALIGN(4096); 
		PROVIDE(datastart = .);
        *(.sdata .sdata.*)
		*(.data .data.*)
		PROVIDE(dataend = .);
    }>ram

    .rodata : {
        . = ALIGN(4096);        /*保证位1个页偏移*/
		PROVIDE(rodatastart = .);
		*(.rodata .rodata.*)
		PROVIDE(rodataend = .);
	} >ram
    
    .bss : {
        . = ALIGN(4096);
        PROVIDE(bssstart = .);
		*(.sbss .sbss.*)
		*(.bss .bss.*)
		*(COMMON)
		PROVIDE(bssend = .);
    }>ram

    /* .traptext : { */
        /* . = ALIGN(4096); */
        /* *(traptext)   把 usertrap.S 放到这里 */
    /* }>ram */

    . = ALIGN(4096);

    PROVIDE(memstart = ORIGIN(ram));
    PROVIDE(memend = ORIGIN(ram)+LENGTH(ram));

    PROVIDE(mstart = .);         /* 堆的起始位置 */
    PROVIDE(mend = memend);
}