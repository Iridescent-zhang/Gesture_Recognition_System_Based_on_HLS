// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Version: 2022.2
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module color_analysis_entry_proc (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        cb_lower,
        cb_lower_c_din,
        cb_lower_c_num_data_valid,
        cb_lower_c_fifo_cap,
        cb_lower_c_full_n,
        cb_lower_c_write,
        cb_upper,
        cb_upper_c_din,
        cb_upper_c_num_data_valid,
        cb_upper_c_fifo_cap,
        cb_upper_c_full_n,
        cb_upper_c_write,
        cr_lower,
        cr_lower_c_din,
        cr_lower_c_num_data_valid,
        cr_lower_c_fifo_cap,
        cr_lower_c_full_n,
        cr_lower_c_write,
        cr_upper,
        cr_upper_c_din,
        cr_upper_c_num_data_valid,
        cr_upper_c_fifo_cap,
        cr_upper_c_full_n,
        cr_upper_c_write
);

parameter    ap_ST_fsm_state1 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [31:0] cb_lower;
output  [31:0] cb_lower_c_din;
input  [3:0] cb_lower_c_num_data_valid;
input  [3:0] cb_lower_c_fifo_cap;
input   cb_lower_c_full_n;
output   cb_lower_c_write;
input  [31:0] cb_upper;
output  [31:0] cb_upper_c_din;
input  [3:0] cb_upper_c_num_data_valid;
input  [3:0] cb_upper_c_fifo_cap;
input   cb_upper_c_full_n;
output   cb_upper_c_write;
input  [31:0] cr_lower;
output  [31:0] cr_lower_c_din;
input  [3:0] cr_lower_c_num_data_valid;
input  [3:0] cr_lower_c_fifo_cap;
input   cr_lower_c_full_n;
output   cr_lower_c_write;
input  [31:0] cr_upper;
output  [31:0] cr_upper_c_din;
input  [3:0] cr_upper_c_num_data_valid;
input  [3:0] cr_upper_c_fifo_cap;
input   cr_upper_c_full_n;
output   cr_upper_c_write;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg cb_lower_c_write;
reg cb_upper_c_write;
reg cr_lower_c_write;
reg cr_upper_c_write;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    cb_lower_c_blk_n;
reg    cb_upper_c_blk_n;
reg    cr_lower_c_blk_n;
reg    cr_upper_c_blk_n;
reg    ap_block_state1;
reg   [0:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 1'd1;
end

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
        end else if ((~((ap_start == 1'b0) | (cr_upper_c_full_n == 1'b0) | (cr_lower_c_full_n == 1'b0) | (cb_upper_c_full_n == 1'b0) | (cb_lower_c_full_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) | (cr_upper_c_full_n == 1'b0) | (cr_lower_c_full_n == 1'b0) | (cb_upper_c_full_n == 1'b0) | (cb_lower_c_full_n == 1'b0) | (ap_done_reg == 1'b1))) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (cr_upper_c_full_n == 1'b0) | (cr_lower_c_full_n == 1'b0) | (cb_upper_c_full_n == 1'b0) | (cb_lower_c_full_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (cr_upper_c_full_n == 1'b0) | (cr_lower_c_full_n == 1'b0) | (cb_upper_c_full_n == 1'b0) | (cb_lower_c_full_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        cb_lower_c_blk_n = cb_lower_c_full_n;
    end else begin
        cb_lower_c_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (cr_upper_c_full_n == 1'b0) | (cr_lower_c_full_n == 1'b0) | (cb_upper_c_full_n == 1'b0) | (cb_lower_c_full_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        cb_lower_c_write = 1'b1;
    end else begin
        cb_lower_c_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        cb_upper_c_blk_n = cb_upper_c_full_n;
    end else begin
        cb_upper_c_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (cr_upper_c_full_n == 1'b0) | (cr_lower_c_full_n == 1'b0) | (cb_upper_c_full_n == 1'b0) | (cb_lower_c_full_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        cb_upper_c_write = 1'b1;
    end else begin
        cb_upper_c_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        cr_lower_c_blk_n = cr_lower_c_full_n;
    end else begin
        cr_lower_c_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (cr_upper_c_full_n == 1'b0) | (cr_lower_c_full_n == 1'b0) | (cb_upper_c_full_n == 1'b0) | (cb_lower_c_full_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        cr_lower_c_write = 1'b1;
    end else begin
        cr_lower_c_write = 1'b0;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        cr_upper_c_blk_n = cr_upper_c_full_n;
    end else begin
        cr_upper_c_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (cr_upper_c_full_n == 1'b0) | (cr_lower_c_full_n == 1'b0) | (cb_upper_c_full_n == 1'b0) | (cb_lower_c_full_n == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        cr_upper_c_write = 1'b1;
    end else begin
        cr_upper_c_write = 1'b0;
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
    ap_block_state1 = ((ap_start == 1'b0) | (cr_upper_c_full_n == 1'b0) | (cr_lower_c_full_n == 1'b0) | (cb_upper_c_full_n == 1'b0) | (cb_lower_c_full_n == 1'b0) | (ap_done_reg == 1'b1));
end

assign cb_lower_c_din = cb_lower;

assign cb_upper_c_din = cb_upper;

assign cr_lower_c_din = cr_lower;

assign cr_upper_c_din = cr_upper;

endmodule //color_analysis_entry_proc