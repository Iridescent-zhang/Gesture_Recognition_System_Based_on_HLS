// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Version: 2022.2
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module test_Hu_xFSobel3x3_1_1_0_0_s (
        ap_clk,
        ap_rst,
        p_read2,
        p_read5,
        p_read6,
        p_read7,
        p_read8,
        p_read9,
        p_read10,
        p_read11,
        ap_return_0,
        ap_return_1,
        ap_ce
);


input   ap_clk;
input   ap_rst;
input  [7:0] p_read2;
input  [7:0] p_read5;
input  [7:0] p_read6;
input  [7:0] p_read7;
input  [7:0] p_read8;
input  [7:0] p_read9;
input  [7:0] p_read10;
input  [7:0] p_read11;
output  [7:0] ap_return_0;
output  [7:0] ap_return_1;
input   ap_ce;

reg[7:0] ap_return_0;
reg[7:0] ap_return_1;

wire   [7:0] grp_xFGradientX3x3_0_0_s_fu_72_ap_return;
reg    grp_xFGradientX3x3_0_0_s_fu_72_ap_ce;
wire    ap_block_state1_pp0_stage0_iter0_ignore_call8;
wire    ap_block_state2_pp0_stage0_iter1_ignore_call8;
wire    ap_block_pp0_stage0_11001_ignoreCallOp11;
wire   [7:0] grp_xFGradientY3x3_0_0_s_fu_88_ap_return;
reg    grp_xFGradientY3x3_0_0_s_fu_88_ap_ce;
wire    ap_block_state1_pp0_stage0_iter0_ignore_call9;
wire    ap_block_state2_pp0_stage0_iter1_ignore_call9;
wire    ap_block_pp0_stage0_11001_ignoreCallOp12;
wire    ap_block_pp0_stage0;
wire    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
wire    ap_block_pp0_stage0_11001;
reg    ap_ce_reg;
reg   [7:0] ap_return_0_int_reg;
reg   [7:0] ap_return_1_int_reg;

test_Hu_xFGradientX3x3_0_0_s grp_xFGradientX3x3_0_0_s_fu_72(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .t0(p_read2),
    .t2(p_read6),
    .m0(p_read7),
    .m2(p_read8),
    .b0(p_read9),
    .b2(p_read11),
    .ap_return(grp_xFGradientX3x3_0_0_s_fu_72_ap_return),
    .ap_ce(grp_xFGradientX3x3_0_0_s_fu_72_ap_ce)
);

test_Hu_xFGradientY3x3_0_0_s grp_xFGradientY3x3_0_0_s_fu_88(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .t0(p_read2),
    .t1(p_read5),
    .t2(p_read6),
    .b0(p_read9),
    .b1(p_read10),
    .b2(p_read11),
    .ap_return(grp_xFGradientY3x3_0_0_s_fu_88_ap_return),
    .ap_ce(grp_xFGradientY3x3_0_0_s_fu_88_ap_ce)
);

always @ (posedge ap_clk) begin
    ap_ce_reg <= ap_ce;
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_ce_reg)) begin
        ap_return_0_int_reg <= grp_xFGradientX3x3_0_0_s_fu_72_ap_return;
        ap_return_1_int_reg <= grp_xFGradientY3x3_0_0_s_fu_88_ap_return;
    end
end

always @ (*) begin
    if ((1'b0 == ap_ce_reg)) begin
        ap_return_0 = ap_return_0_int_reg;
    end else if ((1'b1 == ap_ce_reg)) begin
        ap_return_0 = grp_xFGradientX3x3_0_0_s_fu_72_ap_return;
    end else begin
        ap_return_0 = 'bx;
    end
end

always @ (*) begin
    if ((1'b0 == ap_ce_reg)) begin
        ap_return_1 = ap_return_1_int_reg;
    end else if ((1'b1 == ap_ce_reg)) begin
        ap_return_1 = grp_xFGradientY3x3_0_0_s_fu_88_ap_return;
    end else begin
        ap_return_1 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001_ignoreCallOp11))) begin
        grp_xFGradientX3x3_0_0_s_fu_72_ap_ce = 1'b1;
    end else begin
        grp_xFGradientX3x3_0_0_s_fu_72_ap_ce = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001_ignoreCallOp12))) begin
        grp_xFGradientY3x3_0_0_s_fu_88_ap_ce = 1'b1;
    end else begin
        grp_xFGradientY3x3_0_0_s_fu_88_ap_ce = 1'b0;
    end
end

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001_ignoreCallOp11 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001_ignoreCallOp12 = ~(1'b1 == 1'b1);

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state1_pp0_stage0_iter0_ignore_call8 = ~(1'b1 == 1'b1);

assign ap_block_state1_pp0_stage0_iter0_ignore_call9 = ~(1'b1 == 1'b1);

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state2_pp0_stage0_iter1_ignore_call8 = ~(1'b1 == 1'b1);

assign ap_block_state2_pp0_stage0_iter1_ignore_call9 = ~(1'b1 == 1'b1);

endmodule //test_Hu_xFSobel3x3_1_1_0_0_s
