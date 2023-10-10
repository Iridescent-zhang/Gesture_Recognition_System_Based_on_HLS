// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Version: 2022.2
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module CAL_Hu_Loop_1_proc_Pipeline_1 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        m_axi_RESULT_AWVALID,
        m_axi_RESULT_AWREADY,
        m_axi_RESULT_AWADDR,
        m_axi_RESULT_AWID,
        m_axi_RESULT_AWLEN,
        m_axi_RESULT_AWSIZE,
        m_axi_RESULT_AWBURST,
        m_axi_RESULT_AWLOCK,
        m_axi_RESULT_AWCACHE,
        m_axi_RESULT_AWPROT,
        m_axi_RESULT_AWQOS,
        m_axi_RESULT_AWREGION,
        m_axi_RESULT_AWUSER,
        m_axi_RESULT_WVALID,
        m_axi_RESULT_WREADY,
        m_axi_RESULT_WDATA,
        m_axi_RESULT_WSTRB,
        m_axi_RESULT_WLAST,
        m_axi_RESULT_WID,
        m_axi_RESULT_WUSER,
        m_axi_RESULT_ARVALID,
        m_axi_RESULT_ARREADY,
        m_axi_RESULT_ARADDR,
        m_axi_RESULT_ARID,
        m_axi_RESULT_ARLEN,
        m_axi_RESULT_ARSIZE,
        m_axi_RESULT_ARBURST,
        m_axi_RESULT_ARLOCK,
        m_axi_RESULT_ARCACHE,
        m_axi_RESULT_ARPROT,
        m_axi_RESULT_ARQOS,
        m_axi_RESULT_ARREGION,
        m_axi_RESULT_ARUSER,
        m_axi_RESULT_RVALID,
        m_axi_RESULT_RREADY,
        m_axi_RESULT_RDATA,
        m_axi_RESULT_RLAST,
        m_axi_RESULT_RID,
        m_axi_RESULT_RFIFONUM,
        m_axi_RESULT_RUSER,
        m_axi_RESULT_RRESP,
        m_axi_RESULT_BVALID,
        m_axi_RESULT_BREADY,
        m_axi_RESULT_BRESP,
        m_axi_RESULT_BID,
        m_axi_RESULT_BUSER,
        sext_ln31,
        M2int_address0,
        M2int_ce0,
        M2int_q0
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
output   m_axi_RESULT_AWVALID;
input   m_axi_RESULT_AWREADY;
output  [63:0] m_axi_RESULT_AWADDR;
output  [0:0] m_axi_RESULT_AWID;
output  [31:0] m_axi_RESULT_AWLEN;
output  [2:0] m_axi_RESULT_AWSIZE;
output  [1:0] m_axi_RESULT_AWBURST;
output  [1:0] m_axi_RESULT_AWLOCK;
output  [3:0] m_axi_RESULT_AWCACHE;
output  [2:0] m_axi_RESULT_AWPROT;
output  [3:0] m_axi_RESULT_AWQOS;
output  [3:0] m_axi_RESULT_AWREGION;
output  [0:0] m_axi_RESULT_AWUSER;
output   m_axi_RESULT_WVALID;
input   m_axi_RESULT_WREADY;
output  [31:0] m_axi_RESULT_WDATA;
output  [3:0] m_axi_RESULT_WSTRB;
output   m_axi_RESULT_WLAST;
output  [0:0] m_axi_RESULT_WID;
output  [0:0] m_axi_RESULT_WUSER;
output   m_axi_RESULT_ARVALID;
input   m_axi_RESULT_ARREADY;
output  [63:0] m_axi_RESULT_ARADDR;
output  [0:0] m_axi_RESULT_ARID;
output  [31:0] m_axi_RESULT_ARLEN;
output  [2:0] m_axi_RESULT_ARSIZE;
output  [1:0] m_axi_RESULT_ARBURST;
output  [1:0] m_axi_RESULT_ARLOCK;
output  [3:0] m_axi_RESULT_ARCACHE;
output  [2:0] m_axi_RESULT_ARPROT;
output  [3:0] m_axi_RESULT_ARQOS;
output  [3:0] m_axi_RESULT_ARREGION;
output  [0:0] m_axi_RESULT_ARUSER;
input   m_axi_RESULT_RVALID;
output   m_axi_RESULT_RREADY;
input  [31:0] m_axi_RESULT_RDATA;
input   m_axi_RESULT_RLAST;
input  [0:0] m_axi_RESULT_RID;
input  [8:0] m_axi_RESULT_RFIFONUM;
input  [0:0] m_axi_RESULT_RUSER;
input  [1:0] m_axi_RESULT_RRESP;
input   m_axi_RESULT_BVALID;
output   m_axi_RESULT_BREADY;
input  [1:0] m_axi_RESULT_BRESP;
input  [0:0] m_axi_RESULT_BID;
input  [0:0] m_axi_RESULT_BUSER;
input  [61:0] sext_ln31;
output  [0:0] M2int_address0;
output   M2int_ce0;
input  [31:0] M2int_q0;

reg ap_idle;
reg m_axi_RESULT_WVALID;
reg M2int_ce0;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_idle_pp0;
wire    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
wire    ap_block_state3_pp0_stage0_iter2;
reg    ap_block_pp0_stage0_subdone;
wire   [0:0] exitcond_fu_91_p2;
reg    ap_condition_exit_pp0_iter0_stage0;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
reg    RESULT_blk_n_W;
wire    ap_block_pp0_stage0;
reg    ap_block_pp0_stage0_11001;
reg   [0:0] exitcond_reg_130;
reg   [31:0] M2int_load_reg_144;
reg    ap_condition_exit_pp0_iter1_stage0;
wire   [63:0] loop_index_cast_fu_103_p1;
wire    ap_block_pp0_stage0_01001;
reg   [1:0] loop_index_fu_48;
wire   [1:0] empty_fu_97_p2;
wire    ap_loop_init;
reg   [1:0] ap_sig_allocacmp_loop_index_load;
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

CAL_Hu_flow_control_loop_pipe_sequential_init flow_control_loop_pipe_sequential_init_U(
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
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_exit_ready_pp0_iter1_reg == 1'b1))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter1 <= ap_start_int;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b1 == ap_condition_exit_pp0_iter1_stage0)) begin
            ap_enable_reg_pp0_iter2 <= 1'b0;
        end else if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((exitcond_fu_91_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            loop_index_fu_48 <= empty_fu_97_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            loop_index_fu_48 <= 2'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (exitcond_reg_130 == 1'd0))) begin
        M2int_load_reg_144 <= M2int_q0;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_loop_exit_ready_pp0_iter1_reg <= ap_loop_exit_ready;
        exitcond_reg_130 <= exitcond_fu_91_p2;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        M2int_ce0 = 1'b1;
    end else begin
        M2int_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        RESULT_blk_n_W = m_axi_RESULT_WREADY;
    end else begin
        RESULT_blk_n_W = 1'b1;
    end
end

always @ (*) begin
    if (((exitcond_fu_91_p2 == 1'd1) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (exitcond_reg_130 == 1'd1))) begin
        ap_condition_exit_pp0_iter1_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter1_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_exit_ready_pp0_iter1_reg == 1'b1))) begin
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
        ap_sig_allocacmp_loop_index_load = 2'd0;
    end else begin
        ap_sig_allocacmp_loop_index_load = loop_index_fu_48;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        m_axi_RESULT_WVALID = 1'b1;
    end else begin
        m_axi_RESULT_WVALID = 1'b0;
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

assign M2int_address0 = loop_index_cast_fu_103_p1;

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_01001 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((m_axi_RESULT_WREADY == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((m_axi_RESULT_WREADY == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1));
end

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state3_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start_int;

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage0;

assign empty_fu_97_p2 = (ap_sig_allocacmp_loop_index_load + 2'd1);

assign exitcond_fu_91_p2 = ((ap_sig_allocacmp_loop_index_load == 2'd2) ? 1'b1 : 1'b0);

assign loop_index_cast_fu_103_p1 = ap_sig_allocacmp_loop_index_load;

assign m_axi_RESULT_ARADDR = 64'd0;

assign m_axi_RESULT_ARBURST = 2'd0;

assign m_axi_RESULT_ARCACHE = 4'd0;

assign m_axi_RESULT_ARID = 1'd0;

assign m_axi_RESULT_ARLEN = 32'd0;

assign m_axi_RESULT_ARLOCK = 2'd0;

assign m_axi_RESULT_ARPROT = 3'd0;

assign m_axi_RESULT_ARQOS = 4'd0;

assign m_axi_RESULT_ARREGION = 4'd0;

assign m_axi_RESULT_ARSIZE = 3'd0;

assign m_axi_RESULT_ARUSER = 1'd0;

assign m_axi_RESULT_ARVALID = 1'b0;

assign m_axi_RESULT_AWADDR = 64'd0;

assign m_axi_RESULT_AWBURST = 2'd0;

assign m_axi_RESULT_AWCACHE = 4'd0;

assign m_axi_RESULT_AWID = 1'd0;

assign m_axi_RESULT_AWLEN = 32'd0;

assign m_axi_RESULT_AWLOCK = 2'd0;

assign m_axi_RESULT_AWPROT = 3'd0;

assign m_axi_RESULT_AWQOS = 4'd0;

assign m_axi_RESULT_AWREGION = 4'd0;

assign m_axi_RESULT_AWSIZE = 3'd0;

assign m_axi_RESULT_AWUSER = 1'd0;

assign m_axi_RESULT_AWVALID = 1'b0;

assign m_axi_RESULT_BREADY = 1'b0;

assign m_axi_RESULT_RREADY = 1'b0;

assign m_axi_RESULT_WDATA = M2int_load_reg_144;

assign m_axi_RESULT_WID = 1'd0;

assign m_axi_RESULT_WLAST = 1'b0;

assign m_axi_RESULT_WSTRB = 4'd15;

assign m_axi_RESULT_WUSER = 1'd0;

endmodule //CAL_Hu_Loop_1_proc_Pipeline_1
