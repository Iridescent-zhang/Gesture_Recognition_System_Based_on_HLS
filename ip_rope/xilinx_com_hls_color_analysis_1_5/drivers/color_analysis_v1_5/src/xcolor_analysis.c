// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xcolor_analysis.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XColor_analysis_CfgInitialize(XColor_analysis *InstancePtr, XColor_analysis_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_bus_BaseAddress = ConfigPtr->Control_bus_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XColor_analysis_Start(XColor_analysis *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XColor_analysis_ReadReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_AP_CTRL) & 0x80;
    XColor_analysis_WriteReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_AP_CTRL, Data | 0x01);
}

u32 XColor_analysis_IsDone(XColor_analysis *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XColor_analysis_ReadReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XColor_analysis_IsIdle(XColor_analysis *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XColor_analysis_ReadReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XColor_analysis_IsReady(XColor_analysis *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XColor_analysis_ReadReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XColor_analysis_EnableAutoRestart(XColor_analysis *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XColor_analysis_WriteReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_AP_CTRL, 0x80);
}

void XColor_analysis_DisableAutoRestart(XColor_analysis *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XColor_analysis_WriteReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_AP_CTRL, 0);
}

void XColor_analysis_Set_rows(XColor_analysis *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XColor_analysis_WriteReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_ROWS_DATA, Data);
}

u32 XColor_analysis_Get_rows(XColor_analysis *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XColor_analysis_ReadReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_ROWS_DATA);
    return Data;
}

void XColor_analysis_Set_cols(XColor_analysis *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XColor_analysis_WriteReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_COLS_DATA, Data);
}

u32 XColor_analysis_Get_cols(XColor_analysis *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XColor_analysis_ReadReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_COLS_DATA);
    return Data;
}

void XColor_analysis_Set_cb_lower(XColor_analysis *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XColor_analysis_WriteReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_CB_LOWER_DATA, Data);
}

u32 XColor_analysis_Get_cb_lower(XColor_analysis *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XColor_analysis_ReadReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_CB_LOWER_DATA);
    return Data;
}

void XColor_analysis_Set_cb_upper(XColor_analysis *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XColor_analysis_WriteReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_CB_UPPER_DATA, Data);
}

u32 XColor_analysis_Get_cb_upper(XColor_analysis *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XColor_analysis_ReadReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_CB_UPPER_DATA);
    return Data;
}

void XColor_analysis_Set_cr_lower(XColor_analysis *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XColor_analysis_WriteReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_CR_LOWER_DATA, Data);
}

u32 XColor_analysis_Get_cr_lower(XColor_analysis *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XColor_analysis_ReadReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_CR_LOWER_DATA);
    return Data;
}

void XColor_analysis_Set_cr_upper(XColor_analysis *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XColor_analysis_WriteReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_CR_UPPER_DATA, Data);
}

u32 XColor_analysis_Get_cr_upper(XColor_analysis *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XColor_analysis_ReadReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_CR_UPPER_DATA);
    return Data;
}

void XColor_analysis_InterruptGlobalEnable(XColor_analysis *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XColor_analysis_WriteReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_GIE, 1);
}

void XColor_analysis_InterruptGlobalDisable(XColor_analysis *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XColor_analysis_WriteReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_GIE, 0);
}

void XColor_analysis_InterruptEnable(XColor_analysis *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XColor_analysis_ReadReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_IER);
    XColor_analysis_WriteReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_IER, Register | Mask);
}

void XColor_analysis_InterruptDisable(XColor_analysis *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XColor_analysis_ReadReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_IER);
    XColor_analysis_WriteReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_IER, Register & (~Mask));
}

void XColor_analysis_InterruptClear(XColor_analysis *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XColor_analysis_WriteReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_ISR, Mask);
}

u32 XColor_analysis_InterruptGetEnabled(XColor_analysis *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XColor_analysis_ReadReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_IER);
}

u32 XColor_analysis_InterruptGetStatus(XColor_analysis *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XColor_analysis_ReadReg(InstancePtr->Control_bus_BaseAddress, XCOLOR_ANALYSIS_CONTROL_BUS_ADDR_ISR);
}

