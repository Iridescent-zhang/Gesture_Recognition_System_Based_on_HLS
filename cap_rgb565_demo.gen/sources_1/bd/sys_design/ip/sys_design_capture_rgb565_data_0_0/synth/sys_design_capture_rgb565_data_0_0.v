// (c) Copyright 1995-2023 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: zzw:zzw:capture_rgb565_data:1.0
// IP Revision: 3

(* X_CORE_INFO = "capture_rgb565_data,Vivado 2022.2" *)
(* CHECK_LICENSE_TYPE = "sys_design_capture_rgb565_data_0_0,capture_rgb565_data,{}" *)
(* IP_DEFINITION_SOURCE = "package_project" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module sys_design_capture_rgb565_data_0_0 (
  clk_cmos,
  rst_n,
  cmos_pclk,
  cmos_xclk,
  cmos_vsync,
  cmos_href,
  cmos_rst_n,
  cmos_pwdn,
  cmos_data,
  cmos_frame_vsync,
  cmos_frame_href,
  cmos_frame_data,
  cmos_frame_clk,
  cmos_frame_clken,
  cmos_fps_rate
);

input wire clk_cmos;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst_n RST" *)
input wire rst_n;
input wire cmos_pclk;
output wire cmos_xclk;
input wire cmos_vsync;
input wire cmos_href;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME cmos_rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 cmos_rst_n RST" *)
output wire cmos_rst_n;
output wire cmos_pwdn;
input wire [7 : 0] cmos_data;
(* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 rgb565 VSYNC" *)
output wire cmos_frame_vsync;
(* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 rgb565 ACTIVE_VIDEO" *)
output wire cmos_frame_href;
(* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 rgb565 DATA" *)
output wire [23 : 0] cmos_frame_data;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME cmos_frame_clk, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN sys_design_capture_rgb565_data_0_0_cmos_frame_clk, INSERT_VIP 0, FREQ_TOLERANCE_HZ 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 cmos_frame_clk CLK" *)
output wire cmos_frame_clk;
output wire cmos_frame_clken;
output wire [7 : 0] cmos_fps_rate;

  capture_rgb565_data #(
    .CMOS_FRAME_WAITCNT(10),
    .CLOCK_CMOS(24000000)
  ) inst (
    .clk_cmos(clk_cmos),
    .rst_n(rst_n),
    .cmos_pclk(cmos_pclk),
    .cmos_xclk(cmos_xclk),
    .cmos_vsync(cmos_vsync),
    .cmos_href(cmos_href),
    .cmos_rst_n(cmos_rst_n),
    .cmos_pwdn(cmos_pwdn),
    .cmos_data(cmos_data),
    .cmos_frame_vsync(cmos_frame_vsync),
    .cmos_frame_href(cmos_frame_href),
    .cmos_frame_data(cmos_frame_data),
    .cmos_frame_clk(cmos_frame_clk),
    .cmos_frame_clken(cmos_frame_clken),
    .cmos_fps_rate(cmos_fps_rate)
  );
endmodule
