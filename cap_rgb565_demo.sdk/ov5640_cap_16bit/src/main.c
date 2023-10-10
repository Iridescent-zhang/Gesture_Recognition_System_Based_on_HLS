//****************************************Copyright (c)***********************************//
//ԭ�Ӹ����߽�ѧƽ̨��www.yuanzige.com
//����֧�֣�www.openedv.com
//�Ա����̣�http://openedv.taobao.com
//��ע΢�Ź���ƽ̨΢�źţ�"����ԭ��"����ѻ�ȡZYNQ & FPGA & STM32 & LINUX���ϡ�
//��Ȩ���У�����ؾ���
//Copyright(C) ����ԭ�� 2018-2028
//All rights reserved
//----------------------------------------------------------------------------------------
// File name:           main.c
// Last modified Date:  2019/07/07 15:59:46
// Last Version:        V1.0
// Descriptions:        OV5640����ͷ����LCDʾ��
//----------------------------------------------------------------------------------------
// Created by:          ����ԭ��
// Created date:        2019/07/07 15:59:52
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

/***************************** Include Files *********************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "xil_types.h"
#include "xil_cache.h"
#include "xparameters.h"
#include "xaxivdma.h"
#include "xaxivdma_i.h"
#include "display_ctrl_hdmi/display_ctrl.h"
#include "vdma_api/vdma_api.h"
#include "emio_sccb_cfg/emio_sccb_cfg.h"
#include "ov5640/ov5640_init.h"
#include "sleep.h"
#include "xil_io.h"

//�궨��
#define DYNCLK_BASEADDR  XPAR_AXI_DYNCLK_0_BASEADDR  //��̬ʱ�ӻ���ַ
#define VDMA_ID          XPAR_AXIVDMA_0_DEVICE_ID    //VDMA����ID
#define DISP_VTC_ID      XPAR_VTC_0_DEVICE_ID        //VTC����ID

//ȫ�ֱ���
//frame buffer����ʼ��ַ
unsigned int const frame_buffer_addr = (XPAR_PS7_DDR_0_S_AXI_BASEADDR
										+ 0x1000000);
XAxiVdma     vdma;
DisplayCtrl  dispCtrl;
VideoMode    vd_mode;

int main(void)
{
	u16 cmos_h_pixel;                    //ov5640 DVP ���ˮƽ���ص���
	u16 cmos_v_pixel;                    //ov5640 DVP �����ֱ���ص���
	u16 total_h_pixel;                   //ov5640 ˮƽ�����ش�С
	u16 total_v_pixel;                   //ov5640 ��ֱ�����ش�С

	cmos_h_pixel = 1280;                 //����OV5640����ֱ���Ϊ1280*720
	cmos_v_pixel = 720;
	total_h_pixel = 2570;
	total_v_pixel = 980;

	emio_init();                         //��ʼ��EMIO
	ov5640_init( cmos_h_pixel,  //��ʼ��ov5640
				cmos_v_pixel,
				total_h_pixel,
				total_v_pixel);

	vd_mode = VMODE_1280x720;

	//����VDMA
	run_vdma_frame_buffer(&vdma, VDMA_ID, vd_mode.width, vd_mode.height,
							frame_buffer_addr,0,0,BOTH);
    //��ʼ��Display controller
	DisplayInitialize(&dispCtrl, DISP_VTC_ID, DYNCLK_BASEADDR);
    //����VideoMode
	DisplaySetMode(&dispCtrl, &vd_mode);
	DisplayStart(&dispCtrl);
    return 0;
}
 
