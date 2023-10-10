// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XCAL_HU_H
#define XCAL_HU_H

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
#include "xcal_hu_hw.h"

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
} XCal_hu_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u64 Control_bus_BaseAddress;
    u32 IsReady;
} XCal_hu;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XCal_hu_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XCal_hu_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XCal_hu_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XCal_hu_ReadReg(BaseAddress, RegOffset) \
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
int XCal_hu_Initialize(XCal_hu *InstancePtr, u16 DeviceId);
XCal_hu_Config* XCal_hu_LookupConfig(u16 DeviceId);
int XCal_hu_CfgInitialize(XCal_hu *InstancePtr, XCal_hu_Config *ConfigPtr);
#else
int XCal_hu_Initialize(XCal_hu *InstancePtr, const char* InstanceName);
int XCal_hu_Release(XCal_hu *InstancePtr);
#endif

void XCal_hu_Start(XCal_hu *InstancePtr);
u32 XCal_hu_IsDone(XCal_hu *InstancePtr);
u32 XCal_hu_IsIdle(XCal_hu *InstancePtr);
u32 XCal_hu_IsReady(XCal_hu *InstancePtr);
void XCal_hu_EnableAutoRestart(XCal_hu *InstancePtr);
void XCal_hu_DisableAutoRestart(XCal_hu *InstancePtr);

void XCal_hu_Set_result_r(XCal_hu *InstancePtr, u64 Data);
u64 XCal_hu_Get_result_r(XCal_hu *InstancePtr);

void XCal_hu_InterruptGlobalEnable(XCal_hu *InstancePtr);
void XCal_hu_InterruptGlobalDisable(XCal_hu *InstancePtr);
void XCal_hu_InterruptEnable(XCal_hu *InstancePtr, u32 Mask);
void XCal_hu_InterruptDisable(XCal_hu *InstancePtr, u32 Mask);
void XCal_hu_InterruptClear(XCal_hu *InstancePtr, u32 Mask);
u32 XCal_hu_InterruptGetEnabled(XCal_hu *InstancePtr);
u32 XCal_hu_InterruptGetStatus(XCal_hu *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
