/*
 * @Author       : Outsider
 * @Date         : 2023-03-04 14:11:27
 * @LastEditors  : Outsider
 * @LastEditTime : 2023-03-04 19:42:06
 * @Description  :
 *
 * docs : https://pdos.csail.mit.edu/6.828/2021/readings/8254x_GBe_SDM.pdf
 *
 * @FilePath     : /los/kernel/eth.h
 */
#include "types.h"

#define E1000_BASE 0x40000000

#define E1000_CTRL 0x00000 // General Device Control Register
#define E1000_CTRL_SLU (1 << 6)
#define E1000_CTRL_FRCSPD (1 << 11)
#define E1000_CTRL_FRCDPLX (1 << 12)
#define E1000_CTRL_RST (1 << 26)

#define E1000_STATUS 0x00008   // General Device Status Register
#define E1000_EECD 0x00010     // General EEPROM/Flash Control/Data Register
#define E1000_EERD 0x00014     // EEPROM Read
#define E1000_CTRL_EXT 0x00018 // General Extended Device Control Register
#define E1000_MDIC 0x00020     // General MDI Control Register
#define E1000_FCAL 0x00028     // General Flow Control Address Low
#define E1000_FCAH 0x0002c     // General Flow Control Address High
#define E1000_FCT 0x00030      // General Flow Control Type
#define E1000_VET 0x00038      // General VLAN Ether Type
#define E1000_FCTTV 0x00170    // General Flow Control Transmit Timer Value
#define E1000_TXCW 0x00178     // General Transmit Configuration Word
#define E1000_RXCW 0x00180     // General Receive Configuration Word
#define E1000_LEDCTL 0x00E00   // LED Control
#define E1000_PBA 0x01000      // General Packet Buffer Allocation
#define E1000_ICR 0x000c0      // Interrupt Interrupt Cause Read
#define E1000_ITR 0X000c4      // Interrupt Throttling
#define E1000_ICS 0x000c8      // Interrupt Interrupt Cause Set
#define E1000_IMS 0x000d0      // Interrupt Interrupt Mask Set/Read
#define E1000_IMC 0x000d8      // Interrupt Interrupt Mask Clear

#define E10000_RCTL 0x00100  // Receive Control R/W 300 Receive
#define E10000_FCRTL 0x02160 // Flow Control Receive Threshold Low R/W 304 Receive
#define E10000_FCRTH 0x02168 // Flow Control Receive Threshold High R/W 305 Receive
#define E10000_RDBAL 0x02800 // Receive Descriptor Base Low R/W 306 Receive
#define E10000_RDBAH 0x02804 // Receive Descriptor Base High R/W 306 Receive
#define E10000_RDLEN 0x02808 // Receive Descriptor Length R/W 307 Receive
#define E10000_RDH 0x02810   // Receive Descriptor Head R/W 307 Receive
#define E10000_RDT 0x02818   // Receive Descriptor Tail R/W 308 Receive
#define E10000_RDTR 0x02820  // Receive Delay Timer R/W 308 Receive
#define E10000_RADV 0x0282C  // Receive Interrupt Absolute Delay Timer
                             // (not Receive to the 82544GC/EI) R/W 309 applicable
#define E10000_RSRPD 0x02C00 // Receive Small Packet Detect Interrupt
                             // (not Receive to the 82544GC/EI) R/W applicable

#define E1000_TCTL 0x00400      // Transmit Transmit Control
#define E1000_TCTL_EN (1 << 1)  // Transmit Enable
#define E1000_TCTL_PSP (1 << 3) // Pad Short Packets

#define E1000_TIPG 00410  //  Transmit IPG R/W 312 Transmit
#define E1000_AIFS 00458  //  Adaptive IFS Throttle - AIT R/W 314 Transmit
#define E1000_TDBAL 03800 //  Transmit Descriptor Base Low R/W 315 Transmit
#define E1000_TDBAH 03804 //  Transmit Descriptor Base High R/W 316 Transmit
#define E1000_TDLEN 03808 //  Transmit Descriptor Length R/W 316 Transmit
#define E1000_TDH 03810   //  Transmit Descriptor Head R/W 317 Transmit
#define E1000_TDT 03818   //  Transmit Descriptor Tail R/W 318 Transmit
#define E1000_TIDV 03820  //  Transmit Interrupt Delay Value R/W 318 Transmit

// ************************
#define E1000_TXDMAC 0x03000   // TX DMA   TX DMA Control (applicable to the 82544GC/EI only) R/W 319
#define E1000_TXDCTL 0x03828   // TX DMA   Transmit Descriptor Control R/W 319
#define E1000_TADV 0x0282C     // TX DMA   Transmit Absolute Interrupt Delay Timer (not applicable to the 82544GC/EI) R/W 321
#define E1000_TSPMT 0x03830    // TX DMA   TCP Segmentation Pad and Threshold R/W 322
#define E1000_RXDCTL 0x02828   // RX DMA   Receive Descriptor Control R/W 324
#define E1000_RXCSUM 0x05000   // RX DMA   Receive Checksum Control R/W 325
#define E1000_MTA 0x05200      // Receive [127:0] Multicast Table Array (n) R/W 327
#define E1000_RAL 0x05400      // Receive (8*n) Receive Address Low (n) R/W 329
#define E1000_RAH 0x05404      // Receive (8*n) Receive Address High (n) R/W 329
#define E1000_VFTA 0x05600     // Receive [127:0] VLAN Filter Table Array (n)Not applicable to the 82541ER R/W 330
#define E1000_WUC 0x05800      // Wakeup Control R/W 331 Wakeup
#define E1000_WUFC 0x05808     // Wakeup Filter Control R/W 332 Wakeup
#define E1000_WUS 0x05810      // Wakeup Status R 333 Wakeup
#define E1000_IPAV 0x05838     // IP Address Valid R/W 335 Wakeup
#define E1000_Wakeup 0x05840   // IP4ATIPAT (82544GC/EI)IPv4 Address TableIP Address Table (82544GC/EI) R/W 336
#define E1000_IP6AT 0x05880    // IPv6 Address Table (not applicable to the Wakeup 82544GC/EI) R/W 337
#define E1000_WUPL 0x05900     // Wakeup Packet Length R/W 338 Wakeup
#define E1000_WUPM 0x05A00     // Wakeup Packet Memory R/W 338 Wakeup
#define E1000_FFLT 0x05F00     // Flexible Filter Length Table R/W 338 Wakeup
#define E1000_FFMT 0x09000     // Flexible Filter Mask Table R/W 339 Wakeup
#define E1000_FFVT 0x09800     // Flexible Filter Value Table R/W 340 Wakeup
#define E1000_CRCERRS 0x04000  // CRC Error Count R 341 Statistics
#define E1000_ALGNERRC 0x04004 // Alignment Error Count R 341 Statistics
#define E1000_SYMERRS 0x04008  // Symbol Error Count R 342 Statistics
#define E1000_RXERRC 0x0400C   // RX Error Count R 342 Statistics
#define E1000_MPC 0x04010      // Missed Packets Count R 343 Statistics
#define E1000_SCC 0x04014      // Single Collision Count R 343 Statistics
#define E1000_ECOL 0x04018     // Excessive Collisions Count R 344 Statistics
#define E1000_MCC 0x0401C      // Multiple Collision Count R 344 Statistics
#define E1000_LATECOL 0x04020  // Late Collisions Count R 345 Statistics
#define E1000_COLC 0x04028     // Collision Count R 345 Statistics
#define E1000_DC 0x04030       // Defer Count R 346 Statistics
#define E1000_TNCRS 0x04034    // Transmit - No CRS R 346 Statistics
#define E1000_SEC 0x04038      // Sequence Error Count R 347 Statistics
#define E1000_CEXTERR 0x0403C  // Carrier Extension Error Count R 347 Statistics
#define E1000_RLEC 0x04040     // Receive Length Error Count R 348 Statistics
#define E1000_XONRXC 0x04048   // XON Received Count R 348 Statistics
#define E1000_XONTXC 0x0404C   // XON Transmitted Count R 349 Statistics
#define E1000_XOFFRXC 0x04050  // XOFF Received Count R 349 Statistics

#define E1000_XOFFTXC 0x04054 // XOFF Transmitted Count R 349 Statistics
#define E1000_FCRUC 0x04058   //  FC Received Unsupported Count R/W 350 Statistics
#define E1000_PRC64 0x0405C   //  Packets Received (64 Bytes) Count R/W 350 Statistics
#define E1000_PRC127 0x04060  //  Packets Received (65-127 Bytes) Count R/W 351 Statistics
#define E1000_PRC255 0x04064  //  Packets Received (128-255 Bytes) Count R/W 351 Statistics
#define E1000_PRC511 0x04068  //  Packets Received (256-511 Bytes) Count R/W 352 Statistics
#define E1000_PRC1023 0x0406C //  Packets Received (512-1023 Bytes) Count R/W 352 Statistics
#define E1000_PRC1522 0x04070 //  Packets Received (1024-Max Bytes) R/W 353 Statistics
#define E1000_GPRC 0x04074    //  Good Packets Received Count R 353 Statistics
#define E1000_BPRC 0x04078    //  Broadcast Packets Received Count R 354 Statistics
#define E1000_MPRC 0x0407C    //  Multicast Packets Received Count R 354 Statistics
#define E1000_GPTC 0x04080    // Good Packets Transmitted Count R 355  Statistics
#define E1000_GORCL 0x04088   // Good Octets Received Count (Low) R 355  Statistics
#define E1000_GORCH 0x0408C   // Good Octets Received Count (Hi) R 355  Statistics
#define E1000_GOTCL 0x04090   // Good Octets Transmitted Count (Low) R 356  Statistics
#define E1000_GOTCH 0x04094   // Good Octets Transmitted Count (Hi) R 356  Statistics
#define E1000_RNBC 0x040A0    // Receive No Buffers Count R 356  Statistics
#define E1000_RUC 0x040A4     // Receive Undersize Count R 357  Statistics
#define E1000_RFC 0x040A8     // Receive Fragment Count R 357  Statistics
#define E1000_ROC 0x040AC     // Receive Oversize Count R 358  Statistics
#define E1000_RJC 0x040B0     // Receive Jabber Count R 358  Statistics
#define E1000_MGTPRC 040B4h   // Management Packets Received Count(not to the 82544GC / EI or 82541ER) R 359 applicable Statistics
#define E1000_MGTPDC 040B8h   // Management Packets Dropped Count(not to the 82544GC / EI or 82541ER) R 360 applicable     Statistics
#define E1000_MGTPTC 040BCh   // Management Pkts Transmitted Count(not to the 82544GC / EI or 82541ER) R 360 applicable     Statistics
#define E1000_TORL 0x040C0    // Total Octets Received (Lo) R 360  Statistics
#define E1000_TORH 0x040C4    // Total Octets Received (Hi) R 360  Statistics
#define E1000_TOTL 0x040C8    // Total Octets Transmitted (Lo) R 361  Statistics
#define E1000_TOTH 0x040CC    // Total Octets Transmitted (Hi) R 361  Statistics
#define E1000_TPR 0x040D0     // Total Packets Received R 362  Statistics
#define E1000_TPT 0x040D4     // Total Packets Transmitted R 362  Statistics
#define E1000_PTC64 0x040D8   // Packets Transmitted (64 Bytes) Count R 363  Statistics
#define E1000_PTC127 0x040DC  // Packets Transmitted (65-127 Bytes) Count R 363  Statistics
#define E1000_PTC255 0x040E0  // Packets Transmitted (128-255 Bytes) Count R 364  Statistics
#define E1000_PTC511 0x040E4  // Packets Transmitted (256-511 Bytes) Count R 364  Statistics
#define E1000_PTC1023 0x040E8 // Packets Transmitted (512-1023 Bytes) Count R 365  Statistics
#define E1000_PTC1522 0x040EC // Packets Transmitted (1024 Bytes or Greater) Count R 365  Statistics
#define E1000_MPTC 0x040F0    // Multicast Packets Transmitted Count R 366  Statistics
#define E1000_BPTC 0x040F4    // Broadcast Packets Transmitted Count R 366  Statistics
#define E1000_TSCTC 0x040F8   // TCP Segmentation Context Transmitted Count R 367  Statistics
#define E1000_TSCTFC 0x040FC  // TCP Segmentation Context Tx Fail Count R 367  Statistics
#define E1000_RDFH 0x02410    // Receive Data FIFO Head R/W 368  Diagnostic
#define E1000_RDFT 0x02418    // Receive Data FIFO Tail R/W 368  Diagnostic
#define E1000_RDFHS 0x02420   // Receive Data FIFO Head Saved Register R/W 369  Diagnostic
#define E1000_RDFTS 0x02428   // Receive Data FIFO Tail Saved Register R/W 369  Diagnostic
#define E1000_RDFPC 0x02430   // Receive Data FIFO Packet Count R/W 370  Diagnostic
#define E1000_TDFH 0x03410    // Transmit Data FIFO Head R/W 370  Diagnostic

#define E1000_TDFT 0x03418  // Transmit Data FIFO Tail R/W 371 Diagnostic
#define E1000_TDFHS 0x03420 // Transmit Data FIFO Head Saved Register R/W 371 Diagnostic
#define E1000_TDFTS 0x03428 // Transmit Data FIFO Tail Saved Register R/W 372 Diagnostic
#define E1000_TDFPC 0x03430 // Transmit Data FIFO Packet Count R/W 372 Diagnostic
#define E1000_PBM 0x10000   // Packet Buffer Memory (n) R/W 373 Diagnostic
// ************************************

/** 碰撞阈值 8bit
 *这决定了在放弃数据包之前尝试重传的次数。
 *实现以太网回退算法，并在重试16次后锁定到最大值。
 *它只在半双工操作中有意义
 */
#define E1000_TCTL_CT
/** 碰撞距离 10bit
 * 指定正确的CSMA/CD操作必须经过的最小字节数。
 * 数据包用特殊符号填充，而不是有效的数据字节。
 * 硬件检查这个值和填充数据包，即使在全双工操作。
 */
#define E1000_TCTL_CLOD
#define E1000_TCTL_SWXOFF (1 << 22) // Software XOFF Transmission
                                    /** 在后期碰撞时重新传送设置后，使以太网控制器在延迟碰撞事件时重新传输。
                                     * 碰撞窗口与速度有关。例如，10/100mb/s为64字节，1000Mb/s为512字节。
                                     * 如果在禁用此位时检测到后期碰撞，则发送功能假定数据包已成功传输。
                                     * RTLC位在全双工模式下被忽略。
                                     */
#define E1000_TCTL_RTLC (1 << 24)

#define ETH_REGS(reg) ((volatile uint32 *)(E1000_BASE + (reg)))
#define eth_read(reg) (*(ETH_REGS(reg)))
#define eth_write(reg, val) ((*(ETH_REGS(reg))) = (val))

#define TX_RING_SIZE 8
#define RX_RING_SIZE 8

// 网卡驱动接收描述符
struct receivedesc
{
    uint64 addr;     // 缓存区地址
    uint16 len;      // 存进缓冲区的数据长度
    uint16 checksum; // 数据检验和
    uint8 status;    // 表明描述符是否被使用，以及引用的缓冲区是否是最后一个
    uint8 errors;    // 坏包
    uint16 special;  // 额外的信息(VLAN)
};

// 网卡驱动发送描述符
struct transmitdesc
{
    uint64 addr;   // 缓冲区地址
    uint16 len;    // 数据长度
    uint8 cso;     // 检验和偏移 chechsum offset
    uint8 cmd;     // command
    uint8 sta : 4; // status
    uint8 rsv : 4; // Reserve
    uint8 css;     // 检验和起点 checksum start
    uint16 special;
};
