// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xtest_hu.h"

extern XTest_hu_Config XTest_hu_ConfigTable[];

XTest_hu_Config *XTest_hu_LookupConfig(u16 DeviceId) {
	XTest_hu_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XTEST_HU_NUM_INSTANCES; Index++) {
		if (XTest_hu_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XTest_hu_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XTest_hu_Initialize(XTest_hu *InstancePtr, u16 DeviceId) {
	XTest_hu_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XTest_hu_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XTest_hu_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

