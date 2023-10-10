// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xtest_area_prmter.h"

extern XTest_area_prmter_Config XTest_area_prmter_ConfigTable[];

XTest_area_prmter_Config *XTest_area_prmter_LookupConfig(u16 DeviceId) {
	XTest_area_prmter_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XTEST_AREA_PRMTER_NUM_INSTANCES; Index++) {
		if (XTest_area_prmter_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XTest_area_prmter_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XTest_area_prmter_Initialize(XTest_area_prmter *InstancePtr, u16 DeviceId) {
	XTest_area_prmter_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XTest_area_prmter_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XTest_area_prmter_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

