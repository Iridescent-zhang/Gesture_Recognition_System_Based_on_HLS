-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity color_analysis_xfMat2AXIvideo_24_9_600_1024_1_2_s is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    p_read : IN STD_LOGIC_VECTOR (31 downto 0);
    p_read1 : IN STD_LOGIC_VECTOR (31 downto 0);
    img_5_data170_dout : IN STD_LOGIC_VECTOR (23 downto 0);
    img_5_data170_num_data_valid : IN STD_LOGIC_VECTOR (1 downto 0);
    img_5_data170_fifo_cap : IN STD_LOGIC_VECTOR (1 downto 0);
    img_5_data170_empty_n : IN STD_LOGIC;
    img_5_data170_read : OUT STD_LOGIC;
    OUTPUT_STREAM_VIDEO_TDATA : OUT STD_LOGIC_VECTOR (23 downto 0);
    OUTPUT_STREAM_VIDEO_TVALID : OUT STD_LOGIC;
    OUTPUT_STREAM_VIDEO_TREADY : IN STD_LOGIC;
    OUTPUT_STREAM_VIDEO_TKEEP : OUT STD_LOGIC_VECTOR (2 downto 0);
    OUTPUT_STREAM_VIDEO_TSTRB : OUT STD_LOGIC_VECTOR (2 downto 0);
    OUTPUT_STREAM_VIDEO_TUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
    OUTPUT_STREAM_VIDEO_TLAST : OUT STD_LOGIC_VECTOR (0 downto 0);
    OUTPUT_STREAM_VIDEO_TID : OUT STD_LOGIC_VECTOR (0 downto 0);
    OUTPUT_STREAM_VIDEO_TDEST : OUT STD_LOGIC_VECTOR (0 downto 0) );
end;


architecture behav of color_analysis_xfMat2AXIvideo_24_9_600_1024_1_2_s is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (3 downto 0) := "0010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (3 downto 0) := "0100";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (3 downto 0) := "1000";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv10_0 : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv10_3FF : STD_LOGIC_VECTOR (9 downto 0) := "1111111111";
    constant ap_const_lv10_1 : STD_LOGIC_VECTOR (9 downto 0) := "0000000001";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";

attribute shreg_extract : string;
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal empty_fu_109_p1 : STD_LOGIC_VECTOR (10 downto 0);
    signal empty_reg_189 : STD_LOGIC_VECTOR (10 downto 0);
    signal sub_fu_117_p2 : STD_LOGIC_VECTOR (9 downto 0);
    signal sub_reg_194 : STD_LOGIC_VECTOR (9 downto 0);
    signal cmp101_fu_123_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal cmp101_reg_199 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_4_fu_151_p2 : STD_LOGIC_VECTOR (9 downto 0);
    signal i_4_reg_206 : STD_LOGIC_VECTOR (9 downto 0);
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_ap_start : STD_LOGIC;
    signal grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_ap_done : STD_LOGIC;
    signal grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_ap_idle : STD_LOGIC;
    signal grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_ap_ready : STD_LOGIC;
    signal grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_img_5_data170_read : STD_LOGIC;
    signal grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TREADY : STD_LOGIC;
    signal grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TDATA : STD_LOGIC_VECTOR (23 downto 0);
    signal grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TVALID : STD_LOGIC;
    signal grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TKEEP : STD_LOGIC_VECTOR (2 downto 0);
    signal grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TSTRB : STD_LOGIC_VECTOR (2 downto 0);
    signal grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TLAST : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TID : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TDEST : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_ap_start_reg : STD_LOGIC := '0';
    signal icmp_ln197_fu_146_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_CS_fsm_state3 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state3 : signal is "none";
    signal i_fu_66 : STD_LOGIC_VECTOR (9 downto 0);
    signal ap_block_state3_on_subcall_done : BOOLEAN;
    signal ap_block_state1 : BOOLEAN;
    signal sof_fu_70 : STD_LOGIC_VECTOR (0 downto 0);
    signal empty_67_fu_113_p1 : STD_LOGIC_VECTOR (9 downto 0);
    signal zext_ln197_fu_142_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_CS_fsm_state4 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state4 : signal is "none";
    signal regslice_both_OUTPUT_STREAM_VIDEO_V_data_V_U_apdone_blk : STD_LOGIC;
    signal ap_NS_fsm : STD_LOGIC_VECTOR (3 downto 0);
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_ST_fsm_state2_blk : STD_LOGIC;
    signal ap_ST_fsm_state3_blk : STD_LOGIC;
    signal ap_ST_fsm_state4_blk : STD_LOGIC;
    signal OUTPUT_STREAM_VIDEO_TVALID_int_regslice : STD_LOGIC;
    signal OUTPUT_STREAM_VIDEO_TREADY_int_regslice : STD_LOGIC;
    signal regslice_both_OUTPUT_STREAM_VIDEO_V_data_V_U_vld_out : STD_LOGIC;
    signal regslice_both_OUTPUT_STREAM_VIDEO_V_keep_V_U_apdone_blk : STD_LOGIC;
    signal regslice_both_OUTPUT_STREAM_VIDEO_V_keep_V_U_ack_in_dummy : STD_LOGIC;
    signal regslice_both_OUTPUT_STREAM_VIDEO_V_keep_V_U_vld_out : STD_LOGIC;
    signal regslice_both_OUTPUT_STREAM_VIDEO_V_strb_V_U_apdone_blk : STD_LOGIC;
    signal regslice_both_OUTPUT_STREAM_VIDEO_V_strb_V_U_ack_in_dummy : STD_LOGIC;
    signal regslice_both_OUTPUT_STREAM_VIDEO_V_strb_V_U_vld_out : STD_LOGIC;
    signal regslice_both_OUTPUT_STREAM_VIDEO_V_user_V_U_apdone_blk : STD_LOGIC;
    signal regslice_both_OUTPUT_STREAM_VIDEO_V_user_V_U_ack_in_dummy : STD_LOGIC;
    signal regslice_both_OUTPUT_STREAM_VIDEO_V_user_V_U_vld_out : STD_LOGIC;
    signal regslice_both_OUTPUT_STREAM_VIDEO_V_last_V_U_apdone_blk : STD_LOGIC;
    signal regslice_both_OUTPUT_STREAM_VIDEO_V_last_V_U_ack_in_dummy : STD_LOGIC;
    signal regslice_both_OUTPUT_STREAM_VIDEO_V_last_V_U_vld_out : STD_LOGIC;
    signal regslice_both_OUTPUT_STREAM_VIDEO_V_id_V_U_apdone_blk : STD_LOGIC;
    signal regslice_both_OUTPUT_STREAM_VIDEO_V_id_V_U_ack_in_dummy : STD_LOGIC;
    signal regslice_both_OUTPUT_STREAM_VIDEO_V_id_V_U_vld_out : STD_LOGIC;
    signal regslice_both_OUTPUT_STREAM_VIDEO_V_dest_V_U_apdone_blk : STD_LOGIC;
    signal regslice_both_OUTPUT_STREAM_VIDEO_V_dest_V_U_ack_in_dummy : STD_LOGIC;
    signal regslice_both_OUTPUT_STREAM_VIDEO_V_dest_V_U_vld_out : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component color_analysis_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        img_5_data170_dout : IN STD_LOGIC_VECTOR (23 downto 0);
        img_5_data170_num_data_valid : IN STD_LOGIC_VECTOR (1 downto 0);
        img_5_data170_fifo_cap : IN STD_LOGIC_VECTOR (1 downto 0);
        img_5_data170_empty_n : IN STD_LOGIC;
        img_5_data170_read : OUT STD_LOGIC;
        OUTPUT_STREAM_VIDEO_TREADY : IN STD_LOGIC;
        sof : IN STD_LOGIC_VECTOR (0 downto 0);
        p_read1 : IN STD_LOGIC_VECTOR (10 downto 0);
        sub : IN STD_LOGIC_VECTOR (9 downto 0);
        OUTPUT_STREAM_VIDEO_TDATA : OUT STD_LOGIC_VECTOR (23 downto 0);
        OUTPUT_STREAM_VIDEO_TVALID : OUT STD_LOGIC;
        OUTPUT_STREAM_VIDEO_TKEEP : OUT STD_LOGIC_VECTOR (2 downto 0);
        OUTPUT_STREAM_VIDEO_TSTRB : OUT STD_LOGIC_VECTOR (2 downto 0);
        OUTPUT_STREAM_VIDEO_TUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
        OUTPUT_STREAM_VIDEO_TLAST : OUT STD_LOGIC_VECTOR (0 downto 0);
        OUTPUT_STREAM_VIDEO_TID : OUT STD_LOGIC_VECTOR (0 downto 0);
        OUTPUT_STREAM_VIDEO_TDEST : OUT STD_LOGIC_VECTOR (0 downto 0) );
    end component;


    component color_analysis_regslice_both IS
    generic (
        DataWidth : INTEGER );
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        data_in : IN STD_LOGIC_VECTOR (DataWidth-1 downto 0);
        vld_in : IN STD_LOGIC;
        ack_in : OUT STD_LOGIC;
        data_out : OUT STD_LOGIC_VECTOR (DataWidth-1 downto 0);
        vld_out : OUT STD_LOGIC;
        ack_out : IN STD_LOGIC;
        apdone_blk : OUT STD_LOGIC );
    end component;



begin
    grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86 : component color_analysis_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_ap_start,
        ap_done => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_ap_done,
        ap_idle => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_ap_idle,
        ap_ready => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_ap_ready,
        img_5_data170_dout => img_5_data170_dout,
        img_5_data170_num_data_valid => ap_const_lv2_0,
        img_5_data170_fifo_cap => ap_const_lv2_0,
        img_5_data170_empty_n => img_5_data170_empty_n,
        img_5_data170_read => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_img_5_data170_read,
        OUTPUT_STREAM_VIDEO_TREADY => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TREADY,
        sof => sof_fu_70,
        p_read1 => empty_reg_189,
        sub => sub_reg_194,
        OUTPUT_STREAM_VIDEO_TDATA => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TDATA,
        OUTPUT_STREAM_VIDEO_TVALID => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TVALID,
        OUTPUT_STREAM_VIDEO_TKEEP => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TKEEP,
        OUTPUT_STREAM_VIDEO_TSTRB => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TSTRB,
        OUTPUT_STREAM_VIDEO_TUSER => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TUSER,
        OUTPUT_STREAM_VIDEO_TLAST => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TLAST,
        OUTPUT_STREAM_VIDEO_TID => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TID,
        OUTPUT_STREAM_VIDEO_TDEST => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TDEST);

    regslice_both_OUTPUT_STREAM_VIDEO_V_data_V_U : component color_analysis_regslice_both
    generic map (
        DataWidth => 24)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TDATA,
        vld_in => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TVALID,
        ack_in => OUTPUT_STREAM_VIDEO_TREADY_int_regslice,
        data_out => OUTPUT_STREAM_VIDEO_TDATA,
        vld_out => regslice_both_OUTPUT_STREAM_VIDEO_V_data_V_U_vld_out,
        ack_out => OUTPUT_STREAM_VIDEO_TREADY,
        apdone_blk => regslice_both_OUTPUT_STREAM_VIDEO_V_data_V_U_apdone_blk);

    regslice_both_OUTPUT_STREAM_VIDEO_V_keep_V_U : component color_analysis_regslice_both
    generic map (
        DataWidth => 3)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TKEEP,
        vld_in => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TVALID,
        ack_in => regslice_both_OUTPUT_STREAM_VIDEO_V_keep_V_U_ack_in_dummy,
        data_out => OUTPUT_STREAM_VIDEO_TKEEP,
        vld_out => regslice_both_OUTPUT_STREAM_VIDEO_V_keep_V_U_vld_out,
        ack_out => OUTPUT_STREAM_VIDEO_TREADY,
        apdone_blk => regslice_both_OUTPUT_STREAM_VIDEO_V_keep_V_U_apdone_blk);

    regslice_both_OUTPUT_STREAM_VIDEO_V_strb_V_U : component color_analysis_regslice_both
    generic map (
        DataWidth => 3)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TSTRB,
        vld_in => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TVALID,
        ack_in => regslice_both_OUTPUT_STREAM_VIDEO_V_strb_V_U_ack_in_dummy,
        data_out => OUTPUT_STREAM_VIDEO_TSTRB,
        vld_out => regslice_both_OUTPUT_STREAM_VIDEO_V_strb_V_U_vld_out,
        ack_out => OUTPUT_STREAM_VIDEO_TREADY,
        apdone_blk => regslice_both_OUTPUT_STREAM_VIDEO_V_strb_V_U_apdone_blk);

    regslice_both_OUTPUT_STREAM_VIDEO_V_user_V_U : component color_analysis_regslice_both
    generic map (
        DataWidth => 1)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TUSER,
        vld_in => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TVALID,
        ack_in => regslice_both_OUTPUT_STREAM_VIDEO_V_user_V_U_ack_in_dummy,
        data_out => OUTPUT_STREAM_VIDEO_TUSER,
        vld_out => regslice_both_OUTPUT_STREAM_VIDEO_V_user_V_U_vld_out,
        ack_out => OUTPUT_STREAM_VIDEO_TREADY,
        apdone_blk => regslice_both_OUTPUT_STREAM_VIDEO_V_user_V_U_apdone_blk);

    regslice_both_OUTPUT_STREAM_VIDEO_V_last_V_U : component color_analysis_regslice_both
    generic map (
        DataWidth => 1)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TLAST,
        vld_in => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TVALID,
        ack_in => regslice_both_OUTPUT_STREAM_VIDEO_V_last_V_U_ack_in_dummy,
        data_out => OUTPUT_STREAM_VIDEO_TLAST,
        vld_out => regslice_both_OUTPUT_STREAM_VIDEO_V_last_V_U_vld_out,
        ack_out => OUTPUT_STREAM_VIDEO_TREADY,
        apdone_blk => regslice_both_OUTPUT_STREAM_VIDEO_V_last_V_U_apdone_blk);

    regslice_both_OUTPUT_STREAM_VIDEO_V_id_V_U : component color_analysis_regslice_both
    generic map (
        DataWidth => 1)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TID,
        vld_in => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TVALID,
        ack_in => regslice_both_OUTPUT_STREAM_VIDEO_V_id_V_U_ack_in_dummy,
        data_out => OUTPUT_STREAM_VIDEO_TID,
        vld_out => regslice_both_OUTPUT_STREAM_VIDEO_V_id_V_U_vld_out,
        ack_out => OUTPUT_STREAM_VIDEO_TREADY,
        apdone_blk => regslice_both_OUTPUT_STREAM_VIDEO_V_id_V_U_apdone_blk);

    regslice_both_OUTPUT_STREAM_VIDEO_V_dest_V_U : component color_analysis_regslice_both
    generic map (
        DataWidth => 1)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TDEST,
        vld_in => grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TVALID,
        ack_in => regslice_both_OUTPUT_STREAM_VIDEO_V_dest_V_U_ack_in_dummy,
        data_out => OUTPUT_STREAM_VIDEO_TDEST,
        vld_out => regslice_both_OUTPUT_STREAM_VIDEO_V_dest_V_U_vld_out,
        ack_out => OUTPUT_STREAM_VIDEO_TREADY,
        apdone_blk => regslice_both_OUTPUT_STREAM_VIDEO_V_dest_V_U_apdone_blk);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_state1;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_done_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_done_reg <= ap_const_logic_0;
            else
                if ((ap_continue = ap_const_logic_1)) then 
                    ap_done_reg <= ap_const_logic_0;
                elsif (((ap_const_logic_1 = ap_CS_fsm_state4) and (regslice_both_OUTPUT_STREAM_VIDEO_V_data_V_U_apdone_blk = ap_const_logic_0))) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_ap_start_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_ap_start_reg <= ap_const_logic_0;
            else
                if (((icmp_ln197_fu_146_p2 = ap_const_lv1_1) and (cmp101_reg_199 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
                    grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_ap_start_reg <= ap_const_logic_1;
                elsif ((grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_ap_ready = ap_const_logic_1)) then 
                    grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_ap_start_reg <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    i_fu_66_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                i_fu_66 <= ap_const_lv10_0;
            elsif (((ap_const_logic_1 = ap_CS_fsm_state3) and (ap_const_boolean_0 = ap_block_state3_on_subcall_done))) then 
                i_fu_66 <= i_4_reg_206;
            end if; 
        end if;
    end process;

    sof_fu_70_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                sof_fu_70 <= ap_const_lv1_1;
            elsif (((cmp101_reg_199 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state3) and (ap_const_boolean_0 = ap_block_state3_on_subcall_done))) then 
                sof_fu_70 <= ap_const_lv1_0;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state1)) then
                cmp101_reg_199 <= cmp101_fu_123_p2;
                empty_reg_189 <= empty_fu_109_p1;
                sub_reg_194 <= sub_fu_117_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state2)) then
                i_4_reg_206 <= i_4_fu_151_p2;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_start, ap_done_reg, ap_CS_fsm, ap_CS_fsm_state1, ap_CS_fsm_state2, icmp_ln197_fu_146_p2, ap_CS_fsm_state3, ap_block_state3_on_subcall_done, ap_CS_fsm_state4, regslice_both_OUTPUT_STREAM_VIDEO_V_data_V_U_apdone_blk)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                if (((icmp_ln197_fu_146_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then
                    ap_NS_fsm <= ap_ST_fsm_state3;
                else
                    ap_NS_fsm <= ap_ST_fsm_state4;
                end if;
            when ap_ST_fsm_state3 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state3) and (ap_const_boolean_0 = ap_block_state3_on_subcall_done))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state3;
                end if;
            when ap_ST_fsm_state4 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state4) and (regslice_both_OUTPUT_STREAM_VIDEO_V_data_V_U_apdone_blk = ap_const_logic_0))) then
                    ap_NS_fsm <= ap_ST_fsm_state1;
                else
                    ap_NS_fsm <= ap_ST_fsm_state4;
                end if;
            when others =>  
                ap_NS_fsm <= "XXXX";
        end case;
    end process;
    OUTPUT_STREAM_VIDEO_TVALID <= regslice_both_OUTPUT_STREAM_VIDEO_V_data_V_U_vld_out;
    OUTPUT_STREAM_VIDEO_TVALID_int_regslice <= grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TVALID;
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state3 <= ap_CS_fsm(2);
    ap_CS_fsm_state4 <= ap_CS_fsm(3);

    ap_ST_fsm_state1_blk_assign_proc : process(ap_start, ap_done_reg)
    begin
        if (((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) then 
            ap_ST_fsm_state1_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state1_blk <= ap_const_logic_0;
        end if; 
    end process;

    ap_ST_fsm_state2_blk <= ap_const_logic_0;

    ap_ST_fsm_state3_blk_assign_proc : process(ap_block_state3_on_subcall_done)
    begin
        if ((ap_const_boolean_1 = ap_block_state3_on_subcall_done)) then 
            ap_ST_fsm_state3_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state3_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_ST_fsm_state4_blk_assign_proc : process(regslice_both_OUTPUT_STREAM_VIDEO_V_data_V_U_apdone_blk)
    begin
        if ((regslice_both_OUTPUT_STREAM_VIDEO_V_data_V_U_apdone_blk = ap_const_logic_1)) then 
            ap_ST_fsm_state4_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state4_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_block_state1_assign_proc : process(ap_start, ap_done_reg)
    begin
                ap_block_state1 <= ((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1));
    end process;


    ap_block_state3_on_subcall_done_assign_proc : process(cmp101_reg_199, grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_ap_done)
    begin
                ap_block_state3_on_subcall_done <= ((grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_ap_done = ap_const_logic_0) and (cmp101_reg_199 = ap_const_lv1_1));
    end process;


    ap_done_assign_proc : process(ap_done_reg, ap_CS_fsm_state4, regslice_both_OUTPUT_STREAM_VIDEO_V_data_V_U_apdone_blk)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state4) and (regslice_both_OUTPUT_STREAM_VIDEO_V_data_V_U_apdone_blk = ap_const_logic_0))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_done_reg;
        end if; 
    end process;


    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(ap_CS_fsm_state4, regslice_both_OUTPUT_STREAM_VIDEO_V_data_V_U_apdone_blk)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state4) and (regslice_both_OUTPUT_STREAM_VIDEO_V_data_V_U_apdone_blk = ap_const_logic_0))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;

    cmp101_fu_123_p2 <= "1" when (signed(p_read1) > signed(ap_const_lv32_0)) else "0";
    empty_67_fu_113_p1 <= p_read1(10 - 1 downto 0);
    empty_fu_109_p1 <= p_read1(11 - 1 downto 0);
    grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_OUTPUT_STREAM_VIDEO_TREADY <= (ap_CS_fsm_state3 and OUTPUT_STREAM_VIDEO_TREADY_int_regslice);
    grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_ap_start <= grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_ap_start_reg;
    i_4_fu_151_p2 <= std_logic_vector(unsigned(i_fu_66) + unsigned(ap_const_lv10_1));
    icmp_ln197_fu_146_p2 <= "1" when (signed(zext_ln197_fu_142_p1) < signed(p_read)) else "0";

    img_5_data170_read_assign_proc : process(cmp101_reg_199, grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_img_5_data170_read, ap_CS_fsm_state3)
    begin
        if (((cmp101_reg_199 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state3))) then 
            img_5_data170_read <= grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86_img_5_data170_read;
        else 
            img_5_data170_read <= ap_const_logic_0;
        end if; 
    end process;

    sub_fu_117_p2 <= std_logic_vector(unsigned(empty_67_fu_113_p1) + unsigned(ap_const_lv10_3FF));
    zext_ln197_fu_142_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(i_fu_66),32));
end behav;
