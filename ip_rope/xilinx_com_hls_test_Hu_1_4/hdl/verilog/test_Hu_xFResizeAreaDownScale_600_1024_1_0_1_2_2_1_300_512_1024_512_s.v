// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Version: 2022.2
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module test_Hu_xFResizeAreaDownScale_600_1024_1_0_1_2_2_1_300_512_1024_512_s (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        img_3_data68_dout,
        img_3_data68_num_data_valid,
        img_3_data68_fifo_cap,
        img_3_data68_empty_n,
        img_3_data68_read,
        img_4_data69_din,
        img_4_data69_num_data_valid,
        img_4_data69_fifo_cap,
        img_4_data69_full_n,
        img_4_data69_write
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [7:0] img_3_data68_dout;
input  [1:0] img_3_data68_num_data_valid;
input  [1:0] img_3_data68_fifo_cap;
input   img_3_data68_empty_n;
output   img_3_data68_read;
output  [7:0] img_4_data69_din;
input  [1:0] img_4_data69_num_data_valid;
input  [1:0] img_4_data69_fifo_cap;
input   img_4_data69_full_n;
output   img_4_data69_write;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg img_3_data68_read;
reg img_4_data69_write;

(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg   [8:0] ouput_buffer_V_address0;
reg    ouput_buffer_V_ce0;
reg    ouput_buffer_V_we0;
reg   [15:0] ouput_buffer_V_d0;
reg    ouput_buffer_V_ce1;
wire   [15:0] ouput_buffer_V_q1;
wire    grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_start;
wire    grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_done;
wire    grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_idle;
wire    grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_ready;
wire   [8:0] grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_address0;
wire    grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_ce0;
wire    grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_we0;
wire   [15:0] grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_d0;
wire    grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_start;
wire    grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_done;
wire    grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_idle;
wire    grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_ready;
wire    grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_img_3_data68_read;
wire   [7:0] grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_img_4_data69_din;
wire    grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_img_4_data69_write;
wire   [8:0] grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_address0;
wire    grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_ce0;
wire    grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_we0;
wire   [15:0] grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_d0;
wire   [8:0] grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_address1;
wire    grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_ce1;
reg    grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_start_reg;
wire    ap_CS_fsm_state2;
reg    grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_start_reg;
wire    ap_CS_fsm_state3;
wire    ap_CS_fsm_state4;
reg   [3:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
reg    ap_ST_fsm_state2_blk;
wire    ap_ST_fsm_state3_blk;
reg    ap_ST_fsm_state4_blk;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 4'd1;
#0 grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_start_reg = 1'b0;
#0 grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_start_reg = 1'b0;
end

test_Hu_xFResizeAreaDownScale_600_1024_1_0_1_2_2_1_300_512_1024_512_s_ouput_buffer_V_eOg #(
    .DataWidth( 16 ),
    .AddressRange( 512 ),
    .AddressWidth( 9 ))
ouput_buffer_V_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(ouput_buffer_V_address0),
    .ce0(ouput_buffer_V_ce0),
    .we0(ouput_buffer_V_we0),
    .d0(ouput_buffer_V_d0),
    .address1(grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_address1),
    .ce1(ouput_buffer_V_ce1),
    .q1(ouput_buffer_V_q1)
);

test_Hu_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4 grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_start),
    .ap_done(grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_done),
    .ap_idle(grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_idle),
    .ap_ready(grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_ready),
    .ouput_buffer_V_address0(grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_address0),
    .ouput_buffer_V_ce0(grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_ce0),
    .ouput_buffer_V_we0(grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_we0),
    .ouput_buffer_V_d0(grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_d0)
);

test_Hu_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_start),
    .ap_done(grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_done),
    .ap_idle(grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_idle),
    .ap_ready(grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_ready),
    .img_3_data68_dout(img_3_data68_dout),
    .img_3_data68_num_data_valid(2'd0),
    .img_3_data68_fifo_cap(2'd0),
    .img_3_data68_empty_n(img_3_data68_empty_n),
    .img_3_data68_read(grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_img_3_data68_read),
    .img_4_data69_din(grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_img_4_data69_din),
    .img_4_data69_num_data_valid(2'd0),
    .img_4_data69_fifo_cap(2'd0),
    .img_4_data69_full_n(img_4_data69_full_n),
    .img_4_data69_write(grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_img_4_data69_write),
    .out_div_4_cast15(25'd32768),
    .out_div_4_cast8(16'd32768),
    .conv3_i_i243_cast(16'd32768),
    .ouput_buffer_V_address0(grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_address0),
    .ouput_buffer_V_ce0(grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_ce0),
    .ouput_buffer_V_we0(grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_we0),
    .ouput_buffer_V_d0(grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_d0),
    .ouput_buffer_V_address1(grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_address1),
    .ouput_buffer_V_ce1(grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_ce1),
    .ouput_buffer_V_q1(ouput_buffer_V_q1),
    .out_div_3(16'd32768)
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
        grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state3)) begin
            grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_start_reg <= 1'b1;
        end else if ((grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_ready == 1'b1)) begin
            grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_start_reg <= 1'b0;
    end else begin
        if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_start_reg <= 1'b1;
        end else if ((grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_ready == 1'b1)) begin
            grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_start_reg <= 1'b0;
        end
    end
end

always @ (*) begin
    if ((ap_start == 1'b0)) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

always @ (*) begin
    if ((grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_done == 1'b0)) begin
        ap_ST_fsm_state2_blk = 1'b1;
    end else begin
        ap_ST_fsm_state2_blk = 1'b0;
    end
end

assign ap_ST_fsm_state3_blk = 1'b0;

always @ (*) begin
    if ((grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_done == 1'b0)) begin
        ap_ST_fsm_state4_blk = 1'b1;
    end else begin
        ap_ST_fsm_state4_blk = 1'b0;
    end
end

always @ (*) begin
    if ((((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)) | ((grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state4)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
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
    if (((grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state4))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        img_3_data68_read = grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_img_3_data68_read;
    end else begin
        img_3_data68_read = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        img_4_data69_write = grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_img_4_data69_write;
    end else begin
        img_4_data69_write = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        ouput_buffer_V_address0 = grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_address0;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        ouput_buffer_V_address0 = grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_address0;
    end else begin
        ouput_buffer_V_address0 = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        ouput_buffer_V_ce0 = grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_ce0;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        ouput_buffer_V_ce0 = grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_ce0;
    end else begin
        ouput_buffer_V_ce0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        ouput_buffer_V_ce1 = grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_ce1;
    end else begin
        ouput_buffer_V_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        ouput_buffer_V_d0 = grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_d0;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        ouput_buffer_V_d0 = grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_d0;
    end else begin
        ouput_buffer_V_d0 = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        ouput_buffer_V_we0 = grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_we0;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        ouput_buffer_V_we0 = grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_we0;
    end else begin
        ouput_buffer_V_we0 = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            if (((grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end
        end
        ap_ST_fsm_state3 : begin
            ap_NS_fsm = ap_ST_fsm_state4;
        end
        ap_ST_fsm_state4 : begin
            if (((grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state4))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

assign grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_start = grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_start_reg;

assign grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_start = grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_start_reg;

assign img_4_data69_din = grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_img_4_data69_din;

endmodule //test_Hu_xFResizeAreaDownScale_600_1024_1_0_1_2_2_1_300_512_1024_512_s
