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
#define  OV7725_DEV_ID    0x42   //OV7725 SCCB器件地址

//SCCB写寄存器
void sccb_write_reg8(u8 addr , u8 data)
{

	sccb_start();

	sccb_send_byte(OV7725_DEV_ID);
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

	sccb_send_byte(OV7725_DEV_ID);
	sccb_ack();

	sccb_send_byte(addr);
	sccb_ack();

  	sccb_stop();

  	sccb_start();

	sccb_send_byte(OV7725_DEV_ID | 0x01);
	sccb_ack();

	rxd = sccb_rece_byte();
	sccb_ack();

  	sccb_stop();

  	return  rxd ;
}

//OV7725初始化
void ov7725_init()
{
    u16 cam_id = 0;
    //读OV7725摄像头ID
    cam_id = sccb_read_reg8(0x0B);
    cam_id |= sccb_read_reg8(0x0A) << 8;
    printf("cam_id = 0x%x\n", cam_id);
	sccb_write_reg8(0x12,0x80);    // BIT[7]-Reset all the Reg
	usleep(1000);

	sccb_write_reg8 (0x3d, 0x03) ; //COM12 模拟过程直流补偿
	sccb_write_reg8 (0x15, 0x02) ; //COM10 href/vsync/pclk/data信号控制(Vsync H valid)
	sccb_write_reg8 (0x17, 0x23) ; //HSTART 水平起始位置
	sccb_write_reg8 (0x18, 0xa0) ; //HSIZE 水平尺寸
	sccb_write_reg8 (0x19, 0x07) ; //VSTRT 垂直起始位置
	sccb_write_reg8 (0x1a, 0xf0) ; //VSIZE 垂直尺寸
	sccb_write_reg8 (0x32, 0x00) ; //HREF 图像开始和尺寸控制，控制低位
	sccb_write_reg8 (0x29, 0xa0) ; //HOutSize 水平输出尺寸
	sccb_write_reg8 (0x2a, 0x00) ; //EXHCH 虚拟像素MSB
	sccb_write_reg8 (0x2b, 0x00) ; //EXHCL 虚拟像素LSB
	sccb_write_reg8 (0x2c, 0xf0) ; //VOutSize 垂直输出尺寸

	sccb_write_reg8 (0x0d, 0x41) ; //COM4 PLL倍频设置(multiplier)
										//	Bit[7:6]:  0:1x 1:4x 2:6x 3:8x
	sccb_write_reg8 (0x11, 0x01) ; //CLKRC 内部时钟配置
										//	Freq=multiplier/[(CLKRC[5:0]+1)*2]
		//PCLK = 内部时钟 = 输入时钟 × multiplier / [(CLKRC[5:0] + 1) × 2]
		//OV7725的外部时钟24MHz，所以 PCLK = 24MHz * 4 / [ (1+1) * 2 ] =24MHz

	sccb_write_reg8 (0x12, 0x06) ; //COM7 输出VGA	RGB565  	RBG格式
//		sccb_write_reg8 (0x12, 0x03) ; //COM7 输出VGA	GBR4:2:2	RAW格式
//		sccb_write_reg8 (0x12, 0x04) ; //COM7 输出VGA	RGB565		YUV格式
	//BIT[6]:	0:VGA; 1;QVGA
	//BIT[3:2]:	01:RGB565
	//VGA:	00:YUV; 01:Processed Bayer RGB; 10:RGB;	11:Bayer RAW; BIT[7]-Reset all the Reg

	sccb_write_reg8 (0x0c, 0x10) ; //COM3 Bit[0]: 0:图像数据 1:彩条测试
		//DSP 控制
	sccb_write_reg8 (0x42, 0x7f) ; //TGT_B 黑电平校准蓝色通道目标值
	sccb_write_reg8 (0x4d, 0x09) ; //FixGain 模拟增益放大器
	sccb_write_reg8 (0x63, 0xf0) ; //AWB_Ctrl0 自动白平衡控制字节0
	sccb_write_reg8 (0x64, 0xff) ; //DSP_Ctrl1 DSP控制字节1
	sccb_write_reg8 (0x65, 0x00) ; //DSP_Ctrl2 DSP控制字节2
	sccb_write_reg8 (0x66, 0x00) ; //DSP_Ctrl3 DSP控制字节3
	sccb_write_reg8 (0x67, 0x00) ; //DSP_Ctrl4:[1:0]00/01: YUV or RGB; 10: RAW8; 11: RAW10
	//sccb_write_reg8 (0x67, 0x02) ;
		//AGC AEC AWB
		//COM8 Bit[2]:自动增益使能 Bit[1]:自动白平衡使能 Bit[0]:自动曝光功能
	sccb_write_reg8 (0x13, 0xff) ; //COM8
	sccb_write_reg8 (0x0f, 0xc5) ; //COM6
	sccb_write_reg8 (0x14, 0x11) ;
	sccb_write_reg8 (0x22, 0x98) ;
	sccb_write_reg8 (0x23, 0x03) ;
	sccb_write_reg8 (0x24, 0x40) ;
	sccb_write_reg8 (0x25, 0x30) ;
	sccb_write_reg8 (0x26, 0xa1) ;
	sccb_write_reg8 (0x6b, 0xaa) ;
	sccb_write_reg8 (0x13, 0xff) ;
		//matrix sharpness brightness contrast UV
	sccb_write_reg8 (0x90, 0x0a) ; //EDGE1 边缘增强控制1
		//DNSOff 降噪阈值下限,仅在自动模式下有效
	sccb_write_reg8 (0x91, 0x01) ; //DNSOff
	sccb_write_reg8 (0x92, 0x01) ; //EDGE2 锐度(边缘增强)强度上限
	sccb_write_reg8 (0x93, 0x01) ; //EDGE3 锐度(边缘增强)强度下限
	sccb_write_reg8 (0x94, 0x5f) ; //MTX1 矩阵系数1
	sccb_write_reg8 (0x95, 0x53) ; //MTX1 矩阵系数2
	sccb_write_reg8 (0x96, 0x11) ; //MTX1 矩阵系数3
	sccb_write_reg8 (0x97, 0x1a) ; //MTX1 矩阵系数4
	sccb_write_reg8 (0x98, 0x3d) ; //MTX1 矩阵系数5
	sccb_write_reg8 (0x99, 0x5a) ; //MTX1 矩阵系数6
	sccb_write_reg8 (0x9a, 0x1e) ; //MTX_Ctrl 矩阵控制
	sccb_write_reg8 (0x9b, 0x3f) ; //BRIGHT 亮度
	sccb_write_reg8 (0x9c, 0x25) ; //CNST 对比度
	sccb_write_reg8 (0x9e, 0x81) ;
	sccb_write_reg8 (0xa6, 0x06) ; //SDE 特殊数字效果控制
	sccb_write_reg8 (0xa7, 0x65) ; //USAT "U"饱和增益
	sccb_write_reg8 (0xa8, 0x65) ; //VSAT "V"饱和增益
	sccb_write_reg8 (0xa9, 0x80) ; //VSAT "V"饱和增益
	sccb_write_reg8 (0xaa, 0x80) ; //VSAT "V"饱和增益
		//伽马控制
	sccb_write_reg8 (0x7e, 0x0c) ;
	sccb_write_reg8 (0x7f, 0x16) ;
	sccb_write_reg8 (0x80, 0x2a) ;
	sccb_write_reg8 (0x81, 0x4e) ;
	sccb_write_reg8 (0x82, 0x61) ;
	sccb_write_reg8 (0x83, 0x6f) ;
	sccb_write_reg8 (0x84, 0x7b) ;
	sccb_write_reg8 (0x85, 0x86) ;
	sccb_write_reg8 (0x86, 0x8e) ;
	sccb_write_reg8 (0x87, 0x97) ;
	sccb_write_reg8 (0x88, 0xa4) ;
	sccb_write_reg8 (0x89, 0xaf) ;
	sccb_write_reg8 (0x8a, 0xc5) ;
	sccb_write_reg8 (0x8b, 0xd7) ;
	sccb_write_reg8 (0x8c, 0xe8) ;
	sccb_write_reg8 (0x8d, 0x20) ;

	sccb_write_reg8 (0x0e,0x65) ; //COM5
	sccb_write_reg8 (0x09,0x00) ; //COM2  Bit[1:0] 输出电流驱动能力
}
