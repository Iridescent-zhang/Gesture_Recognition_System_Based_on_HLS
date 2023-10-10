#----------------------摄像头接口的时钟---------------------------
create_clock -period 41.600 -name cam_pclk -waveform {0.000 20.800} [get_ports cmos_pclk]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets cmos_pclk_IBUF]

#----------------------HDMI接口---------------------------
set_property PACKAGE_PIN J18 [get_ports {TMDS_tmds_data_p[2]}]
set_property PACKAGE_PIN K19 [get_ports {TMDS_tmds_data_p[1]}]
set_property PACKAGE_PIN K17 [get_ports {TMDS_tmds_data_p[0]}]
set_property PACKAGE_PIN L16 [get_ports TMDS_tmds_clk_p]

#----------------------摄像头接�?---------------------------
set_property PACKAGE_PIN Y14 [get_ports cmos_xclk]
set_property IOSTANDARD LVCMOS33 [get_ports cmos_xclk]
set_property PACKAGE_PIN W13 [get_ports {emio_sccb_tri_io[0]}]
set_property PACKAGE_PIN T10 [get_ports {emio_sccb_tri_io[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {emio_sccb_tri_io[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {emio_sccb_tri_io[0]}]
set_property PACKAGE_PIN U18 [get_ports cmos_rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports cmos_rst_n]
set_property PACKAGE_PIN T11 [get_ports cmos_href]
set_property PACKAGE_PIN W16 [get_ports cmos_pclk]
set_property PACKAGE_PIN Y18 [get_ports cmos_pwdn]
set_property PACKAGE_PIN V12 [get_ports cmos_vsync]
set_property IOSTANDARD LVCMOS33 [get_ports cmos_href]
set_property IOSTANDARD LVCMOS33 [get_ports cmos_pclk]
set_property IOSTANDARD LVCMOS33 [get_ports cmos_pwdn]
set_property IOSTANDARD LVCMOS33 [get_ports cmos_vsync]
set_property PULLUP true [get_ports {emio_sccb_tri_io[1]}]
set_property PULLUP true [get_ports {emio_sccb_tri_io[0]}]

set_property PACKAGE_PIN V16 [get_ports {cmos_data[7]}]
set_property PACKAGE_PIN W14 [get_ports {cmos_data[6]}]
set_property PACKAGE_PIN W19 [get_ports {cmos_data[5]}]
set_property PACKAGE_PIN Y17 [get_ports {cmos_data[4]}]
set_property PACKAGE_PIN W18 [get_ports {cmos_data[3]}]
set_property PACKAGE_PIN Y16 [get_ports {cmos_data[2]}]
set_property PACKAGE_PIN U19 [get_ports {cmos_data[1]}]
set_property PACKAGE_PIN Y19 [get_ports {cmos_data[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos_data[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos_data[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos_data[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos_data[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos_data[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos_data[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos_data[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos_data[0]}]

##LEDs

set_property -dict { PACKAGE_PIN R14   IOSTANDARD LVCMOS33 } [get_ports { led[0] }]; #IO_L6N_T0_VREF_34 Sch=led[0]
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { led[1] }]; #IO_L6P_T0_34 Sch=led[1]
set_property -dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { led[2] }]; #IO_L21N_T3_DQS_AD14N_35 Sch=led[2]
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { led[3] }]; #IO_L23P_T3_35 Sch=led[3]


