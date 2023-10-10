// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xtest_area_prmter.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XTest_area_prmter_CfgInitialize(XTest_area_prmter *InstancePtr, XTest_area_prmter_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->Control_bus_BaseAddress = ConfigPtr->Control_bus_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XTest_area_prmter_Start(XTest_area_prmter *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTest_area_prmter_ReadReg(InstancePtr->Control_bus_BaseAddress, XTEST_AREA_PRMTER_CONTROL_BUS_ADDR_AP_CTRL) & 0x80;
    XTest_area_prmter_WriteReg(InstancePtr->Control_bus_BaseAddress, XTEST_AREA_PRMTER_CONTROL_BUS_ADDR_AP_CTRL, Data | 0x01);
}

u32 XTest_area_prmter_IsDone(XTest_area_prmter *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTest_area_prmter_ReadReg(InstancePtr->Control_bus_BaseAddress, XTEST_AREA_PRMTER_CONTROL_BUS_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XTest_area_prmter_IsIdle(XTest_area_prmter *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTest_area_prmter_ReadReg(InstancePtr->Control_bus_BaseAddress, XTEST_AREA_PRMTER_CONTROL_BUS_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XTest_area_prmter_IsReady(XTest_area_prmter *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTest_area_prmter_ReadReg(InstancePtr->Control_bus_BaseAddress, XTEST_AREA_PRMTER_CONTROL_BUS_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XTest_area_prmter_EnableAutoRestart(XTest_area_prmter *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTest_area_prmter_WriteReg(InstancePtr->Control_bus_BaseAddress, XTEST_AREA_PRMTER_CONTROL_BUS_ADDR_AP_CTRL, 0x80);
}

void XTest_area_prmter_DisableAutoRestart(XTest_area_prmter *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTest_area_prmter_WriteReg(InstancePtr->Control_bus_BaseAddress, XTEST_AREA_PRMTER_CONTROL_BUS_ADDR_AP_CTRL, 0);
}

void XTest_area_prmter_Set_result_r(XTest_area_prmter *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTest_area_prmter_WriteReg(InstancePtr->Control_BaseAddress, XTEST_AREA_PRMTER_CONTROL_ADDR_RESULT_R_DATA, (u32)(Data));
    XTest_area_prmter_WriteReg(InstancePtr->Control_BaseAddress, XTEST_AREA_PRMTER_CONTROL_ADDR_RESULT_R_DATA + 4, (u32)(Data >> 32));
}

u64 XTest_area_prmter_Get_result_r(XTest_area_prmter *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XTest_area_prmter_ReadReg(InstancePtr->Control_BaseAddress, XTEST_AREA_PRMTER_CONTROL_ADDR_RESULT_R_DATA);
    Data += (u64)XTest_area_prmter_ReadReg(InstancePtr->Control_BaseAddress, XTEST_AREA_PRMTER_CONTROL_ADDR_RESULT_R_DATA + 4) << 32;
    return Data;
}

void XTest_area_prmter_InterruptGlobalEnable(XTest_area_prmter *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTest_area_prmter_WriteReg(InstancePtr->Control_bus_BaseAddress, XTEST_AREA_PRMTER_CONTROL_BUS_ADDR_GIE, 1);
}

void XTest_area_prmter_InterruptGlobalDisable(XTest_area_prmter *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTest_area_prmter_WriteReg(InstancePtr->Control_bus_BaseAddress, XTEST_AREA_PRMTER_CONTROL_BUS_ADDR_GIE, 0);
}

void XTest_area_prmter_InterruptEnable(XTest_area_prmter *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XTest_area_prmter_ReadReg(InstancePtr->Control_bus_BaseAddress, XTEST_AREA_PRMTER_CONTROL_BUS_ADDR_IER);
    XTest_area_prmter_WriteReg(InstancePtr->Control_bus_BaseAddress, XTEST_AREA_PRMTER_CONTROL_BUS_ADDR_IER, Register | Mask);
}

void XTest_area_prmter_InterruptDisable(XTest_area_prmter *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XTest_area_prmter_ReadReg(InstancePtr->Control_bus_BaseAddress, XTEST_AREA_PRMTER_CONTROL_BUS_ADDR_IER);
    XTest_area_prmter_WriteReg(InstancePtr->Control_bus_BaseAddress, XTEST_AREA_PRMTER_CONTROL_BUS_ADDR_IER, Register & (~Mask));
}

void XTest_area_prmter_InterruptClear(XTest_area_prmter *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XTest_area_prmter_WriteReg(InstancePtr->Control_bus_BaseAddress, XTEST_AREA_PRMTER_CONTROL_BUS_ADDR_ISR, Mask);
}

u32 XTest_area_prmter_InterruptGetEnabled(XTest_area_prmter *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XTest_area_prmter_ReadReg(InstancePtr->Control_bus_BaseAddress, XTEST_AREA_PRMTER_CONTROL_BUS_ADDR_IER);
}

u32 XTest_area_prmter_InterruptGetStatus(XTest_area_prmter *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XTest_area_prmter_ReadReg(InstancePtr->Control_bus_BaseAddress, XTEST_AREA_PRMTER_CONTROL_BUS_ADDR_ISR);
}

