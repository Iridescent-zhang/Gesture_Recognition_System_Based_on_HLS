// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Version: 2022.2
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module Test_area_prmter_memcpy_1_Pipeline_1 (
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
        param_address0,
        param_ce0,
        param_q0,
        dest_load,
        dest_cast
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
output  [0:0] param_address0;
output   param_ce0;
input  [31:0] param_q0;
input  [63:0] dest_load;
input  [1:0] dest_cast;

reg ap_idle;
reg m_axi_RESULT_AWVALID;
reg m_axi_RESULT_WVALID;
reg m_axi_RESULT_BREADY;
reg param_ce0;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_enable_reg_pp0_iter3;
reg    ap_enable_reg_pp0_iter4;
reg    ap_enable_reg_pp0_iter5;
reg    ap_enable_reg_pp0_iter6;
reg    ap_enable_reg_pp0_iter7;
reg    ap_idle_pp0;
wire    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
wire    ap_block_state3_pp0_stage0_iter2;
wire    ap_block_state4_pp0_stage0_iter3;
wire    ap_block_state5_pp0_stage0_iter4;
wire    ap_block_state6_pp0_stage0_iter5;
wire    ap_block_state7_pp0_stage0_iter6;
reg    ap_block_state8_pp0_stage0_iter7;
reg    ap_block_pp0_stage0_subdone;
wire   [0:0] exitcond_fu_173_p2;
reg    ap_condition_exit_pp0_iter0_stage0;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
reg    RESULT_blk_n_AW;
wire    ap_block_pp0_stage0;
reg    RESULT_blk_n_W;
reg    RESULT_blk_n_B;
reg    ap_block_pp0_stage0_11001;
wire   [1:0] empty_fu_137_p1;
reg   [1:0] empty_reg_258;
reg   [63:0] RESULT_addr_reg_264;
wire   [3:0] empty_48_fu_217_p2;
reg   [3:0] empty_48_reg_274;
wire   [31:0] empty_49_fu_235_p2;
reg   [31:0] empty_49_reg_279;
wire   [63:0] p_cast6_fu_132_p1;
wire  signed [63:0] p_cast2_cast_fu_157_p1;
reg    ap_block_pp0_stage0_01001;
reg   [2:0] loop_index_fu_68;
wire   [2:0] p_cast4_fu_167_p2;
wire    ap_loop_init;
reg   [2:0] ap_sig_allocacmp_loop_index_load;
wire   [0:0] tmp_fu_124_p3;
wire   [63:0] loop_index_cast5_fu_120_p1;
wire   [63:0] empty_46_fu_141_p2;
wire   [61:0] p_cast2_fu_147_p4;
wire   [4:0] tmp_2_fu_184_p3;
wire   [31:0] p_cast7_fu_191_p1;
wire   [31:0] empty_44_fu_195_p2;
wire   [7:0] empty_45_fu_201_p1;
wire   [1:0] empty_47_fu_209_p2;
wire   [3:0] p_cast8_fu_213_p1;
wire   [4:0] tmp_3_fu_223_p3;
wire   [31:0] p_cast_cast_fu_205_p1;
wire   [31:0] p_cast9_fu_231_p1;
reg    ap_done_reg;
wire    ap_continue_int;
reg    ap_done_int;
reg    ap_loop_exit_ready_pp0_iter1_reg;
reg    ap_loop_exit_ready_pp0_iter2_reg;
reg    ap_loop_exit_ready_pp0_iter3_reg;
reg    ap_loop_exit_ready_pp0_iter4_reg;
reg    ap_loop_exit_ready_pp0_iter5_reg;
reg    ap_loop_exit_ready_pp0_iter6_reg;
reg    ap_loop_exit_ready_pp0_iter7_reg;
reg   [0:0] ap_NS_fsm;
wire    ap_enable_pp0;
wire    ap_start_int;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_enable_reg_pp0_iter3 = 1'b0;
#0 ap_enable_reg_pp0_iter4 = 1'b0;
#0 ap_enable_reg_pp0_iter5 = 1'b0;
#0 ap_enable_reg_pp0_iter6 = 1'b0;
#0 ap_enable_reg_pp0_iter7 = 1'b0;
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
        end else if (((ap_loop_exit_ready_pp0_iter7_reg == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
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
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter3 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter4 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter4 <= ap_enable_reg_pp0_iter3;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter5 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter5 <= ap_enable_reg_pp0_iter4;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter6 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter6 <= ap_enable_reg_pp0_iter5;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter7 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter7 <= ap_enable_reg_pp0_iter6;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((ap_loop_exit_ready_pp0_iter6_reg == 1'b0) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
        ap_loop_exit_ready_pp0_iter7_reg <= 1'b0;
    end else if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        ap_loop_exit_ready_pp0_iter7_reg <= ap_loop_exit_ready_pp0_iter6_reg;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        if (((ap_enable_reg_pp0_iter0 == 1'b1) & (exitcond_fu_173_p2 == 1'd0))) begin
            loop_index_fu_68 <= p_cast4_fu_167_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            loop_index_fu_68 <= 3'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        RESULT_addr_reg_264 <= p_cast2_cast_fu_157_p1;
        ap_loop_exit_ready_pp0_iter1_reg <= ap_loop_exit_ready;
        ap_loop_exit_ready_pp0_iter2_reg <= ap_loop_exit_ready_pp0_iter1_reg;
        empty_48_reg_274 <= empty_48_fu_217_p2;
        empty_49_reg_279 <= empty_49_fu_235_p2;
        empty_reg_258 <= empty_fu_137_p1;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        ap_loop_exit_ready_pp0_iter3_reg <= ap_loop_exit_ready_pp0_iter2_reg;
        ap_loop_exit_ready_pp0_iter4_reg <= ap_loop_exit_ready_pp0_iter3_reg;
        ap_loop_exit_ready_pp0_iter5_reg <= ap_loop_exit_ready_pp0_iter4_reg;
        ap_loop_exit_ready_pp0_iter6_reg <= ap_loop_exit_ready_pp0_iter5_reg;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        RESULT_blk_n_AW = m_axi_RESULT_AWREADY;
    end else begin
        RESULT_blk_n_AW = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter7 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        RESULT_blk_n_B = m_axi_RESULT_BVALID;
    end else begin
        RESULT_blk_n_B = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0))) begin
        RESULT_blk_n_W = m_axi_RESULT_WREADY;
    end else begin
        RESULT_blk_n_W = 1'b1;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (exitcond_fu_173_p2 == 1'd1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_loop_exit_ready_pp0_iter7_reg == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
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
    if (((ap_enable_reg_pp0_iter7 == 1'b0) & (ap_enable_reg_pp0_iter6 == 1'b0) & (ap_enable_reg_pp0_iter5 == 1'b0) & (ap_enable_reg_pp0_iter4 == 1'b0) & (ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
        ap_ready_int = 1'b1;
    end else begin
        ap_ready_int = 1'b0;
    end
end

always @ (*) begin
    if (((ap_loop_init == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        ap_sig_allocacmp_loop_index_load = 3'd0;
    end else begin
        ap_sig_allocacmp_loop_index_load = loop_index_fu_68;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        m_axi_RESULT_AWVALID = 1'b1;
    end else begin
        m_axi_RESULT_AWVALID = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter7 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        m_axi_RESULT_BREADY = 1'b1;
    end else begin
        m_axi_RESULT_BREADY = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        m_axi_RESULT_WVALID = 1'b1;
    end else begin
        m_axi_RESULT_WVALID = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        param_ce0 = 1'b1;
    end else begin
        param_ce0 = 1'b0;
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

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((m_axi_RESULT_BVALID == 1'b0) & (ap_enable_reg_pp0_iter7 == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((m_axi_RESULT_BVALID == 1'b0) & (ap_enable_reg_pp0_iter7 == 1'b1)) | ((m_axi_RESULT_WREADY == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1)) | ((m_axi_RESULT_AWREADY == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((m_axi_RESULT_BVALID == 1'b0) & (ap_enable_reg_pp0_iter7 == 1'b1)) | ((m_axi_RESULT_WREADY == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b1)) | ((m_axi_RESULT_AWREADY == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)));
end

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state3_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_block_state4_pp0_stage0_iter3 = ~(1'b1 == 1'b1);

assign ap_block_state5_pp0_stage0_iter4 = ~(1'b1 == 1'b1);

assign ap_block_state6_pp0_stage0_iter5 = ~(1'b1 == 1'b1);

assign ap_block_state7_pp0_stage0_iter6 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state8_pp0_stage0_iter7 = (m_axi_RESULT_BVALID == 1'b0);
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start_int;

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage0;

assign empty_44_fu_195_p2 = param_q0 >> p_cast7_fu_191_p1;

assign empty_45_fu_201_p1 = empty_44_fu_195_p2[7:0];

assign empty_46_fu_141_p2 = (dest_load + loop_index_cast5_fu_120_p1);

assign empty_47_fu_209_p2 = (empty_reg_258 + dest_cast);

assign empty_48_fu_217_p2 = 4'd1 << p_cast8_fu_213_p1;

assign empty_49_fu_235_p2 = p_cast_cast_fu_205_p1 << p_cast9_fu_231_p1;

assign empty_fu_137_p1 = ap_sig_allocacmp_loop_index_load[1:0];

assign exitcond_fu_173_p2 = ((ap_sig_allocacmp_loop_index_load == 3'd7) ? 1'b1 : 1'b0);

assign loop_index_cast5_fu_120_p1 = ap_sig_allocacmp_loop_index_load;

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

assign m_axi_RESULT_AWADDR = RESULT_addr_reg_264;

assign m_axi_RESULT_AWBURST = 2'd0;

assign m_axi_RESULT_AWCACHE = 4'd0;

assign m_axi_RESULT_AWID = 1'd0;

assign m_axi_RESULT_AWLEN = 32'd1;

assign m_axi_RESULT_AWLOCK = 2'd0;

assign m_axi_RESULT_AWPROT = 3'd0;

assign m_axi_RESULT_AWQOS = 4'd0;

assign m_axi_RESULT_AWREGION = 4'd0;

assign m_axi_RESULT_AWSIZE = 3'd0;

assign m_axi_RESULT_AWUSER = 1'd0;

assign m_axi_RESULT_RREADY = 1'b0;

assign m_axi_RESULT_WDATA = empty_49_reg_279;

assign m_axi_RESULT_WID = 1'd0;

assign m_axi_RESULT_WLAST = 1'b0;

assign m_axi_RESULT_WSTRB = empty_48_reg_274;

assign m_axi_RESULT_WUSER = 1'd0;

assign p_cast2_cast_fu_157_p1 = $signed(p_cast2_fu_147_p4);

assign p_cast2_fu_147_p4 = {{empty_46_fu_141_p2[63:2]}};

assign p_cast4_fu_167_p2 = (ap_sig_allocacmp_loop_index_load + 3'd1);

assign p_cast6_fu_132_p1 = tmp_fu_124_p3;

assign p_cast7_fu_191_p1 = tmp_2_fu_184_p3;

assign p_cast8_fu_213_p1 = empty_47_fu_209_p2;

assign p_cast9_fu_231_p1 = tmp_3_fu_223_p3;

assign p_cast_cast_fu_205_p1 = empty_45_fu_201_p1;

assign param_address0 = p_cast6_fu_132_p1;

assign tmp_2_fu_184_p3 = {{empty_reg_258}, {3'd0}};

assign tmp_3_fu_223_p3 = {{empty_47_fu_209_p2}, {3'd0}};

assign tmp_fu_124_p3 = ap_sig_allocacmp_loop_index_load[32'd2];

endmodule //Test_area_prmter_memcpy_1_Pipeline_1