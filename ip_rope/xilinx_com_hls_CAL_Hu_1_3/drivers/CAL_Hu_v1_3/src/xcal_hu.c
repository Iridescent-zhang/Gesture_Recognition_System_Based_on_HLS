// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xcal_hu.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XCal_hu_CfgInitialize(XCal_hu *InstancePtr, XCal_hu_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->Control_bus_BaseAddress = ConfigPtr->Control_bus_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XCal_hu_Start(XCal_hu *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCal_hu_ReadReg(InstancePtr->Control_bus_BaseAddress, XCAL_HU_CONTROL_BUS_ADDR_AP_CTRL) & 0x80;
    XCal_hu_WriteReg(InstancePtr->Control_bus_BaseAddress, XCAL_HU_CONTROL_BUS_ADDR_AP_CTRL, Data | 0x01);
}

u32 XCal_hu_IsDone(XCal_hu *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCal_hu_ReadReg(InstancePtr->Control_bus_BaseAddress, XCAL_HU_CONTROL_BUS_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XCal_hu_IsIdle(XCal_hu *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCal_hu_ReadReg(InstancePtr->Control_bus_BaseAddress, XCAL_HU_CONTROL_BUS_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XCal_hu_IsReady(XCal_hu *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCal_hu_ReadReg(InstancePtr->Control_bus_BaseAddress, XCAL_HU_CONTROL_BUS_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XCal_hu_EnableAutoRestart(XCal_hu *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCal_hu_WriteReg(InstancePtr->Control_bus_BaseAddress, XCAL_HU_CONTROL_BUS_ADDR_AP_CTRL, 0x80);
}

void XCal_hu_DisableAutoRestart(XCal_hu *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCal_hu_WriteReg(InstancePtr->Control_bus_BaseAddress, XCAL_HU_CONTROL_BUS_ADDR_AP_CTRL, 0);
}

void XCal_hu_Set_result_r(XCal_hu *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCal_hu_WriteReg(InstancePtr->Control_BaseAddress, XCAL_HU_CONTROL_ADDR_RESULT_R_DATA, (u32)(Data));
    XCal_hu_WriteReg(InstancePtr->Control_BaseAddress, XCAL_HU_CONTROL_ADDR_RESULT_R_DATA + 4, (u32)(Data >> 32));
}

u64 XCal_hu_Get_result_r(XCal_hu *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XCal_hu_ReadReg(InstancePtr->Control_BaseAddress, XCAL_HU_CONTROL_ADDR_RESULT_R_DATA);
    Data += (u64)XCal_hu_ReadReg(InstancePtr->Control_BaseAddress, XCAL_HU_CONTROL_ADDR_RESULT_R_DATA + 4) << 32;
    return Data;
}

void XCal_hu_InterruptGlobalEnable(XCal_hu *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCal_hu_WriteReg(InstancePtr->Control_bus_BaseAddress, XCAL_HU_CONTROL_BUS_ADDR_GIE, 1);
}

void XCal_hu_InterruptGlobalDisable(XCal_hu *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCal_hu_WriteReg(InstancePtr->Control_bus_BaseAddress, XCAL_HU_CONTROL_BUS_ADDR_GIE, 0);
}

void XCal_hu_InterruptEnable(XCal_hu *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XCal_hu_ReadReg(InstancePtr->Control_bus_BaseAddress, XCAL_HU_CONTROL_BUS_ADDR_IER);
    XCal_hu_WriteReg(InstancePtr->Control_bus_BaseAddress, XCAL_HU_CONTROL_BUS_ADDR_IER, Register | Mask);
}

void XCal_hu_InterruptDisable(XCal_hu *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XCal_hu_ReadReg(InstancePtr->Control_bus_BaseAddress, XCAL_HU_CONTROL_BUS_ADDR_IER);
    XCal_hu_WriteReg(InstancePtr->Control_bus_BaseAddress, XCAL_HU_CONTROL_BUS_ADDR_IER, Register & (~Mask));
}

void XCal_hu_InterruptClear(XCal_hu *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XCal_hu_WriteReg(InstancePtr->Control_bus_BaseAddress, XCAL_HU_CONTROL_BUS_ADDR_ISR, Mask);
}

u32 XCal_hu_InterruptGetEnabled(XCal_hu *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XCal_hu_ReadReg(InstancePtr->Control_bus_BaseAddress, XCAL_HU_CONTROL_BUS_ADDR_IER);
}

u32 XCal_hu_InterruptGetStatus(XCal_hu *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XCal_hu_ReadReg(InstancePtr->Control_bus_BaseAddress, XCAL_HU_CONTROL_BUS_ADDR_ISR);
}

