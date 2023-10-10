// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// CONTROL_BUS
// 0x00 : Control signals
//        bit 0  - ap_start (Read/Write/COH)
//        bit 1  - ap_done (Read/COR)
//        bit 2  - ap_idle (Read)
//        bit 3  - ap_ready (Read/COR)
//        bit 7  - auto_restart (Read/Write)
//        bit 9  - interrupt (Read)
//        others - reserved
// 0x04 : Global Interrupt Enable Register
//        bit 0  - Global Interrupt Enable (Read/Write)
//        others - reserved
// 0x08 : IP Interrupt Enable Register (Read/Write)
//        bit 0 - enable ap_done interrupt (Read/Write)
//        bit 1 - enable ap_ready interrupt (Read/Write)
//        others - reserved
// 0x0c : IP Interrupt Status Register (Read/TOW)
//        bit 0 - ap_done (Read/TOW)
//        bit 1 - ap_ready (Read/TOW)
//        others - reserved
// 0x10 : Data signal of rows
//        bit 31~0 - rows[31:0] (Read/Write)
// 0x14 : reserved
// 0x18 : Data signal of cols
//        bit 31~0 - cols[31:0] (Read/Write)
// 0x1c : reserved
// 0x20 : Data signal of cb_lower
//        bit 31~0 - cb_lower[31:0] (Read/Write)
// 0x24 : reserved
// 0x28 : Data signal of cb_upper
//        bit 31~0 - cb_upper[31:0] (Read/Write)
// 0x2c : reserved
// 0x30 : Data signal of cr_lower
//        bit 31~0 - cr_lower[31:0] (Read/Write)
// 0x34 : reserved
// 0x38 : Data signal of cr_upper
//        bit 31~0 - cr_upper[31:0] (Read/Write)
// 0x3c : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_AP_CTRL       0x00
#define XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_GIE           0x04
#define XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_IER           0x08
#define XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_ISR           0x0c
#define XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_ROWS_DATA     0x10
#define XCOLOR_ANALYSIS_CONTROL_BUS_BITS_ROWS_DATA     32
#define XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_COLS_DATA     0x18
#define XCOLOR_ANALYSIS_CONTROL_BUS_BITS_COLS_DATA     32
#define XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_CB_LOWER_DATA 0x20
#define XCOLOR_ANALYSIS_CONTROL_BUS_BITS_CB_LOWER_DATA 32
#define XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_CB_UPPER_DATA 0x28
#define XCOLOR_ANALYSIS_CONTROL_BUS_BITS_CB_UPPER_DATA 32
#define XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_CR_LOWER_DATA 0x30
#define XCOLOR_ANALYSIS_CONTROL_BUS_BITS_CR_LOWER_DATA 32
#define XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_CR_UPPER_DATA 0x38
#define XCOLOR_ANALYSIS_CONTROL_BUS_BITS_CR_UPPER_DATA 32

