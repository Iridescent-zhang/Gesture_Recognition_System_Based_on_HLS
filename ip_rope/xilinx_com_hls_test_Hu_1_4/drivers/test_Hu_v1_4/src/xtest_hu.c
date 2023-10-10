// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xtest_hu.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XTest_hu_CfgInitialize(XTest_hu *InstancePtr, XTest_hu_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_bus_BaseAddress = ConfigPtr->Control_bus_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XTest_hu_Start(XTest_hu *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTest_hu_ReadReg(InstancePtr->Control_bus_BaseAddress, XTEST_HU_CONTROL_BUS_ADDR_AP_CTRL) & 0x80;
    XTest_hu_WriteReg(InstancePtr->Control_bus_BaseAddress, XTEST_HU_CONTROL_BUS_ADDR_AP_CTRL, Data | 0x01);
}

u32 XTest_hu_IsDone(XTest_hu *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTest_hu_ReadReg(InstancePtr->Control_bus_BaseAddress, XTEST_HU_CONTROL_BUS_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XTest_hu_IsIdle(XTest_hu *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTest_hu_ReadReg(InstancePtr->Control_bus_BaseAddress, XTEST_HU_CONTROL_BUS_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XTest_hu_IsReady(XTest_hu *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTest_hu_ReadReg(InstancePtr->Control_bus_BaseAddress, XTEST_HU_CONTROL_BUS_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XTest_hu_EnableAutoRestart(XTest_hu *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTest_hu_WriteReg(InstancePtr->Control_bus_BaseAddress, XTEST_HU_CONTROL_BUS_ADDR_AP_CTRL, 0x80);
}

void XTest_hu_DisableAutoRestart(XTest_hu *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTest_hu_WriteReg(InstancePtr->Control_bus_BaseAddress, XTEST_HU_CONTROL_BUS_ADDR_AP_CTRL, 0);
}

void XTest_hu_InterruptGlobalEnable(XTest_hu *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTest_hu_WriteReg(InstancePtr->Control_bus_BaseAddress, XTEST_HU_CONTROL_BUS_ADDR_GIE, 1);
}

void XTest_hu_InterruptGlobalDisable(XTest_hu *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTest_hu_WriteReg(InstancePtr->Control_bus_BaseAddress, XTEST_HU_CONTROL_BUS_ADDR_GIE, 0);
}

void XTest_hu_InterruptEnable(XTest_hu *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XTest_hu_ReadReg(InstancePtr->Control_bus_BaseAddress, XTEST_HU_CONTROL_BUS_ADDR_IER);
    XTest_hu_WriteReg(InstancePtr->Control_bus_BaseAddress, XTEST_HU_CONTROL_BUS_ADDR_IER, Register | Mask);
}

void XTest_hu_InterruptDisable(XTest_hu *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XTest_hu_ReadReg(InstancePtr->Control_bus_BaseAddress, XTEST_HU_CONTROL_BUS_ADDR_IER);
    XTest_hu_WriteReg(InstancePtr->Control_bus_BaseAddress, XTEST_HU_CONTROL_BUS_ADDR_IER, Register & (~Mask));
}

void XTest_hu_InterruptClear(XTest_hu *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTest_hu_WriteReg(InstancePtr->Control_bus_BaseAddress, XTEST_HU_CONTROL_BUS_ADDR_ISR, Mask);
}

u32 XTest_hu_InterruptGetEnabled(XTest_hu *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XTest_hu_ReadReg(InstancePtr->Control_bus_BaseAddress, XTEST_HU_CONTROL_BUS_ADDR_IER);
}

u32 XTest_hu_InterruptGetStatus(XTest_hu *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XTest_hu_ReadReg(InstancePtr->Control_bus_BaseAddress, XTEST_HU_CONTROL_BUS_ADDR_ISR);
}

