// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XTEST_AREA_PRMTER_H
#define XTEST_AREA_PRMTER_H

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
#include "xtest_area_prmter_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
    u16 DeviceId;
    u64 Control_BaseAddress;
    u64 Control_bus_BaseAddress;
} XTest_area_prmter_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u64 Control_bus_BaseAddress;
    u32 IsReady;
} XTest_area_prmter;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XTest_area_prmter_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XTest_area_prmter_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XTest_area_prmter_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XTest_area_prmter_ReadReg(BaseAddress, RegOffset) \
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
int XTest_area_prmter_Initialize(XTest_area_prmter *InstancePtr, u16 DeviceId);
XTest_area_prmter_Config* XTest_area_prmter_LookupConfig(u16 DeviceId);
int XTest_area_prmter_CfgInitialize(XTest_area_prmter *InstancePtr, XTest_area_prmter_Config *ConfigPtr);
#else
int XTest_area_prmter_Initialize(XTest_area_prmter *InstancePtr, const char* InstanceName);
int XTest_area_prmter_Release(XTest_area_prmter *InstancePtr);
#endif

void XTest_area_prmter_Start(XTest_area_prmter *InstancePtr);
u32 XTest_area_prmter_IsDone(XTest_area_prmter *InstancePtr);
u32 XTest_area_prmter_IsIdle(XTest_area_prmter *InstancePtr);
u32 XTest_area_prmter_IsReady(XTest_area_prmter *InstancePtr);
void XTest_area_prmter_EnableAutoRestart(XTest_area_prmter *InstancePtr);
void XTest_area_prmter_DisableAutoRestart(XTest_area_prmter *InstancePtr);

void XTest_area_prmter_Set_result_r(XTest_area_prmter *InstancePtr, u64 Data);
u64 XTest_area_prmter_Get_result_r(XTest_area_prmter *InstancePtr);

void XTest_area_prmter_InterruptGlobalEnable(XTest_area_prmter *InstancePtr);
void XTest_area_prmter_InterruptGlobalDisable(XTest_area_prmter *InstancePtr);
void XTest_area_prmter_InterruptEnable(XTest_area_prmter *InstancePtr, u32 Mask);
void XTest_area_prmter_InterruptDisable(XTest_area_prmter *InstancePtr, u32 Mask);
void XTest_area_prmter_InterruptClear(XTest_area_prmter *InstancePtr, u32 Mask);
u32 XTest_area_prmter_InterruptGetEnabled(XTest_area_prmter *InstancePtr);
u32 XTest_area_prmter_InterruptGetStatus(XTest_area_prmter *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
