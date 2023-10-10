// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Version: 2022.2
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module color_analysis_xferode_600_1024_1_0_1_2_2_0_1025_3_3_Pipeline_VITIS_LOOP_283_1 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        row_ind_V_2_out,
        row_ind_V_2_out_ap_vld,
        row_ind_V_1_out,
        row_ind_V_1_out_ap_vld,
        row_ind_V_out,
        row_ind_V_out_ap_vld
);

parameter    ap_ST_fsm_state1 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
output  [12:0] row_ind_V_2_out;
output   row_ind_V_2_out_ap_vld;
output  [12:0] row_ind_V_1_out;
output   row_ind_V_1_out_ap_vld;
output  [12:0] row_ind_V_out;
output   row_ind_V_out_ap_vld;

reg ap_idle;
reg row_ind_V_2_out_ap_vld;
reg row_ind_V_1_out_ap_vld;
reg row_ind_V_out_ap_vld;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    ap_block_state1_pp0_stage0_iter0;
wire   [0:0] icmp_ln283_fu_77_p2;
reg    ap_condition_exit_pp0_iter0_stage0;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
reg   [1:0] row_ind_V_3_fu_32;
wire   [1:0] init_row_ind_fu_83_p2;
wire    ap_loop_init;
reg   [1:0] ap_sig_allocacmp_row_ind_V_5;
wire   [1:0] row_ind_V_5_load_fu_74_p1;
reg   [12:0] row_ind_V_fu_36;
wire   [12:0] zext_ln214_fu_89_p1;
reg   [12:0] row_ind_V_1_fu_40;
reg   [12:0] row_ind_V_2_fu_44;
reg    ap_done_reg;
wire    ap_continue_int;
reg    ap_done_int;
reg   [0:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
wire    ap_start_int;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_done_reg = 1'b0;
end

color_analysis_flow_control_loop_pipe_sequential_init flow_control_loop_pipe_sequential_init_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_start_int(ap_start_int),
    .ap_loop_init(ap_loop_init),
    .ap_ready_int(ap_ready_int),
    .ap_loop_exit_ready(ap_condition_exit_pp0_iter0_stage0),
    .ap_loop_exit_done(ap_done_int),
    .ap_continue_int(ap_continue_int),
    .ap_done_int(ap_done_int)
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
        if ((ap_continue_int == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((ap_loop_exit_ready == 1'b1) & (1'b1 == ap_CS_fsm_state1) & (ap_start_int == 1'b1))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state1) & (ap_start_int == 1'b1))) begin
        if ((icmp_ln283_fu_77_p2 == 1'd0)) begin
            row_ind_V_3_fu_32 <= init_row_ind_fu_83_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            row_ind_V_3_fu_32 <= 2'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((row_ind_V_5_load_fu_74_p1 == 2'd1) & (icmp_ln283_fu_77_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state1) & (ap_start_int == 1'b1))) begin
        row_ind_V_1_fu_40[1 : 0] <= zext_ln214_fu_89_p1[1 : 0];
    end
end

always @ (posedge ap_clk) begin
    if ((~(row_ind_V_5_load_fu_74_p1 == 2'd1) & ~(row_ind_V_5_load_fu_74_p1 == 2'd0) & (icmp_ln283_fu_77_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state1) & (ap_start_int == 1'b1))) begin
        row_ind_V_2_fu_44[1 : 0] <= zext_ln214_fu_89_p1[1 : 0];
    end
end

always @ (posedge ap_clk) begin
    if (((row_ind_V_5_load_fu_74_p1 == 2'd0) & (icmp_ln283_fu_77_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state1) & (ap_start_int == 1'b1))) begin
        row_ind_V_fu_36[1 : 0] <= zext_ln214_fu_89_p1[1 : 0];
    end
end

always @ (*) begin
    if ((ap_start_int == 1'b0)) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln283_fu_77_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state1) & (ap_start_int == 1'b1))) begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_loop_exit_ready == 1'b1) & (1'b1 == ap_CS_fsm_state1) & (ap_start_int == 1'b1))) begin
        ap_done_int = 1'b1;
    end else begin
        ap_done_int = ap_done_reg;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) & (ap_start_int == 1'b0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) & (ap_start_int == 1'b1))) begin
        ap_ready_int = 1'b1;
    end else begin
        ap_ready_int = 1'b0;
    end
end

always @ (*) begin
    if (((ap_loop_init == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_sig_allocacmp_row_ind_V_5 = 2'd0;
    end else begin
        ap_sig_allocacmp_row_ind_V_5 = row_ind_V_3_fu_32;
    end
end

always @ (*) begin
    if (((icmp_ln283_fu_77_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state1) & (ap_start_int == 1'b1))) begin
        row_ind_V_1_out_ap_vld = 1'b1;
    end else begin
        row_ind_V_1_out_ap_vld = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln283_fu_77_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state1) & (ap_start_int == 1'b1))) begin
        row_ind_V_2_out_ap_vld = 1'b1;
    end else begin
        row_ind_V_2_out_ap_vld = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln283_fu_77_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state1) & (ap_start_int == 1'b1))) begin
        row_ind_V_out_ap_vld = 1'b1;
    end else begin
        row_ind_V_out_ap_vld = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = (ap_start_int == 1'b0);
end

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage0;

assign icmp_ln283_fu_77_p2 = ((ap_sig_allocacmp_row_ind_V_5 == 2'd3) ? 1'b1 : 1'b0);

assign init_row_ind_fu_83_p2 = (ap_sig_allocacmp_row_ind_V_5 + 2'd1);

assign row_ind_V_1_out = row_ind_V_1_fu_40;

assign row_ind_V_2_out = row_ind_V_2_fu_44;

assign row_ind_V_5_load_fu_74_p1 = ap_sig_allocacmp_row_ind_V_5;

assign row_ind_V_out = row_ind_V_fu_36;

assign zext_ln214_fu_89_p1 = ap_sig_allocacmp_row_ind_V_5;

always @ (posedge ap_clk) begin
    row_ind_V_fu_36[12:2] <= 11'b00000000000;
    row_ind_V_1_fu_40[12:2] <= 11'b00000000000;
    row_ind_V_2_fu_44[12:2] <= 11'b00000000000;
end

endmodule //color_analysis_xferode_600_1024_1_0_1_2_2_0_1025_3_3_Pipeline_VITIS_LOOP_283_1
