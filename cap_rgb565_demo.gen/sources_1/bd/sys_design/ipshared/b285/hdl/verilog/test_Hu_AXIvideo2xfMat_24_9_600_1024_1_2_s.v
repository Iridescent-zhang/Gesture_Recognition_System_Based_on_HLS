// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Version: 2022.2
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module test_Hu_AXIvideo2xfMat_24_9_600_1024_1_2_s (
        ap_clk,
        ap_rst,
        ap_start,
        start_full_n,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        start_out,
        start_write,
        INPUT_STREAM_TDATA,
        INPUT_STREAM_TVALID,
        INPUT_STREAM_TREADY,
        INPUT_STREAM_TKEEP,
        INPUT_STREAM_TSTRB,
        INPUT_STREAM_TUSER,
        INPUT_STREAM_TLAST,
        INPUT_STREAM_TID,
        INPUT_STREAM_TDEST,
        img_0_data64_din,
        img_0_data64_num_data_valid,
        img_0_data64_fifo_cap,
        img_0_data64_full_n,
        img_0_data64_write,
        img_0_rows_c_din,
        img_0_rows_c_num_data_valid,
        img_0_rows_c_fifo_cap,
        img_0_rows_c_full_n,
        img_0_rows_c_write,
        img_0_cols_c_din,
        img_0_cols_c_num_data_valid,
        img_0_cols_c_fifo_cap,
        img_0_cols_c_full_n,
        img_0_cols_c_write
);

parameter    ap_ST_fsm_state1 = 10'd1;
parameter    ap_ST_fsm_state2 = 10'd2;
parameter    ap_ST_fsm_state3 = 10'd4;
parameter    ap_ST_fsm_state4 = 10'd8;
parameter    ap_ST_fsm_state5 = 10'd16;
parameter    ap_ST_fsm_state6 = 10'd32;
parameter    ap_ST_fsm_state7 = 10'd64;
parameter    ap_ST_fsm_state8 = 10'd128;
parameter    ap_ST_fsm_state9 = 10'd256;
parameter    ap_ST_fsm_state10 = 10'd512;

input   ap_clk;
input   ap_rst;
input   ap_start;
input   start_full_n;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
output   start_out;
output   start_write;
input  [23:0] INPUT_STREAM_TDATA;
input   INPUT_STREAM_TVALID;
output   INPUT_STREAM_TREADY;
input  [2:0] INPUT_STREAM_TKEEP;
input  [2:0] INPUT_STREAM_TSTRB;
input  [0:0] INPUT_STREAM_TUSER;
input  [0:0] INPUT_STREAM_TLAST;
input  [0:0] INPUT_STREAM_TID;
input  [0:0] INPUT_STREAM_TDEST;
output  [23:0] img_0_data64_din;
input  [1:0] img_0_data64_num_data_valid;
input  [1:0] img_0_data64_fifo_cap;
input   img_0_data64_full_n;
output   img_0_data64_write;
output  [9:0] img_0_rows_c_din;
input  [1:0] img_0_rows_c_num_data_valid;
input  [1:0] img_0_rows_c_fifo_cap;
input   img_0_rows_c_full_n;
output   img_0_rows_c_write;
output  [10:0] img_0_cols_c_din;
input  [1:0] img_0_cols_c_num_data_valid;
input  [1:0] img_0_cols_c_fifo_cap;
input   img_0_cols_c_full_n;
output   img_0_cols_c_write;

reg ap_done;
reg ap_idle;
reg start_write;
reg img_0_data64_write;
reg img_0_rows_c_write;
reg img_0_cols_c_write;

reg    real_start;
reg    start_once_reg;
reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [9:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    internal_ap_ready;
reg    img_0_rows_c_blk_n;
reg    img_0_cols_c_blk_n;
wire    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_ap_start;
wire    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_ap_done;
wire    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_ap_idle;
wire    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_ap_ready;
wire    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_INPUT_STREAM_TREADY;
wire   [0:0] grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_axi_last_V_out;
wire    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_axi_last_V_out_ap_vld;
wire   [23:0] grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_axi_data_V_out;
wire    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_axi_data_V_out_ap_vld;
wire    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_ap_start;
wire    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_ap_done;
wire    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_ap_idle;
wire    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_ap_ready;
wire   [23:0] grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_img_0_data64_din;
wire    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_img_0_data64_write;
wire    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_INPUT_STREAM_TREADY;
wire   [0:0] grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_last_out;
wire    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_last_out_ap_vld;
wire   [23:0] grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_axi_data_V_3_out;
wire    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_axi_data_V_3_out_ap_vld;
wire    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_ap_start;
wire    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_ap_done;
wire    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_ap_idle;
wire    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_ap_ready;
wire    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_INPUT_STREAM_TREADY;
wire   [0:0] grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_axi_last_V_4_out;
wire    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_axi_last_V_4_out_ap_vld;
wire   [23:0] grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_axi_data_V_4_out;
wire    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_axi_data_V_4_out_ap_vld;
reg   [0:0] start_reg_124;
wire    ap_CS_fsm_state4;
wire    ap_CS_fsm_state10;
reg   [0:0] axi_last_V_2_reg_138;
reg    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_ap_start_reg;
wire    ap_CS_fsm_state2;
wire    ap_CS_fsm_state3;
reg   [23:0] axi_data_V_2_fu_84;
reg    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_ap_start_reg;
wire    ap_CS_fsm_state5;
wire   [0:0] icmp_ln129_fu_229_p2;
wire    ap_CS_fsm_state6;
reg    grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_ap_start_reg;
wire    ap_CS_fsm_state8;
wire    ap_CS_fsm_state9;
reg   [0:0] axi_last_V_4_loc_fu_92;
reg   [9:0] i_fu_88;
wire   [9:0] i_4_fu_235_p2;
reg    ap_block_state1;
reg   [9:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
wire    ap_ST_fsm_state2_blk;
reg    ap_ST_fsm_state3_blk;
wire    ap_ST_fsm_state4_blk;
wire    ap_ST_fsm_state5_blk;
reg    ap_ST_fsm_state6_blk;
wire    ap_ST_fsm_state7_blk;
wire    ap_ST_fsm_state8_blk;
reg    ap_ST_fsm_state9_blk;
wire    ap_ST_fsm_state10_blk;
wire    regslice_both_INPUT_STREAM_V_data_V_U_apdone_blk;
wire   [23:0] INPUT_STREAM_TDATA_int_regslice;
wire    INPUT_STREAM_TVALID_int_regslice;
reg    INPUT_STREAM_TREADY_int_regslice;
wire    regslice_both_INPUT_STREAM_V_data_V_U_ack_in;
wire    regslice_both_INPUT_STREAM_V_keep_V_U_apdone_blk;
wire   [2:0] INPUT_STREAM_TKEEP_int_regslice;
wire    regslice_both_INPUT_STREAM_V_keep_V_U_vld_out;
wire    regslice_both_INPUT_STREAM_V_keep_V_U_ack_in;
wire    regslice_both_INPUT_STREAM_V_strb_V_U_apdone_blk;
wire   [2:0] INPUT_STREAM_TSTRB_int_regslice;
wire    regslice_both_INPUT_STREAM_V_strb_V_U_vld_out;
wire    regslice_both_INPUT_STREAM_V_strb_V_U_ack_in;
wire    regslice_both_INPUT_STREAM_V_user_V_U_apdone_blk;
wire   [0:0] INPUT_STREAM_TUSER_int_regslice;
wire    regslice_both_INPUT_STREAM_V_user_V_U_vld_out;
wire    regslice_both_INPUT_STREAM_V_user_V_U_ack_in;
wire    regslice_both_INPUT_STREAM_V_last_V_U_apdone_blk;
wire   [0:0] INPUT_STREAM_TLAST_int_regslice;
wire    regslice_both_INPUT_STREAM_V_last_V_U_vld_out;
wire    regslice_both_INPUT_STREAM_V_last_V_U_ack_in;
wire    regslice_both_INPUT_STREAM_V_id_V_U_apdone_blk;
wire   [0:0] INPUT_STREAM_TID_int_regslice;
wire    regslice_both_INPUT_STREAM_V_id_V_U_vld_out;
wire    regslice_both_INPUT_STREAM_V_id_V_U_ack_in;
wire    regslice_both_INPUT_STREAM_V_dest_V_U_apdone_blk;
wire   [0:0] INPUT_STREAM_TDEST_int_regslice;
wire    regslice_both_INPUT_STREAM_V_dest_V_U_vld_out;
wire    regslice_both_INPUT_STREAM_V_dest_V_U_ack_in;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 start_once_reg = 1'b0;
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 10'd1;
#0 grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_ap_start_reg = 1'b0;
#0 grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_ap_start_reg = 1'b0;
#0 grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_ap_start_reg = 1'b0;
end

test_Hu_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_ap_start),
    .ap_done(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_ap_done),
    .ap_idle(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_ap_idle),
    .ap_ready(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_ap_ready),
    .INPUT_STREAM_TVALID(INPUT_STREAM_TVALID_int_regslice),
    .INPUT_STREAM_TDATA(INPUT_STREAM_TDATA_int_regslice),
    .INPUT_STREAM_TREADY(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_INPUT_STREAM_TREADY),
    .INPUT_STREAM_TKEEP(INPUT_STREAM_TKEEP_int_regslice),
    .INPUT_STREAM_TSTRB(INPUT_STREAM_TSTRB_int_regslice),
    .INPUT_STREAM_TUSER(INPUT_STREAM_TUSER_int_regslice),
    .INPUT_STREAM_TLAST(INPUT_STREAM_TLAST_int_regslice),
    .INPUT_STREAM_TID(INPUT_STREAM_TID_int_regslice),
    .INPUT_STREAM_TDEST(INPUT_STREAM_TDEST_int_regslice),
    .axi_last_V_out(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_axi_last_V_out),
    .axi_last_V_out_ap_vld(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_axi_last_V_out_ap_vld),
    .axi_data_V_out(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_axi_data_V_out),
    .axi_data_V_out_ap_vld(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_axi_data_V_out_ap_vld)
);

test_Hu_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_ap_start),
    .ap_done(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_ap_done),
    .ap_idle(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_ap_idle),
    .ap_ready(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_ap_ready),
    .INPUT_STREAM_TVALID(INPUT_STREAM_TVALID_int_regslice),
    .img_0_data64_din(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_img_0_data64_din),
    .img_0_data64_num_data_valid(2'd0),
    .img_0_data64_fifo_cap(2'd0),
    .img_0_data64_full_n(img_0_data64_full_n),
    .img_0_data64_write(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_img_0_data64_write),
    .start_2(start_reg_124),
    .axi_data_V_2(axi_data_V_2_fu_84),
    .axi_last_V_2(axi_last_V_2_reg_138),
    .INPUT_STREAM_TDATA(INPUT_STREAM_TDATA_int_regslice),
    .INPUT_STREAM_TREADY(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_INPUT_STREAM_TREADY),
    .INPUT_STREAM_TKEEP(INPUT_STREAM_TKEEP_int_regslice),
    .INPUT_STREAM_TSTRB(INPUT_STREAM_TSTRB_int_regslice),
    .INPUT_STREAM_TUSER(INPUT_STREAM_TUSER_int_regslice),
    .INPUT_STREAM_TLAST(INPUT_STREAM_TLAST_int_regslice),
    .INPUT_STREAM_TID(INPUT_STREAM_TID_int_regslice),
    .INPUT_STREAM_TDEST(INPUT_STREAM_TDEST_int_regslice),
    .last_out(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_last_out),
    .last_out_ap_vld(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_last_out_ap_vld),
    .axi_data_V_3_out(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_axi_data_V_3_out),
    .axi_data_V_3_out_ap_vld(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_axi_data_V_3_out_ap_vld)
);

test_Hu_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_ap_start),
    .ap_done(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_ap_done),
    .ap_idle(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_ap_idle),
    .ap_ready(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_ap_ready),
    .INPUT_STREAM_TVALID(INPUT_STREAM_TVALID_int_regslice),
    .axi_last_2_lcssa(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_last_out),
    .axi_data_2_lcssa(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_axi_data_V_3_out),
    .last_0_lcssa(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_last_out),
    .INPUT_STREAM_TDATA(INPUT_STREAM_TDATA_int_regslice),
    .INPUT_STREAM_TREADY(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_INPUT_STREAM_TREADY),
    .INPUT_STREAM_TKEEP(INPUT_STREAM_TKEEP_int_regslice),
    .INPUT_STREAM_TSTRB(INPUT_STREAM_TSTRB_int_regslice),
    .INPUT_STREAM_TUSER(INPUT_STREAM_TUSER_int_regslice),
    .INPUT_STREAM_TLAST(INPUT_STREAM_TLAST_int_regslice),
    .INPUT_STREAM_TID(INPUT_STREAM_TID_int_regslice),
    .INPUT_STREAM_TDEST(INPUT_STREAM_TDEST_int_regslice),
    .axi_last_V_4_out(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_axi_last_V_4_out),
    .axi_last_V_4_out_ap_vld(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_axi_last_V_4_out_ap_vld),
    .axi_data_V_4_out(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_axi_data_V_4_out),
    .axi_data_V_4_out_ap_vld(grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_axi_data_V_4_out_ap_vld)
);

test_Hu_regslice_both #(
    .DataWidth( 24 ))
regslice_both_INPUT_STREAM_V_data_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(INPUT_STREAM_TDATA),
    .vld_in(INPUT_STREAM_TVALID),
    .ack_in(regslice_both_INPUT_STREAM_V_data_V_U_ack_in),
    .data_out(INPUT_STREAM_TDATA_int_regslice),
    .vld_out(INPUT_STREAM_TVALID_int_regslice),
    .ack_out(INPUT_STREAM_TREADY_int_regslice),
    .apdone_blk(regslice_both_INPUT_STREAM_V_data_V_U_apdone_blk)
);

test_Hu_regslice_both #(
    .DataWidth( 3 ))
regslice_both_INPUT_STREAM_V_keep_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(INPUT_STREAM_TKEEP),
    .vld_in(INPUT_STREAM_TVALID),
    .ack_in(regslice_both_INPUT_STREAM_V_keep_V_U_ack_in),
    .data_out(INPUT_STREAM_TKEEP_int_regslice),
    .vld_out(regslice_both_INPUT_STREAM_V_keep_V_U_vld_out),
    .ack_out(INPUT_STREAM_TREADY_int_regslice),
    .apdone_blk(regslice_both_INPUT_STREAM_V_keep_V_U_apdone_blk)
);

test_Hu_regslice_both #(
    .DataWidth( 3 ))
regslice_both_INPUT_STREAM_V_strb_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(INPUT_STREAM_TSTRB),
    .vld_in(INPUT_STREAM_TVALID),
    .ack_in(regslice_both_INPUT_STREAM_V_strb_V_U_ack_in),
    .data_out(INPUT_STREAM_TSTRB_int_regslice),
    .vld_out(regslice_both_INPUT_STREAM_V_strb_V_U_vld_out),
    .ack_out(INPUT_STREAM_TREADY_int_regslice),
    .apdone_blk(regslice_both_INPUT_STREAM_V_strb_V_U_apdone_blk)
);

test_Hu_regslice_both #(
    .DataWidth( 1 ))
regslice_both_INPUT_STREAM_V_user_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(INPUT_STREAM_TUSER),
    .vld_in(INPUT_STREAM_TVALID),
    .ack_in(regslice_both_INPUT_STREAM_V_user_V_U_ack_in),
    .data_out(INPUT_STREAM_TUSER_int_regslice),
    .vld_out(regslice_both_INPUT_STREAM_V_user_V_U_vld_out),
    .ack_out(INPUT_STREAM_TREADY_int_regslice),
    .apdone_blk(regslice_both_INPUT_STREAM_V_user_V_U_apdone_blk)
);

test_Hu_regslice_both #(
    .DataWidth( 1 ))
regslice_both_INPUT_STREAM_V_last_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(INPUT_STREAM_TLAST),
    .vld_in(INPUT_STREAM_TVALID),
    .ack_in(regslice_both_INPUT_STREAM_V_last_V_U_ack_in),
    .data_out(INPUT_STREAM_TLAST_int_regslice),
    .vld_out(regslice_both_INPUT_STREAM_V_last_V_U_vld_out),
    .ack_out(INPUT_STREAM_TREADY_int_regslice),
    .apdone_blk(regslice_both_INPUT_STREAM_V_last_V_U_apdone_blk)
);

test_Hu_regslice_both #(
    .DataWidth( 1 ))
regslice_both_INPUT_STREAM_V_id_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(INPUT_STREAM_TID),
    .vld_in(INPUT_STREAM_TVALID),
    .ack_in(regslice_both_INPUT_STREAM_V_id_V_U_ack_in),
    .data_out(INPUT_STREAM_TID_int_regslice),
    .vld_out(regslice_both_INPUT_STREAM_V_id_V_U_vld_out),
    .ack_out(INPUT_STREAM_TREADY_int_regslice),
    .apdone_blk(regslice_both_INPUT_STREAM_V_id_V_U_apdone_blk)
);

test_Hu_regslice_both #(
    .DataWidth( 1 ))
regslice_both_INPUT_STREAM_V_dest_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(INPUT_STREAM_TDEST),
    .vld_in(INPUT_STREAM_TVALID),
    .ack_in(regslice_both_INPUT_STREAM_V_dest_V_U_ack_in),
    .data_out(INPUT_STREAM_TDEST_int_regslice),
    .vld_out(regslice_both_INPUT_STREAM_V_dest_V_U_vld_out),
    .ack_out(INPUT_STREAM_TREADY_int_regslice),
    .apdone_blk(regslice_both_INPUT_STREAM_V_dest_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((1'b1 == ap_CS_fsm_state5) & (icmp_ln129_fu_229_p2 == 1'd1))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_ap_start_reg <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_state5) & (icmp_ln129_fu_229_p2 == 1'd0))) begin
            grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_ap_start_reg <= 1'b1;
        end else if ((grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_ap_ready == 1'b1)) begin
            grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state8)) begin
            grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_ap_start_reg <= 1'b1;
        end else if ((grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_ap_ready == 1'b1)) begin
            grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state2)) begin
            grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_ap_start_reg <= 1'b1;
        end else if ((grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_ap_ready == 1'b1)) begin
            grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        start_once_reg <= 1'b0;
    end else begin
        if (((internal_ap_ready == 1'b0) & (real_start == 1'b1))) begin
            start_once_reg <= 1'b1;
        end else if ((internal_ap_ready == 1'b1)) begin
            start_once_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state9) & (grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_axi_data_V_4_out_ap_vld == 1'b1))) begin
        axi_data_V_2_fu_84 <= grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_axi_data_V_4_out;
    end else if (((grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_axi_data_V_out_ap_vld == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
        axi_data_V_2_fu_84 <= grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_axi_data_V_out;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state10)) begin
        axi_last_V_2_reg_138 <= axi_last_V_4_loc_fu_92;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        axi_last_V_2_reg_138 <= grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_axi_last_V_out;
    end
end

always @ (posedge ap_clk) begin
    if ((~((img_0_cols_c_full_n == 1'b0) | (img_0_rows_c_full_n == 1'b0) | (ap_done_reg == 1'b1) | (real_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        i_fu_88 <= 10'd0;
    end else if (((1'b1 == ap_CS_fsm_state5) & (icmp_ln129_fu_229_p2 == 1'd0))) begin
        i_fu_88 <= i_4_fu_235_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state10)) begin
        start_reg_124 <= 1'd0;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        start_reg_124 <= 1'd1;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state9) & (grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_axi_last_V_4_out_ap_vld == 1'b1))) begin
        axi_last_V_4_loc_fu_92 <= grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_axi_last_V_4_out;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state9)) begin
        INPUT_STREAM_TREADY_int_regslice = grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_INPUT_STREAM_TREADY;
    end else if ((1'b1 == ap_CS_fsm_state6)) begin
        INPUT_STREAM_TREADY_int_regslice = grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_INPUT_STREAM_TREADY;
    end else if ((1'b1 == ap_CS_fsm_state3)) begin
        INPUT_STREAM_TREADY_int_regslice = grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_INPUT_STREAM_TREADY;
    end else begin
        INPUT_STREAM_TREADY_int_regslice = 1'b0;
    end
end

assign ap_ST_fsm_state10_blk = 1'b0;

always @ (*) begin
    if (((img_0_cols_c_full_n == 1'b0) | (img_0_rows_c_full_n == 1'b0) | (ap_done_reg == 1'b1) | (real_start == 1'b0))) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

assign ap_ST_fsm_state2_blk = 1'b0;

always @ (*) begin
    if ((grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_ap_done == 1'b0)) begin
        ap_ST_fsm_state3_blk = 1'b1;
    end else begin
        ap_ST_fsm_state3_blk = 1'b0;
    end
end

assign ap_ST_fsm_state4_blk = 1'b0;

assign ap_ST_fsm_state5_blk = 1'b0;

always @ (*) begin
    if ((grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_ap_done == 1'b0)) begin
        ap_ST_fsm_state6_blk = 1'b1;
    end else begin
        ap_ST_fsm_state6_blk = 1'b0;
    end
end

assign ap_ST_fsm_state7_blk = 1'b0;

assign ap_ST_fsm_state8_blk = 1'b0;

always @ (*) begin
    if ((grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_ap_done == 1'b0)) begin
        ap_ST_fsm_state9_blk = 1'b1;
    end else begin
        ap_ST_fsm_state9_blk = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state5) & (icmp_ln129_fu_229_p2 == 1'd1))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) & (real_start == 1'b0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_done_reg == 1'b1) | (real_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        img_0_cols_c_blk_n = img_0_cols_c_full_n;
    end else begin
        img_0_cols_c_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((img_0_cols_c_full_n == 1'b0) | (img_0_rows_c_full_n == 1'b0) | (ap_done_reg == 1'b1) | (real_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        img_0_cols_c_write = 1'b1;
    end else begin
        img_0_cols_c_write = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state6)) begin
        img_0_data64_write = grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_img_0_data64_write;
    end else begin
        img_0_data64_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_done_reg == 1'b1) | (real_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        img_0_rows_c_blk_n = img_0_rows_c_full_n;
    end else begin
        img_0_rows_c_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((img_0_cols_c_full_n == 1'b0) | (img_0_rows_c_full_n == 1'b0) | (ap_done_reg == 1'b1) | (real_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        img_0_rows_c_write = 1'b1;
    end else begin
        img_0_rows_c_write = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state5) & (icmp_ln129_fu_229_p2 == 1'd1))) begin
        internal_ap_ready = 1'b1;
    end else begin
        internal_ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((start_once_reg == 1'b0) & (start_full_n == 1'b0))) begin
        real_start = 1'b0;
    end else begin
        real_start = ap_start;
    end
end

always @ (*) begin
    if (((start_once_reg == 1'b0) & (real_start == 1'b1))) begin
        start_write = 1'b1;
    end else begin
        start_write = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((img_0_cols_c_full_n == 1'b0) | (img_0_rows_c_full_n == 1'b0) | (ap_done_reg == 1'b1) | (real_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            if (((grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state5;
        end
        ap_ST_fsm_state5 : begin
            if (((1'b1 == ap_CS_fsm_state5) & (icmp_ln129_fu_229_p2 == 1'd1))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state6;
            end
        end
        ap_ST_fsm_state6 : begin
            if (((1'b1 == ap_CS_fsm_state6) & (grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_ap_done == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state7;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state6;
            end
        end
        ap_ST_fsm_state7 : begin
            ap_NS_fsm = ap_ST_fsm_state8;
        end
        ap_ST_fsm_state8 : begin
            ap_NS_fsm = ap_ST_fsm_state9;
        end
        ap_ST_fsm_state9 : begin
            if (((1'b1 == ap_CS_fsm_state9) & (grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_ap_done == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state10;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state9;
            end
        end
        ap_ST_fsm_state10 : begin
            ap_NS_fsm = ap_ST_fsm_state5;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign INPUT_STREAM_TREADY = regslice_both_INPUT_STREAM_V_data_V_U_ack_in;

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state10 = ap_CS_fsm[32'd9];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

assign ap_CS_fsm_state5 = ap_CS_fsm[32'd4];

assign ap_CS_fsm_state6 = ap_CS_fsm[32'd5];

assign ap_CS_fsm_state8 = ap_CS_fsm[32'd7];

assign ap_CS_fsm_state9 = ap_CS_fsm[32'd8];

always @ (*) begin
    ap_block_state1 = ((img_0_cols_c_full_n == 1'b0) | (img_0_rows_c_full_n == 1'b0) | (ap_done_reg == 1'b1) | (real_start == 1'b0));
end

assign ap_ready = internal_ap_ready;

assign grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_ap_start = grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_ap_start_reg;

assign grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_ap_start = grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_last_hunt_fu_195_ap_start_reg;

assign grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_ap_start = grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_start_hunt_fu_148_ap_start_reg;

assign i_4_fu_235_p2 = (i_fu_88 + 10'd1);

assign icmp_ln129_fu_229_p2 = ((i_fu_88 == 10'd600) ? 1'b1 : 1'b0);

assign img_0_cols_c_din = 11'd1024;

assign img_0_data64_din = grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168_img_0_data64_din;

assign img_0_rows_c_din = 10'd600;

assign start_out = real_start;

endmodule //test_Hu_AXIvideo2xfMat_24_9_600_1024_1_2_s
