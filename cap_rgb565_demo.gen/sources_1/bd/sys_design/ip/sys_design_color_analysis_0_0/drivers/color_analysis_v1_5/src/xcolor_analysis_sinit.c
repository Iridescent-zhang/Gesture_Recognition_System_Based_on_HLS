// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xcolor_analysis.h"

extern XColor_analysis_Config XColor_analysis_ConfigTable[];

XColor_analysis_Config *XColor_analysis_LookupConfig(u16 DeviceId) {
	XColor_analysis_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XCOLOR_ANALYSIS_NUM_INSTANCES; Index++) {
		if (XColor_analysis_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XColor_analysis_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XColor_analysis_Initialize(XColor_analysis *InstancePtr, u16 DeviceId) {
	XColor_analysis_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XColor_analysis_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XColor_analysis_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

