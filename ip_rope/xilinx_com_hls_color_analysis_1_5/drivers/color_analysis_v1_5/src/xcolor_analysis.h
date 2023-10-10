// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XCOLOR_ANALYSIS_H
#define XCOLOR_ANALYSIS_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xcolor_analysis_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
    u16 DeviceId;
    u64 Control_bus_BaseAddress;
} XColor_analysis_Config;
#endif

typedef struct {
    u64 Control_bus_BaseAddress;
    u32 IsReady;
} XColor_analysis;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XColor_analysis_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XColor_analysis_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XColor_analysis_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XColor_analysis_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XColor_analysis_Initialize(XColor_analysis *InstancePtr, u16 DeviceId);
XColor_analysis_Config* XColor_analysis_LookupConfig(u16 DeviceId);
int XColor_analysis_CfgInitialize(XColor_analysis *InstancePtr, XColor_analysis_Config *ConfigPtr);
#else
int XColor_analysis_Initialize(XColor_analysis *InstancePtr, const char* InstanceName);
int XColor_analysis_Release(XColor_analysis *InstancePtr);
#endif

void XColor_analysis_Start(XColor_analysis *InstancePtr);
u32 XColor_analysis_IsDone(XColor_analysis *InstancePtr);
u32 XColor_analysis_IsIdle(XColor_analysis *InstancePtr);
u32 XColor_analysis_IsReady(XColor_analysis *InstancePtr);
void XColor_analysis_EnableAutoRestart(XColor_analysis *InstancePtr);
void XColor_analysis_DisableAutoRestart(XColor_analysis *InstancePtr);

void XColor_analysis_Set_rows(XColor_analysis *InstancePtr, u32 Data);
u32 XColor_analysis_Get_rows(XColor_analysis *InstancePtr);
void XColor_analysis_Set_cols(XColor_analysis *InstancePtr, u32 Data);
u32 XColor_analysis_Get_cols(XColor_analysis *InstancePtr);
void XColor_analysis_Set_cb_lower(XColor_analysis *InstancePtr, u32 Data);
u32 XColor_analysis_Get_cb_lower(XColor_analysis *InstancePtr);
void XColor_analysis_Set_cb_upper(XColor_analysis *InstancePtr, u32 Data);
u32 XColor_analysis_Get_cb_upper(XColor_analysis *InstancePtr);
void XColor_analysis_Set_cr_lower(XColor_analysis *InstancePtr, u32 Data);
u32 XColor_analysis_Get_cr_lower(XColor_analysis *InstancePtr);
void XColor_analysis_Set_cr_upper(XColor_analysis *InstancePtr, u32 Data);
u32 XColor_analysis_Get_cr_upper(XColor_analysis *InstancePtr);

void XColor_analysis_InterruptGlobalEnable(XColor_analysis *InstancePtr);
void XColor_analysis_InterruptGlobalDisable(XColor_analysis *InstancePtr);
void XColor_analysis_InterruptEnable(XColor_analysis *InstancePtr, u32 Mask);
void XColor_analysis_InterruptDisable(XColor_analysis *InstancePtr, u32 Mask);
void XColor_analysis_InterruptClear(XColor_analysis *InstancePtr, u32 Mask);
u32 XColor_analysis_InterruptGetEnabled(XColor_analysis *InstancePtr);
u32 XColor_analysis_InterruptGetStatus(XColor_analysis *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
