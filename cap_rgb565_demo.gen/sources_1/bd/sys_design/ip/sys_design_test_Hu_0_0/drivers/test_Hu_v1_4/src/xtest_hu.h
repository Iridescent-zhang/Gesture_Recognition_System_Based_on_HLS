// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XTEST_HU_H
#define XTEST_HU_H

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
#include "xtest_hu_hw.h"

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
} XTest_hu_Config;
#endif

typedef struct {
    u64 Control_bus_BaseAddress;
    u32 IsReady;
} XTest_hu;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XTest_hu_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XTest_hu_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XTest_hu_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XTest_hu_ReadReg(BaseAddress, RegOffset) \
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
int XTest_hu_Initialize(XTest_hu *InstancePtr, u16 DeviceId);
XTest_hu_Config* XTest_hu_LookupConfig(u16 DeviceId);
int XTest_hu_CfgInitialize(XTest_hu *InstancePtr, XTest_hu_Config *ConfigPtr);
#else
int XTest_hu_Initialize(XTest_hu *InstancePtr, const char* InstanceName);
int XTest_hu_Release(XTest_hu *InstancePtr);
#endif

void XTest_hu_Start(XTest_hu *InstancePtr);
u32 XTest_hu_IsDone(XTest_hu *InstancePtr);
u32 XTest_hu_IsIdle(XTest_hu *InstancePtr);
u32 XTest_hu_IsReady(XTest_hu *InstancePtr);
void XTest_hu_EnableAutoRestart(XTest_hu *InstancePtr);
void XTest_hu_DisableAutoRestart(XTest_hu *InstancePtr);


void XTest_hu_InterruptGlobalEnable(XTest_hu *InstancePtr);
void XTest_hu_InterruptGlobalDisable(XTest_hu *InstancePtr);
void XTest_hu_InterruptEnable(XTest_hu *InstancePtr, u32 Mask);
void XTest_hu_InterruptDisable(XTest_hu *InstancePtr, u32 Mask);
void XTest_hu_InterruptClear(XTest_hu *InstancePtr, u32 Mask);
u32 XTest_hu_InterruptGetEnabled(XTest_hu *InstancePtr);
u32 XTest_hu_InterruptGetStatus(XTest_hu *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
