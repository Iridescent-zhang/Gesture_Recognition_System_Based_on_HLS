// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Version: 2022.2
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module Test_area_prmter_ImgProcess_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols (
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
        row_mark_address0,
        row_mark_ce0,
        row_mark_we0,
        row_mark_d0,
        col_mark_address0,
        col_mark_ce0,
        col_mark_we0,
        col_mark_d0,
        area_out,
        area_out_ap_vld
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

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
output  [9:0] row_mark_address0;
output   row_mark_ce0;
output   row_mark_we0;
output  [0:0] row_mark_d0;
output  [9:0] col_mark_address0;
output   col_mark_ce0;
output   col_mark_we0;
output  [0:0] col_mark_d0;
output  [31:0] area_out;
output   area_out_ap_vld;

reg ap_idle;
reg img_1_data15_read;
reg row_mark_ce0;
reg row_mark_we0;
reg col_mark_ce0;
reg col_mark_we0;
reg area_out_ap_vld;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_idle_pp0;
wire    ap_block_state1_pp0_stage0_iter0;
reg    ap_block_state2_pp0_stage0_iter1;
wire    ap_block_state3_pp0_stage0_iter2;
reg    ap_block_pp0_stage0_subdone;
wire   [0:0] icmp_ln38_fu_138_p2;
reg    ap_condition_exit_pp0_iter0_stage0;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
reg    img_1_data15_blk_n;
wire    ap_block_pp0_stage0;
reg    ap_block_pp0_stage0_11001;
reg   [0:0] icmp_ln38_reg_268;
wire   [0:0] icmp_ln1019_fu_155_p2;
reg   [0:0] icmp_ln1019_reg_272;
wire   [63:0] zext_ln38_fu_195_p1;
wire   [63:0] zext_ln41_fu_200_p1;
reg   [10:0] j_fu_58;
wire   [10:0] add_ln41_fu_219_p2;
wire    ap_loop_init;
reg   [9:0] i_fu_62;
wire   [9:0] select_ln38_1_fu_187_p3;
reg   [19:0] indvar_flatten_fu_66;
wire   [19:0] add_ln38_fu_144_p2;
reg   [19:0] ap_sig_allocacmp_indvar_flatten_load;
reg   [31:0] area_fu_70;
wire   [31:0] area_1_fu_208_p2;
reg    ap_block_pp0_stage0_01001;
wire   [0:0] icmp_ln41_fu_167_p2;
wire   [9:0] add_ln38_1_fu_181_p2;
wire   [10:0] select_ln38_fu_173_p3;
reg    ap_done_reg;
wire    ap_continue_int;
reg    ap_done_int;
reg    ap_loop_exit_ready_pp0_iter1_reg;
reg   [0:0] ap_NS_fsm;
wire    ap_enable_pp0;
wire    ap_start_int;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_done_reg = 1'b0;
end

Test_area_prmter_flow_control_loop_pipe_sequential_init flow_control_loop_pipe_sequential_init_U(
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
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_loop_exit_ready_pp0_iter1_reg == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((1'b1 == ap_condition_exit_pp0_iter0_stage0)) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter1 <= ap_start_int;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
            area_fu_70 <= 32'd0;
        end else if (((icmp_ln1019_reg_272 == 1'd1) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
            area_fu_70 <= area_1_fu_208_p2;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
            i_fu_62 <= 10'd0;
        end else if ((ap_enable_reg_pp0_iter2 == 1'b1)) begin
            i_fu_62 <= select_ln38_1_fu_187_p3;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((icmp_ln38_fu_138_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            indvar_flatten_fu_66 <= add_ln38_fu_144_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            indvar_flatten_fu_66 <= 20'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
            j_fu_58 <= 11'd0;
        end else if ((ap_enable_reg_pp0_iter2 == 1'b1)) begin
            j_fu_58 <= add_ln41_fu_219_p2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_loop_exit_ready_pp0_iter1_reg <= ap_loop_exit_ready;
        icmp_ln1019_reg_272 <= icmp_ln1019_fu_155_p2;
        icmp_ln38_reg_268 <= icmp_ln38_fu_138_p2;
    end
end

always @ (*) begin
    if (((icmp_ln38_fu_138_p2 == 1'd1) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_loop_exit_ready_pp0_iter1_reg == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_done_int = 1'b1;
    end else begin
        ap_done_int = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_idle_pp0 == 1'b1) & (ap_start_int == 1'b0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_ready_int = 1'b1;
    end else begin
        ap_ready_int = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
        ap_sig_allocacmp_indvar_flatten_load = 20'd0;
    end else begin
        ap_sig_allocacmp_indvar_flatten_load = indvar_flatten_fu_66;
    end
end

always @ (*) begin
    if (((icmp_ln38_reg_268 == 1'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        area_out_ap_vld = 1'b1;
    end else begin
        area_out_ap_vld = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        col_mark_ce0 = 1'b1;
    end else begin
        col_mark_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln1019_reg_272 == 1'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        col_mark_we0 = 1'b1;
    end else begin
        col_mark_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        img_1_data15_blk_n = img_1_data15_empty_n;
    end else begin
        img_1_data15_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        img_1_data15_read = 1'b1;
    end else begin
        img_1_data15_read = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        row_mark_ce0 = 1'b1;
    end else begin
        row_mark_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln1019_reg_272 == 1'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        row_mark_we0 = 1'b1;
    end else begin
        row_mark_we0 = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln38_1_fu_181_p2 = (i_fu_62 + 10'd1);

assign add_ln38_fu_144_p2 = (ap_sig_allocacmp_indvar_flatten_load + 20'd1);

assign add_ln41_fu_219_p2 = (select_ln38_fu_173_p3 + 11'd1);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((img_1_data15_empty_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((img_1_data15_empty_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((img_1_data15_empty_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1));
end

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = (img_1_data15_empty_n == 1'b0);
end

assign ap_block_state3_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start_int;

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage0;

assign area_1_fu_208_p2 = (area_fu_70 + 32'd1);

assign area_out = area_fu_70;

assign col_mark_address0 = zext_ln41_fu_200_p1;

assign col_mark_d0 = 1'd1;

assign icmp_ln1019_fu_155_p2 = ((img_1_data15_dout == 8'd255) ? 1'b1 : 1'b0);

assign icmp_ln38_fu_138_p2 = ((ap_sig_allocacmp_indvar_flatten_load == 20'd614400) ? 1'b1 : 1'b0);

assign icmp_ln41_fu_167_p2 = ((j_fu_58 == 11'd1024) ? 1'b1 : 1'b0);

assign row_mark_address0 = zext_ln38_fu_195_p1;

assign row_mark_d0 = 1'd1;

assign select_ln38_1_fu_187_p3 = ((icmp_ln41_fu_167_p2[0:0] == 1'b1) ? add_ln38_1_fu_181_p2 : i_fu_62);

assign select_ln38_fu_173_p3 = ((icmp_ln41_fu_167_p2[0:0] == 1'b1) ? 11'd0 : j_fu_58);

assign zext_ln38_fu_195_p1 = select_ln38_1_fu_187_p3;

assign zext_ln41_fu_200_p1 = select_ln38_fu_173_p3;

endmodule //Test_area_prmter_ImgProcess_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols
