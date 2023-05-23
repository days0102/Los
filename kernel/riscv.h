/*
 * @Author: Outsider
 * @Date: 2022-07-10 11:52:16
 * @LastEditors: Outsider
 * @LastEditTime: 2022-08-28 20:48:09
 * @Description: RISCV 汇编指令内联汇编
 * @FilePath: /los/kernel/riscv.h
 */
#include "types.h"

#define RISCV_U 0 // 用户模式
#define RISCV_S 1 // 管理模式
#define RISCV_M 3 // 机器模式

/**
 * @description:RV32 mstatus 寄存器 Machine Status Registers
 * 31 30~23 22 21 20  19  18  17   16~15   14~13   12~11
 * SD WPRI TSR TW TVM MXR SUM MPRV XS[1:0] FS[1:0] MPP[1:0]
 * 10~9    8   7    6   5    4    3   2    1   0
 * VS[1:0] SPP MPIE UBE SPIE WPRI MIE WPRI SIE WPRI
 *
 * SIE/MIE 中断使能
 * MPIE/SPIE 嵌套 trap, 保存上级SIE/MIE
 * MPP/SPP 保存 trap 前的 特权模式
 */

/**
 * @description: 获取 mstatus 寄存器（机器状态寄存器）值
 * mstatus 寄存器是一个 XLEN 位的可读/可写寄存器。
 * mstatus 寄存器持续跟踪和控制硬件线程的当前操作状态。
 * mstatus 在 H 和 S 特权级 ISA 受限的视图，分别出现在 hstatus 和 sstatus 寄存器中。
 */
static inline uint32 r_mstatus()
{
    uint32 x;
    asm volatile("csrr %0, mstatus"
                 : "=r"(x));
    return x;
}
// 将 x 写入 mstatus 寄存器
static inline void w_mstatus(uint32 x)
{
    asm volatile("csrw mstatus, %0"
                 :
                 : "r"(x));
}

/**
 * @description: 获取 mstatus 寄存器[12:11]bit
 * 00  -- 用户模式 U-mode
 * 01  -- 管理模式 S-mode
 * 10  -- Hypervisor H-mode
 * 11  -- 机器模式 M-mode
 */
// Upon reset, a hart’s privilege mode is set to M
#define XPP_MASK (3L << 11) // 用于设置11~12bit
#define M_MPP_SET (3 << 11) // 11~12bit为11
#define M_SPP_SET (1 << 11) // 11~12bit为01
// 获取 XPP 特权模式
static inline uint8 a_mstatus_xpp()
{
    uint32 x = r_mstatus();
    x &= XPP_MASK;
    switch (x)
    {
    case 0x1800:
        x = RISCV_M;
        break;
    case 0x0800:
        x = RISCV_S;
        break;
    case 0x0000:
        x = RISCV_U;
        break;
    default:
        break;
    }
    return x;
}
// 设置特权模式
static inline void s_mstatus_xpp(uint8 m)
{
    uint32 x = r_mstatus();
    switch (m)
    {
    case RISCV_U:
        x &= ~XPP_MASK;
        break;
    case RISCV_S:
        x &= ~XPP_MASK;
        x |= M_SPP_SET;
        break;
    case RISCV_M:
        x &= ~XPP_MASK;
        x |= M_MPP_SET;
        break;
    default:
        break;
    }
    w_mstatus(x);
}

/* sstatus 寄存器与mstatus相仿*/
static inline uint32 r_sstatus()
{
    uint32 x;
    asm volatile("csrr %0, sstatus"
                 : "=r"(x));
    return x;
}
// 将 x 写入 mstatus 寄存器
static inline void w_sstatus(uint32 x)
{
    asm volatile("csrw sstatus, %0"
                 :
                 : "r"(x));
}

#define SPP_MASK (1 << 8)
// 获取 XPP 特权模式
static inline uint8 a_sstatus_xpp()
{
    uint32 x = r_sstatus();
    x &= SPP_MASK;
    switch (x)
    {
    case 0x80:
        x = RISCV_S;
        break;
    case 0x00:
        x = RISCV_U;
        break;
    default:
        break;
    }
    return x;
}
// 设置特权模式
#define S_SPP_SET (1 << 8)
static inline void s_sstatus_xpp(uint8 m)
{
    uint32 x = r_sstatus();
    switch (m)
    {
    case RISCV_U:
        x &= ~SPP_MASK;
        break;
    case RISCV_S:
        x &= ~SPP_MASK;
        x |= S_SPP_SET;
        break;
    default:
        break;
    }
    w_sstatus(x);
}

/**
 * @description: 读取 mepc 寄存器
 * M-mode 返回时跳转到 pc=mepc指向的地址
 */
static inline uint32 r_mepc()
{
    uint32 x;
    asm volatile("csrr %0, mepc"
                 : "=r"(x));
    return x;
}
// 写mepc寄存器
static inline void w_mepc(uint32 x)
{
    asm volatile("csrw mepc, %0"
                 :
                 : "r"(x));
}

/**
 * @description: 读取 sepc 寄存器
 * S-mode 返回时跳转到 pc = sepc指向的地址
 */
static inline uint32 r_sepc()
{
    uint32 x;
    asm volatile("csrr %0, sepc"
                 : "=r"(x));
    return x;
}
// 写 sepc寄存器
static inline void w_sepc(uint32 x)
{
    asm volatile("csrw sepc, %0"
                 :
                 : "r"(x));
}

/**
 * @description: 获取机器位宽
 * misa[31~30]
 * 1 = 32bit
 * 2 = 64bit
 * 3 =128bit
 */
static inline uint32 r_misa()
{
    uint32 x;
    asm volatile("csrr %0,misa"
                 : "=r"(x));
    return x;
}
static inline void w_misa(uint32 x)
{
    asm volatile("csrw misa , %0"
                 :
                 : "r"(x));
}

/**
 * @description: 获取机器trap向量表
 * mtvec 寄存器保存 trap 处理函数地址
 * 31~2    1~0
 * addr | mode
 * addr 30bit 4字节对齐
 * mode 1=所有处理在addr处处理 2=在addr+4*cause处处理
 */
static inline uint32 r_mtvec()
{
    uint32 x;
    asm volatile("csrr %0 , mtvec"
                 : "=r"(x));
    return x;
}
static inline void w_mtvec(uint32 x)
{
    asm volatile("csrw mtvec , %0"
                 :
                 : "r"(x));
}
// 操作stvec寄存器
static inline uint32 r_stvec()
{
    uint32 x;
    asm volatile("csrr %0 , stvec"
                 : "=r"(x));
    return x;
}
static inline void w_stvec(uint32 x)
{
    asm volatile("csrw stvec , %0"
                 :
                 : "r"(x));
}

/**
 * @description: mideleg 中断委托寄存器
 * 将相应的中断委托给低特权模式处理
 * RV32 每位对应一种中断，前16位包含了16种中断
 */
static inline uint32 r_mideleg()
{
    uint32 x;
    asm volatile("csrr %0 , mideleg"
                 : "=r"(x));
    return x;
}
static inline void w_mideleg(uint32 x)
{
    asm volatile("csrw mideleg , %0 "
                 :
                 : "r"(x));
}
/**
 * @description: medeleg 异常委托寄存器
 * 异常委托 RV32前16为包含了RV32下的16种异常
 */
static inline uint32 r_medeleg()
{
    uint32 x;
    asm volatile("csrr %0 , medeleg"
                 : "=r"(x));
    return x;
}
static inline void w_medeleg(uint32 x)
{
    asm volatile("csrw medeleg , %0 "
                 :
                 : "r"(x));
}

/**
 * @description: Supervisor Address Translation and Protection (satp) Register
 *     31       30~22      21~0
 * MODE(WARL) ASID(WARL) PPN(WARL)
 * mode = 地址转换方案 0=bare 1=SV32
 * asid = 地址空间标识
 * ppn  = 根页表物理页码(物理地址/4Kb)
 */
#define SATP_SV32 (1 << 31)
static inline uint32 r_satp()
{
    uint32 x;
    asm volatile("csrr %0,satp"
                 : "=r"(x));
    return x;
}
static inline void w_satp(uint32 x)
{
    asm volatile("csrw satp,%0"
                 :
                 : "r"(x));
}

// 刷新整个页表
static inline void sfence_vma()
{
    asm volatile("sfence.vma zero,zero");
}

// 获取 hart id
static inline uint32 r_mhartid()
{
    uint32 x;
    asm volatile("csrr %0 , mhartid"
                 : "=r"(x));
    return x;
}

// 获取 thread id
static inline uint32 r_tp()
{
    uint32 x;
    asm volatile("mv %0 , tp"
                 : "=r"(x));
    return x;
}
static inline void w_tp(uint32 x)
{
    asm volatile("mv tp , %0"
                 :
                 : "r"(x));
}

// 获取 thread id
static inline uint32 r_sp()
{
    uint32 x;
    asm volatile("mv %0 , sp"
                 : "=r"(x));
    return x;
}
static inline void w_sp(uint32 x)
{
    asm volatile("mv sp , %0"
                 :
                 : "r"(x));
}

/**
 * @description:
 * 当一个trap进入s模式时，scause会被
 * 写入一个代码，表明导致该trap的事件。
 *     1bit         31bit
 * type | Exception Code (WLRL)
 * type 1=中断 2=异常
 */
static inline uint32 r_scause()
{
    uint32 x;
    asm volatile("csrr %0,scause"
                 : "=r"(x));
    return x;
}
static inline void w_scause(uint32 x)
{
    asm volatile("csrw scause,%0"
                 :
                 : "r"(x));
}

// trap 时写入异常相关信息
/** 如果stval在指令获取、加载或存储发生断点、
 * 地址错位、访问错误或页面错误异常时使用非
 * 零值写入，则stval将包含出错的虚拟地址。
 */
static inline uint32 r_stval()
{
    uint32 x;
    asm volatile("csrr %0,stval"
                 : "=r"(x));
    return x;
}

/**
 * @description: 读取全局中断使能
 */
#define INTR_MPIE (1 << 7)
#define INTR_SPIE (1 << 5)
#define INTR_MIE (1 << 3)
#define INTR_SIE (1 << 1)
static inline uint32 a_mstatus_intr(uint32 m)
{
    uint32 x = r_mstatus();
    switch (m)
    {
    case INTR_MPIE:
        x &= INTR_MPIE;
        break;
    case INTR_SPIE:
        x &= INTR_SPIE;
        break;
    case INTR_MIE:
        x &= INTR_MIE;
        break;
    case INTR_SIE:
        x &= INTR_SIE;
        break;
    default:
        break;
    }
    return x;
}

static inline void s_mstatus_intr(uint32 m)
{
    uint32 x = r_mstatus();
    switch (m)
    {
    case INTR_MPIE:
        x |= INTR_MPIE;
        break;
    case ~INTR_MPIE:
        x &= ~INTR_MPIE;
        break;
    case INTR_SPIE:
        x |= INTR_SPIE;
        break;
    case ~INTR_SPIE:
        x &= ~INTR_SPIE;
        break;
    case INTR_MIE:
        x |= INTR_MIE;
        break;
    case ~INTR_MIE:
        x &= ~INTR_MIE;
        break;
    case INTR_SIE:
        x |= INTR_SIE;
        break;
    case ~INTR_SIE:
        x &= ~INTR_SIE;
        break;
    default:
        break;
    }
    w_mstatus(x);
}

/**
 * @description: S-mode 全局中断
 * SPIE = 进入S-mode前中断使能
 * SIE = 进入S-mode SPIE=SIE,SIE=0  sret时 SIE=SPIE,SPIE=0
 */
static inline uint32 a_sstatus_intr(uint32 m)
{
    uint32 x = r_sstatus();
    switch (m)
    {
    case INTR_SPIE:
        x &= INTR_SPIE;
        break;
    case INTR_SIE:
        x &= INTR_SIE;
        break;
    default:
        break;
    }
    return x;
}
static inline void s_sstatus_intr(uint32 m)
{
    uint32 x = r_sstatus();
    switch (m)
    {
    case INTR_SPIE:
        x |= INTR_SPIE; // 开
        break;
    case ~INTR_SPIE:
        x &= ~INTR_SPIE; // 关
        break;
    case INTR_SIE:
        x |= INTR_SIE; // 开
        break;
    case ~INTR_SIE:
        x &= ~INTR_SIE; // 关
    default:
        break;
    }
    w_sstatus(x);
}

/**
 * @description:
 * sip 寄存器指示待处理的中断
 */
static inline uint32 r_sip()
{
    uint32 x;
    asm volatile("csrr %0,sip"
                 : "=r"(x));
    return x;
}
static inline void w_sip(uint32 x)
{
    asm volatile("csrw sip,%0"
                 :
                 : "r"(x));
}
/**
 * @description: S-mode 中断使能
 */
#define SEIE (1 << 9)
#define STIE (1 << 5)
#define SSIE (1 << 1)
static inline uint32 r_sie()
{
    uint32 x;
    asm volatile("csrr %0,sie "
                 : "=r"(x));
    return x;
}
static inline void w_sie(uint32 x)
{
    asm volatile("csrw sie,%0"
                 :
                 : "r"(x));
}
#define MEIE (1 << 11)
#define MTIE (1 << 7)
#define MSIE (1 << 3)
static inline uint32 r_mie()
{
    uint32 x;
    asm volatile("csrr %0,mie "
                 : "=r"(x));
    return x;
}
static inline void w_mie(uint32 x)
{
    asm volatile("csrw mie,%0"
                 :
                 : "r"(x));
}

// mscratch 寄存器 时钟中断时使用
static inline void w_mscratch(uint32 x)
{
    asm volatile("csrw mscratch , %0"
                 :
                 : "r"(x));
}

// PMP 物理内存保护
static inline void w_pmpaddr0(uint32 x)
{
    asm volatile("csrw pmpaddr0,%0"
                 :
                 : "r"(x));
}

static inline void w_pmpcfg0(uint32 x)
{
    asm volatile("csrw pmpcfg0,%0"
                 :
                 : "r"(x));
}
