// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xcal_hu.h"

extern XCal_hu_Config XCal_hu_ConfigTable[];

XCal_hu_Config *XCal_hu_LookupConfig(u16 DeviceId) {
	XCal_hu_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XCAL_HU_NUM_INSTANCES; Index++) {
		if (XCal_hu_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XCal_hu_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XCal_hu_Initialize(XCal_hu *InstancePtr, u16 DeviceId) {
	XCal_hu_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XCal_hu_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XCal_hu_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

