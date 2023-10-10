// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Version: 2022.2
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module CAL_Hu_HuMoment_0_300_512_1_2_Pipeline_loop_General_rows (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        img_1_data15_dout,
        img_1_data15_num_data_valid,
        img_1_data15_fifo_cap,
        img_1_data15_empty_n,
        img_1_data15_read,
        tmp_9,
        pBmpBuf_address0,
        pBmpBuf_ce0,
        pBmpBuf_we0,
        pBmpBuf_d0,
        zext_ln39,
        s00_1_out_i,
        s00_1_out_o,
        s00_1_out_o_ap_vld,
        s01_1_out_i,
        s01_1_out_o,
        s01_1_out_o_ap_vld,
        s10_1_out_i,
        s10_1_out_o,
        s10_1_out_o_ap_vld,
        grp_fu_196_p_din0,
        grp_fu_196_p_din1,
        grp_fu_196_p_opcode,
        grp_fu_196_p_dout0,
        grp_fu_196_p_ce
);

parameter    ap_ST_fsm_pp0_stage0 = 4'd1;
parameter    ap_ST_fsm_pp0_stage1 = 4'd2;
parameter    ap_ST_fsm_pp0_stage2 = 4'd4;
parameter    ap_ST_fsm_pp0_stage3 = 4'd8;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [7:0] img_1_data15_dout;
input  [1:0] img_1_data15_num_data_valid;
input  [1:0] img_1_data15_fifo_cap;
input   img_1_data15_empty_n;
output   img_1_data15_read;
input  [17:0] tmp_9;
output  [8:0] pBmpBuf_address0;
output   pBmpBuf_ce0;
output  [299:0] pBmpBuf_we0;
output  [2399:0] pBmpBuf_d0;
input  [8:0] zext_ln39;
input  [31:0] s00_1_out_i;
output  [31:0] s00_1_out_o;
output   s00_1_out_o_ap_vld;
input  [31:0] s01_1_out_i;
output  [31:0] s01_1_out_o;
output   s01_1_out_o_ap_vld;
input  [31:0] s10_1_out_i;
output  [31:0] s10_1_out_o;
output   s10_1_out_o_ap_vld;
output  [31:0] grp_fu_196_p_din0;
output  [31:0] grp_fu_196_p_din1;
output  [0:0] grp_fu_196_p_opcode;
input  [31:0] grp_fu_196_p_dout0;
output   grp_fu_196_p_ce;

reg ap_idle;
reg img_1_data15_read;
reg pBmpBuf_ce0;
reg[299:0] pBmpBuf_we0;
reg[31:0] s00_1_out_o;
reg s00_1_out_o_ap_vld;
reg[31:0] s01_1_out_o;
reg s01_1_out_o_ap_vld;
reg[31:0] s10_1_out_o;
reg s10_1_out_o_ap_vld;

(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_enable_reg_pp0_iter3;
reg    ap_idle_pp0;
wire    ap_CS_fsm_pp0_stage3;
wire    ap_block_state4_pp0_stage3_iter0;
wire    ap_block_state8_pp0_stage3_iter1;
wire    ap_block_state12_pp0_stage3_iter2;
wire    ap_block_pp0_stage3_subdone;
reg   [0:0] icmp_ln39_reg_268;
reg    ap_condition_exit_pp0_iter0_stage3;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
reg    img_1_data15_blk_n;
wire    ap_CS_fsm_pp0_stage1;
wire    ap_block_pp0_stage1;
wire   [16:0] zext_ln39_cast_fu_107_p1;
reg   [16:0] zext_ln39_cast_reg_263;
wire    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state5_pp0_stage0_iter1;
wire    ap_block_state9_pp0_stage0_iter2;
wire    ap_block_state13_pp0_stage0_iter3;
wire    ap_block_pp0_stage0_11001;
wire   [0:0] icmp_ln39_fu_123_p2;
reg   [0:0] icmp_ln39_reg_268_pp0_iter1_reg;
reg   [0:0] icmp_ln39_reg_268_pp0_iter2_reg;
wire   [8:0] trunc_ln45_fu_135_p1;
reg   [8:0] trunc_ln45_reg_272;
wire   [8:0] tmp_s_fu_145_p4;
reg   [8:0] tmp_s_reg_278;
wire   [299:0] shl_ln45_1_fu_159_p2;
reg   [299:0] shl_ln45_1_reg_283;
reg   [7:0] tmp_reg_288;
reg    ap_block_state2_pp0_stage1_iter0;
wire    ap_block_state6_pp0_stage1_iter1;
wire    ap_block_state10_pp0_stage1_iter2;
wire    ap_block_state14_pp0_stage1_iter3;
reg    ap_block_pp0_stage1_11001;
wire   [2399:0] shl_ln45_fu_185_p2;
reg   [2399:0] shl_ln45_reg_294;
wire   [31:0] zext_ln46_fu_195_p1;
wire    ap_CS_fsm_pp0_stage2;
wire    ap_block_state3_pp0_stage2_iter0;
wire    ap_block_state7_pp0_stage2_iter1;
wire    ap_block_state11_pp0_stage2_iter2;
wire    ap_block_state15_pp0_stage2_iter3;
wire    ap_block_pp0_stage2_11001;
wire   [16:0] zext_ln46_1_fu_199_p1;
reg   [16:0] zext_ln46_1_reg_304;
wire   [16:0] mul_ln46_fu_205_p2;
reg   [16:0] mul_ln46_reg_309;
wire   [31:0] zext_ln46_3_fu_211_p1;
wire    ap_block_pp0_stage3_11001;
wire   [16:0] mul_ln47_fu_215_p2;
reg   [16:0] mul_ln47_reg_319;
wire   [31:0] zext_ln47_fu_219_p1;
wire   [31:0] grp_fu_104_p1;
reg   [31:0] conv3_reg_329;
reg   [31:0] conv9_reg_339;
reg   [31:0] conv2_reg_349;
reg    ap_enable_reg_pp0_iter0_reg;
wire    ap_block_pp0_stage2_subdone;
wire   [63:0] zext_ln45_fu_191_p1;
wire    ap_block_pp0_stage2;
wire    ap_block_pp0_stage0;
reg   [31:0] ap_sig_allocacmp_s00_1_out_load;
reg   [31:0] ap_sig_allocacmp_s01_1_out_load;
reg   [31:0] ap_sig_allocacmp_s10_1_out_load;
reg   [9:0] i_fu_66;
wire   [9:0] add_ln39_fu_129_p2;
wire    ap_loop_init;
reg   [9:0] ap_sig_allocacmp_i_1;
reg   [31:0] grp_fu_100_p0;
reg   [31:0] grp_fu_100_p1;
reg   [31:0] grp_fu_104_p0;
wire    ap_block_pp0_stage3;
wire   [17:0] zext_ln39_1_fu_119_p1;
wire   [17:0] add_ln45_fu_139_p2;
wire   [299:0] zext_ln45_3_fu_155_p1;
wire   [11:0] and_ln_fu_170_p3;
wire   [2399:0] zext_ln45_2_fu_181_p1;
wire   [2399:0] zext_ln45_1_fu_177_p1;
wire   [8:0] mul_ln46_fu_205_p0;
wire   [7:0] mul_ln46_fu_205_p1;
wire   [8:0] mul_ln47_fu_215_p0;
wire   [7:0] mul_ln47_fu_215_p1;
wire    ap_block_pp0_stage0_00001;
reg    ap_block_pp0_stage1_00001;
wire    ap_block_pp0_stage2_00001;
reg    grp_fu_100_ce;
reg    grp_fu_104_ce;
reg    ap_done_reg;
wire    ap_continue_int;
reg    ap_done_int;
reg    ap_loop_exit_ready_pp0_iter1_reg;
reg    ap_condition_exit_pp0_iter2_stage2;
reg    ap_idle_pp0_0to1;
reg    ap_loop_exit_ready_pp0_iter2_reg;
reg   [3:0] ap_NS_fsm;
wire    ap_block_pp0_stage0_subdone;
reg    ap_idle_pp0_1to3;
reg    ap_block_pp0_stage1_subdone;
wire    ap_enable_pp0;
wire    ap_start_int;
wire   [16:0] mul_ln46_fu_205_p00;
wire   [16:0] mul_ln46_fu_205_p10;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 4'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_enable_reg_pp0_iter3 = 1'b0;
#0 ap_enable_reg_pp0_iter0_reg = 1'b0;
#0 ap_done_reg = 1'b0;
end

CAL_Hu_sitofp_32ns_32_6_no_dsp_1 #(
    .ID( 1 ),
    .NUM_STAGE( 6 ),
    .din0_WIDTH( 32 ),
    .dout_WIDTH( 32 ))
sitofp_32ns_32_6_no_dsp_1_U68(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(grp_fu_104_p0),
    .ce(grp_fu_104_ce),
    .dout(grp_fu_104_p1)
);

CAL_Hu_mul_9ns_8ns_17_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 9 ),
    .din1_WIDTH( 8 ),
    .dout_WIDTH( 17 ))
mul_9ns_8ns_17_1_1_U69(
    .din0(mul_ln46_fu_205_p0),
    .din1(mul_ln46_fu_205_p1),
    .dout(mul_ln46_fu_205_p2)
);

CAL_Hu_mul_9ns_8ns_17_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 9 ),
    .din1_WIDTH( 8 ),
    .dout_WIDTH( 17 ))
mul_9ns_8ns_17_1_1_U70(
    .din0(mul_ln47_fu_215_p0),
    .din1(mul_ln47_fu_215_p1),
    .dout(mul_ln47_fu_215_p2)
);

CAL_Hu_flow_control_loop_pipe_sequential_init flow_control_loop_pipe_sequential_init_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_start_int(ap_start_int),
    .ap_loop_init(ap_loop_init),
    .ap_ready_int(ap_ready_int),
    .ap_loop_exit_ready(ap_condition_exit_pp0_iter0_stage3),
    .ap_loop_exit_done(ap_done_int),
    .ap_continue_int(ap_continue_int),
    .ap_done_int(ap_done_int)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue_int == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((1'b0 == ap_block_pp0_stage2_subdone) & (ap_loop_exit_ready_pp0_iter2_reg == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_pp0_stage0)) begin
            ap_enable_reg_pp0_iter0_reg <= ap_start_int;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((1'b1 == ap_condition_exit_pp0_iter0_stage3)) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end else if (((1'b0 == ap_block_pp0_stage3_subdone) & (1'b1 == ap_CS_fsm_pp0_stage3))) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage3_subdone) & (1'b1 == ap_CS_fsm_pp0_stage3))) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter3 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage2_subdone) & (ap_enable_reg_pp0_iter3 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
            ap_enable_reg_pp0_iter3 <= 1'b0;
        end else if (((1'b0 == ap_block_pp0_stage3_subdone) & (1'b1 == ap_CS_fsm_pp0_stage3))) begin
            ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((ap_idle_pp0_0to1 == 1'b1) & (1'b1 == ap_condition_exit_pp0_iter2_stage2))) begin
        ap_loop_exit_ready_pp0_iter1_reg <= 1'b0;
    end else if (((1'b0 == ap_block_pp0_stage3_11001) & (1'b1 == ap_CS_fsm_pp0_stage3))) begin
        ap_loop_exit_ready_pp0_iter1_reg <= ap_loop_exit_ready;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_idle_pp0_0to1 == 1'b1) & (1'b1 == ap_condition_exit_pp0_iter2_stage2))) begin
        ap_loop_exit_ready_pp0_iter2_reg <= 1'b0;
    end else if (((1'b0 == ap_block_pp0_stage3_11001) & (1'b1 == ap_CS_fsm_pp0_stage3))) begin
        ap_loop_exit_ready_pp0_iter2_reg <= ap_loop_exit_ready_pp0_iter1_reg;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((ap_enable_reg_pp0_iter0 == 1'b1) & (icmp_ln39_fu_123_p2 == 1'd0))) begin
            i_fu_66 <= add_ln39_fu_129_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            i_fu_66 <= 10'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage1_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        conv2_reg_349 <= grp_fu_104_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage3_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage3))) begin
        conv3_reg_329 <= grp_fu_104_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        conv9_reg_339 <= grp_fu_104_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln39_reg_268 <= icmp_ln39_fu_123_p2;
        icmp_ln39_reg_268_pp0_iter1_reg <= icmp_ln39_reg_268;
        icmp_ln39_reg_268_pp0_iter2_reg <= icmp_ln39_reg_268_pp0_iter1_reg;
        zext_ln39_cast_reg_263[8 : 0] <= zext_ln39_cast_fu_107_p1[8 : 0];
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln39_reg_268 == 1'd0) & (1'b0 == ap_block_pp0_stage2_11001) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
        mul_ln46_reg_309 <= mul_ln46_fu_205_p2;
        zext_ln46_1_reg_304[7 : 0] <= zext_ln46_1_fu_199_p1[7 : 0];
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln39_reg_268 == 1'd0) & (1'b0 == ap_block_pp0_stage3_11001) & (1'b1 == ap_CS_fsm_pp0_stage3))) begin
        mul_ln47_reg_319 <= mul_ln47_fu_215_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln39_fu_123_p2 == 1'd0))) begin
        shl_ln45_1_reg_283 <= shl_ln45_1_fu_159_p2;
        tmp_s_reg_278 <= {{add_ln45_fu_139_p2[17:9]}};
        trunc_ln45_reg_272 <= trunc_ln45_fu_135_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln39_reg_268 == 1'd0) & (1'b0 == ap_block_pp0_stage1_11001) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        shl_ln45_reg_294 <= shl_ln45_fu_185_p2;
        tmp_reg_288 <= img_1_data15_dout;
    end
end

always @ (*) begin
    if (((icmp_ln39_reg_268 == 1'd1) & (1'b0 == ap_block_pp0_stage3_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage3))) begin
        ap_condition_exit_pp0_iter0_stage3 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage3 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage2_subdone) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage2) & (icmp_ln39_reg_268_pp0_iter2_reg == 1'd1))) begin
        ap_condition_exit_pp0_iter2_stage2 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter2_stage2 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage2_subdone) & (ap_loop_exit_ready_pp0_iter2_reg == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
        ap_done_int = 1'b1;
    end else begin
        ap_done_int = ap_done_reg;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_pp0_stage0)) begin
        ap_enable_reg_pp0_iter0 = ap_start_int;
    end else begin
        ap_enable_reg_pp0_iter0 = ap_enable_reg_pp0_iter0_reg;
    end
end

always @ (*) begin
    if (((ap_start_int == 1'b0) & (ap_idle_pp0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0_0to1 = 1'b1;
    end else begin
        ap_idle_pp0_0to1 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0))) begin
        ap_idle_pp0_1to3 = 1'b1;
    end else begin
        ap_idle_pp0_1to3 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage3_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage3))) begin
        ap_ready_int = 1'b1;
    end else begin
        ap_ready_int = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_loop_init == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_sig_allocacmp_i_1 = 10'd0;
    end else begin
        ap_sig_allocacmp_i_1 = i_fu_66;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter3 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_sig_allocacmp_s00_1_out_load = grp_fu_196_p_dout0;
    end else begin
        ap_sig_allocacmp_s00_1_out_load = s00_1_out_i;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage2) & (ap_enable_reg_pp0_iter3 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
        ap_sig_allocacmp_s01_1_out_load = grp_fu_196_p_dout0;
    end else begin
        ap_sig_allocacmp_s01_1_out_load = s01_1_out_i;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage1) & (ap_enable_reg_pp0_iter3 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        ap_sig_allocacmp_s10_1_out_load = grp_fu_196_p_dout0;
    end else begin
        ap_sig_allocacmp_s10_1_out_load = s10_1_out_i;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage3_11001) & (1'b1 == ap_CS_fsm_pp0_stage3)) | ((1'b0 == ap_block_pp0_stage2_11001) & (1'b1 == ap_CS_fsm_pp0_stage2)) | ((1'b0 == ap_block_pp0_stage1_11001) & (1'b1 == ap_CS_fsm_pp0_stage1)) | ((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        grp_fu_100_ce = 1'b1;
    end else begin
        grp_fu_100_ce = 1'b0;
    end
end

always @ (*) begin
    if ((ap_enable_reg_pp0_iter2 == 1'b1)) begin
        if (((1'b0 == ap_block_pp0_stage2) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
            grp_fu_100_p0 = ap_sig_allocacmp_s01_1_out_load;
        end else if (((1'b0 == ap_block_pp0_stage1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
            grp_fu_100_p0 = ap_sig_allocacmp_s10_1_out_load;
        end else if (((1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            grp_fu_100_p0 = ap_sig_allocacmp_s00_1_out_load;
        end else begin
            grp_fu_100_p0 = 'bx;
        end
    end else begin
        grp_fu_100_p0 = 'bx;
    end
end

always @ (*) begin
    if ((ap_enable_reg_pp0_iter2 == 1'b1)) begin
        if (((1'b0 == ap_block_pp0_stage2) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
            grp_fu_100_p1 = conv2_reg_349;
        end else if (((1'b0 == ap_block_pp0_stage1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
            grp_fu_100_p1 = conv9_reg_339;
        end else if (((1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            grp_fu_100_p1 = conv3_reg_329;
        end else begin
            grp_fu_100_p1 = 'bx;
        end
    end else begin
        grp_fu_100_p1 = 'bx;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage3_11001) & (1'b1 == ap_CS_fsm_pp0_stage3)) | ((1'b0 == ap_block_pp0_stage2_11001) & (1'b1 == ap_CS_fsm_pp0_stage2)) | ((1'b0 == ap_block_pp0_stage1_11001) & (1'b1 == ap_CS_fsm_pp0_stage1)) | ((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        grp_fu_104_ce = 1'b1;
    end else begin
        grp_fu_104_ce = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        grp_fu_104_p0 = zext_ln47_fu_219_p1;
    end else if (((1'b0 == ap_block_pp0_stage3) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage3))) begin
        grp_fu_104_p0 = zext_ln46_3_fu_211_p1;
    end else if (((1'b0 == ap_block_pp0_stage2) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
        grp_fu_104_p0 = zext_ln46_fu_195_p1;
    end else begin
        grp_fu_104_p0 = 'bx;
    end
end

always @ (*) begin
    if (((icmp_ln39_reg_268 == 1'd0) & (1'b0 == ap_block_pp0_stage1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        img_1_data15_blk_n = img_1_data15_empty_n;
    end else begin
        img_1_data15_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((icmp_ln39_reg_268 == 1'd0) & (1'b0 == ap_block_pp0_stage1_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        img_1_data15_read = 1'b1;
    end else begin
        img_1_data15_read = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage2_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
        pBmpBuf_ce0 = 1'b1;
    end else begin
        pBmpBuf_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln39_reg_268 == 1'd0) & (1'b0 == ap_block_pp0_stage2_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
        pBmpBuf_we0 = shl_ln45_1_reg_283;
    end else begin
        pBmpBuf_we0 = 300'd0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter3 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        s00_1_out_o = grp_fu_196_p_dout0;
    end else begin
        s00_1_out_o = s00_1_out_i;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter3 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        s00_1_out_o_ap_vld = 1'b1;
    end else begin
        s00_1_out_o_ap_vld = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage2) & (ap_enable_reg_pp0_iter3 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
        s01_1_out_o = grp_fu_196_p_dout0;
    end else begin
        s01_1_out_o = s01_1_out_i;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage2_11001) & (ap_enable_reg_pp0_iter3 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
        s01_1_out_o_ap_vld = 1'b1;
    end else begin
        s01_1_out_o_ap_vld = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage1) & (ap_enable_reg_pp0_iter3 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        s10_1_out_o = grp_fu_196_p_dout0;
    end else begin
        s10_1_out_o = s10_1_out_i;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage1_11001) & (ap_enable_reg_pp0_iter3 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        s10_1_out_o_ap_vld = 1'b1;
    end else begin
        s10_1_out_o_ap_vld = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            if ((~((ap_start_int == 1'b0) & (ap_idle_pp0_1to3 == 1'b1)) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_pp0_stage1 : begin
            if ((1'b0 == ap_block_pp0_stage1_subdone)) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage1;
            end
        end
        ap_ST_fsm_pp0_stage2 : begin
            if (((ap_idle_pp0_0to1 == 1'b1) & (1'b1 == ap_condition_exit_pp0_iter2_stage2))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if ((1'b0 == ap_block_pp0_stage2_subdone)) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage3;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage2;
            end
        end
        ap_ST_fsm_pp0_stage3 : begin
            if ((1'b0 == ap_block_pp0_stage3_subdone)) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage3;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln39_fu_129_p2 = (ap_sig_allocacmp_i_1 + 10'd1);

assign add_ln45_fu_139_p2 = (tmp_9 + zext_ln39_1_fu_119_p1);

assign and_ln_fu_170_p3 = {{tmp_s_reg_278}, {3'd0}};

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_pp0_stage1 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_pp0_stage2 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_pp0_stage3 = ap_CS_fsm[32'd3];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_00001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_subdone = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage1 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage1_00001 = ((img_1_data15_empty_n == 1'b0) & (icmp_ln39_reg_268 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage1_11001 = ((img_1_data15_empty_n == 1'b0) & (icmp_ln39_reg_268 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage1_subdone = ((img_1_data15_empty_n == 1'b0) & (icmp_ln39_reg_268 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1));
end

assign ap_block_pp0_stage2 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage2_00001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage2_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage2_subdone = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage3 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage3_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage3_subdone = ~(1'b1 == 1'b1);

assign ap_block_state10_pp0_stage1_iter2 = ~(1'b1 == 1'b1);

assign ap_block_state11_pp0_stage2_iter2 = ~(1'b1 == 1'b1);

assign ap_block_state12_pp0_stage3_iter2 = ~(1'b1 == 1'b1);

assign ap_block_state13_pp0_stage0_iter3 = ~(1'b1 == 1'b1);

assign ap_block_state14_pp0_stage1_iter3 = ~(1'b1 == 1'b1);

assign ap_block_state15_pp0_stage2_iter3 = ~(1'b1 == 1'b1);

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state2_pp0_stage1_iter0 = ((img_1_data15_empty_n == 1'b0) & (icmp_ln39_reg_268 == 1'd0));
end

assign ap_block_state3_pp0_stage2_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state4_pp0_stage3_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state5_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state6_pp0_stage1_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state7_pp0_stage2_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state8_pp0_stage3_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state9_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage3;

assign grp_fu_196_p_ce = grp_fu_100_ce;

assign grp_fu_196_p_din0 = grp_fu_100_p0;

assign grp_fu_196_p_din1 = grp_fu_100_p1;

assign grp_fu_196_p_opcode = 2'd0;

assign icmp_ln39_fu_123_p2 = ((ap_sig_allocacmp_i_1 == 10'd512) ? 1'b1 : 1'b0);

assign mul_ln46_fu_205_p0 = mul_ln46_fu_205_p00;

assign mul_ln46_fu_205_p00 = trunc_ln45_reg_272;

assign mul_ln46_fu_205_p1 = mul_ln46_fu_205_p10;

assign mul_ln46_fu_205_p10 = tmp_reg_288;

assign mul_ln47_fu_215_p0 = zext_ln39_cast_reg_263;

assign mul_ln47_fu_215_p1 = zext_ln46_1_reg_304;

assign pBmpBuf_address0 = zext_ln45_fu_191_p1;

assign pBmpBuf_d0 = shl_ln45_reg_294;

assign shl_ln45_1_fu_159_p2 = 300'd1 << zext_ln45_3_fu_155_p1;

assign shl_ln45_fu_185_p2 = zext_ln45_2_fu_181_p1 << zext_ln45_1_fu_177_p1;

assign tmp_s_fu_145_p4 = {{add_ln45_fu_139_p2[17:9]}};

assign trunc_ln45_fu_135_p1 = ap_sig_allocacmp_i_1[8:0];

assign zext_ln39_1_fu_119_p1 = ap_sig_allocacmp_i_1;

assign zext_ln39_cast_fu_107_p1 = zext_ln39;

assign zext_ln45_1_fu_177_p1 = and_ln_fu_170_p3;

assign zext_ln45_2_fu_181_p1 = img_1_data15_dout;

assign zext_ln45_3_fu_155_p1 = tmp_s_fu_145_p4;

assign zext_ln45_fu_191_p1 = trunc_ln45_reg_272;

assign zext_ln46_1_fu_199_p1 = tmp_reg_288;

assign zext_ln46_3_fu_211_p1 = mul_ln46_reg_309;

assign zext_ln46_fu_195_p1 = tmp_reg_288;

assign zext_ln47_fu_219_p1 = mul_ln47_reg_319;

always @ (posedge ap_clk) begin
    zext_ln39_cast_reg_263[16:9] <= 8'b00000000;
    zext_ln46_1_reg_304[16:8] <= 9'b000000000;
end

endmodule //CAL_Hu_HuMoment_0_300_512_1_2_Pipeline_loop_General_rows