//****************************************Copyright (c)***********************************//
//原子哥在线教学平台：www.yuanzige.com
//技术支持：www.openedv.com
//淘宝店铺：http://openedv.taobao.com
//关注微信公众平台微信号："正点原子"，免费获取ZYNQ & FPGA & STM32 & LINUX资料。
//版权所有，盗版必究。
//Copyright(C) 正点原子 2018-2028
//All rights reserved
//----------------------------------------------------------------------------------------
// File name:           ov7725_init.c
// Last modified Date:  2019/06/30 15:59:46
// Last Version:        V1.0
// Descriptions:        OV7725配置初始化
//----------------------------------------------------------------------------------------
// Created by:          正点原子
// Created date:        2019/06/30 15:59:52
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

#include "../emio_sccb_cfg/emio_sccb_cfg.h"
#include <stdio.h>
#define  OV7670_DEV_ID    0x42   //OV7670 SCCB器件地址

//SCCB写寄存器
void sccb_write_reg8(u8 addr , u8 data)
{

	sccb_start();

	sccb_send_byte(OV7670_DEV_ID);
	sccb_ack();

	sccb_send_byte(addr);
	sccb_ack();

	sccb_send_byte(data);
	sccb_ack();

  	sccb_stop();
}

//SCCB读寄存器
u8 sccb_read_reg8(u8 addr )
{
	u8 rxd;

	sccb_start();

	sccb_send_byte(OV7670_DEV_ID);
	sccb_ack();

	sccb_send_byte(addr);
	sccb_ack();

  	sccb_stop();

  	sccb_start();

	sccb_send_byte(OV7670_DEV_ID | 0x01);
	sccb_ack();

	rxd = sccb_rece_byte();
	sccb_ack();

  	sccb_stop();

  	return  rxd ;
}

//OV7670初始化
u8 ov7670_init(void)
{
    u16 cam_id = 0;
    //读OV7670摄像头ID
    cam_id = sccb_read_reg8(0x0B);
    cam_id |= sccb_read_reg8(0x0A) << 8;
    printf("cam_id = 0x%x\n", cam_id);
    /*OV7670 VGA RGB565参数  */
    sccb_write_reg8 (0x12, 0x04);//04:RGB565, 01:RAW, 00:YUV,
    sccb_write_reg8 (0x40, 0xd0);//d0:00-ff,RGB565, 80:01-fe,YUV
    sccb_write_reg8 (0x3a, 0x04);
    sccb_write_reg8 (0x3d, 0xc8);//设置YUV输出格式

    //输出窗口设置
    sccb_write_reg8 (0x32, 0xb6);
    sccb_write_reg8 (0x17, 0x13);
    sccb_write_reg8 (0x18, 0x01);
    sccb_write_reg8 (0x19, 0x02);
    sccb_write_reg8 (0x1a, 0x7a);
    sccb_write_reg8 (0x03, 0x0a);

    sccb_write_reg8 (0x0c, 0x00);
    sccb_write_reg8 (0x15, 0x02);
    sccb_write_reg8 (0x3e, 0x00);
    sccb_write_reg8 (0x70, 0x00);
    sccb_write_reg8 (0x71, 0x01);
    sccb_write_reg8 (0x72, 0x11);
    sccb_write_reg8 (0x73, 0x00);

    sccb_write_reg8 (0xa2, 0x02);
    sccb_write_reg8 (0x11, 0x80);
    sccb_write_reg8 (0x7a, 0x20);
    sccb_write_reg8 (0x7b, 0x1c);
    sccb_write_reg8 (0x7c, 0x28);

    sccb_write_reg8 (0x7d, 0x3c);
    sccb_write_reg8 (0x7e, 0x55);
    sccb_write_reg8 (0x7f, 0x68);
    sccb_write_reg8 (0x80, 0x76);
    sccb_write_reg8 (0x81, 0x80);

    sccb_write_reg8 (0x82, 0x88);
    sccb_write_reg8 (0x83, 0x8f);
    sccb_write_reg8 (0x84, 0x96);
    sccb_write_reg8 (0x85, 0xa3);
    sccb_write_reg8 (0x86, 0xaf);

    sccb_write_reg8 (0x87, 0xc4);
    sccb_write_reg8 (0x88, 0xd7);
    sccb_write_reg8 (0x89, 0xe8);
    sccb_write_reg8 (0x13, 0xe0);
    sccb_write_reg8 (0x00, 0x00);

    sccb_write_reg8 (0x10, 0x00);
    sccb_write_reg8 (0x0d, 0x00);
    sccb_write_reg8 (0x14, 0x28);
    sccb_write_reg8 (0xa5, 0x05);
    sccb_write_reg8 (0xab, 0x07);

    sccb_write_reg8 (0x24, 0x75);
    sccb_write_reg8 (0x25, 0x63);
    sccb_write_reg8 (0x26, 0xa5);
    sccb_write_reg8 (0x9f, 0x78);
    sccb_write_reg8 (0xa0, 0x68);

    sccb_write_reg8 (0xa1, 0x03);
    sccb_write_reg8 (0xa6, 0xdf);
    sccb_write_reg8 (0xa7, 0xdf);
    sccb_write_reg8 (0xa8, 0xf0);
    sccb_write_reg8 (0xa9, 0x90);

    sccb_write_reg8 (0xaa, 0x94);
    sccb_write_reg8 (0x13, 0xef);
    sccb_write_reg8 (0x0e, 0x61);
    sccb_write_reg8 (0x0f, 0x4b);
    sccb_write_reg8 (0x16, 0x02);

    sccb_write_reg8 (0x1e, 0x11);
    sccb_write_reg8 (0x21, 0x02);
    sccb_write_reg8 (0x22, 0x91);
    sccb_write_reg8 (0x29, 0x07);
    sccb_write_reg8 (0x33, 0x0b);

    sccb_write_reg8 (0x35, 0x0b);
    sccb_write_reg8 (0x37, 0x1d);
    sccb_write_reg8 (0x38, 0x71);
    sccb_write_reg8 (0x39, 0x2a);
    sccb_write_reg8 (0x3c, 0x78);

    sccb_write_reg8 (0x4d, 0x40);
    sccb_write_reg8 (0x4e, 0x20);
    sccb_write_reg8 (0x69, 0x00);
    sccb_write_reg8 (0x6b, 0x00);
    sccb_write_reg8 (0x74, 0x19);
    sccb_write_reg8 (0x8d, 0x4f);

    sccb_write_reg8 (0x8e, 0x00);
    sccb_write_reg8 (0x8f, 0x00);
    sccb_write_reg8 (0x90, 0x00);
    sccb_write_reg8 (0x91, 0x00);
    sccb_write_reg8 (0x92, 0x00);

    sccb_write_reg8 (0x96, 0x00);
    sccb_write_reg8 (0x9a, 0x80);
    sccb_write_reg8 (0xb0, 0x84);
    sccb_write_reg8 (0xb1, 0x0c);
    sccb_write_reg8 (0xb2, 0x0e);

    sccb_write_reg8 (0xb3, 0x82);
    sccb_write_reg8 (0xb8, 0x0a);
    sccb_write_reg8 (0x43, 0x14);
    sccb_write_reg8 (0x44, 0xf0);
    sccb_write_reg8 (0x45, 0x34);

    sccb_write_reg8 (0x46, 0x58);
    sccb_write_reg8 (0x47, 0x28);
    sccb_write_reg8 (0x48, 0x3a);
    sccb_write_reg8 (0x59, 0x88);
    sccb_write_reg8 (0x5a, 0x88);

    sccb_write_reg8 (0x5b, 0x44);
    sccb_write_reg8 (0x5c, 0x67);
    sccb_write_reg8 (0x5d, 0x49);
    sccb_write_reg8 (0x5e, 0x0e);
    sccb_write_reg8 (0x64, 0x04);
    sccb_write_reg8 (0x65, 0x20);

    sccb_write_reg8 (0x66, 0x05);
    sccb_write_reg8 (0x94, 0x04);
    sccb_write_reg8 (0x95, 0x08);
    sccb_write_reg8 (0x6c, 0x0a);
    sccb_write_reg8 (0x6d, 0x55);

    sccb_write_reg8 (0x4f, 0x80);
    sccb_write_reg8 (0x50, 0x80);
    sccb_write_reg8 (0x51, 0x00);
    sccb_write_reg8 (0x52, 0x22);
    sccb_write_reg8 (0x53, 0x5e);
    sccb_write_reg8 (0x54, 0x80);

    sccb_write_reg8 (0x09, 0x03);
    sccb_write_reg8 (0x6e, 0x11);
    sccb_write_reg8 (0x6f, 0x9f);
    sccb_write_reg8 (0x55, 0x00);
    sccb_write_reg8 (0x56, 0x40);
    sccb_write_reg8 (0x57, 0x80);
    return 0;
}
