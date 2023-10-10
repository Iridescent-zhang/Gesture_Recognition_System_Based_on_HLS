-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Test_area_prmter_memcpy_1 is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    m_axi_RESULT_AWVALID : OUT STD_LOGIC;
    m_axi_RESULT_AWREADY : IN STD_LOGIC;
    m_axi_RESULT_AWADDR : OUT STD_LOGIC_VECTOR (63 downto 0);
    m_axi_RESULT_AWID : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_RESULT_AWLEN : OUT STD_LOGIC_VECTOR (31 downto 0);
    m_axi_RESULT_AWSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_RESULT_AWBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_RESULT_AWLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_RESULT_AWCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_RESULT_AWPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_RESULT_AWQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_RESULT_AWREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_RESULT_AWUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_RESULT_WVALID : OUT STD_LOGIC;
    m_axi_RESULT_WREADY : IN STD_LOGIC;
    m_axi_RESULT_WDATA : OUT STD_LOGIC_VECTOR (31 downto 0);
    m_axi_RESULT_WSTRB : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_RESULT_WLAST : OUT STD_LOGIC;
    m_axi_RESULT_WID : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_RESULT_WUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_RESULT_ARVALID : OUT STD_LOGIC;
    m_axi_RESULT_ARREADY : IN STD_LOGIC;
    m_axi_RESULT_ARADDR : OUT STD_LOGIC_VECTOR (63 downto 0);
    m_axi_RESULT_ARID : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_RESULT_ARLEN : OUT STD_LOGIC_VECTOR (31 downto 0);
    m_axi_RESULT_ARSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_RESULT_ARBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_RESULT_ARLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_RESULT_ARCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_RESULT_ARPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_RESULT_ARQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_RESULT_ARREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_RESULT_ARUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_RESULT_RVALID : IN STD_LOGIC;
    m_axi_RESULT_RREADY : OUT STD_LOGIC;
    m_axi_RESULT_RDATA : IN STD_LOGIC_VECTOR (31 downto 0);
    m_axi_RESULT_RLAST : IN STD_LOGIC;
    m_axi_RESULT_RID : IN STD_LOGIC_VECTOR (0 downto 0);
    m_axi_RESULT_RFIFONUM : IN STD_LOGIC_VECTOR (8 downto 0);
    m_axi_RESULT_RUSER : IN STD_LOGIC_VECTOR (0 downto 0);
    m_axi_RESULT_RRESP : IN STD_LOGIC_VECTOR (1 downto 0);
    m_axi_RESULT_BVALID : IN STD_LOGIC;
    m_axi_RESULT_BREADY : OUT STD_LOGIC;
    m_axi_RESULT_BRESP : IN STD_LOGIC_VECTOR (1 downto 0);
    m_axi_RESULT_BID : IN STD_LOGIC_VECTOR (0 downto 0);
    m_axi_RESULT_BUSER : IN STD_LOGIC_VECTOR (0 downto 0);
    dest_dout : IN STD_LOGIC_VECTOR (63 downto 0);
    dest_num_data_valid : IN STD_LOGIC_VECTOR (3 downto 0);
    dest_fifo_cap : IN STD_LOGIC_VECTOR (3 downto 0);
    dest_empty_n : IN STD_LOGIC;
    dest_read : OUT STD_LOGIC;
    param_address0 : OUT STD_LOGIC_VECTOR (0 downto 0);
    param_ce0 : OUT STD_LOGIC;
    param_q0 : IN STD_LOGIC_VECTOR (31 downto 0) );
end;


architecture behav of Test_area_prmter_memcpy_1 is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (1 downto 0) := "01";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (1 downto 0) := "10";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv64_0 : STD_LOGIC_VECTOR (63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv3_0 : STD_LOGIC_VECTOR (2 downto 0) := "000";
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";
    constant ap_const_lv4_0 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv9_0 : STD_LOGIC_VECTOR (8 downto 0) := "000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;

attribute shreg_extract : string;
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (1 downto 0) := "01";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal dest_blk_n : STD_LOGIC;
    signal dest_read_reg_60 : STD_LOGIC_VECTOR (63 downto 0);
    signal empty_fu_55_p1 : STD_LOGIC_VECTOR (1 downto 0);
    signal empty_reg_65 : STD_LOGIC_VECTOR (1 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_ap_start : STD_LOGIC;
    signal grp_memcpy_1_Pipeline_1_fu_44_ap_done : STD_LOGIC;
    signal grp_memcpy_1_Pipeline_1_fu_44_ap_idle : STD_LOGIC;
    signal grp_memcpy_1_Pipeline_1_fu_44_ap_ready : STD_LOGIC;
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWVALID : STD_LOGIC;
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWADDR : STD_LOGIC_VECTOR (63 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWID : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWLEN : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWSIZE : STD_LOGIC_VECTOR (2 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWBURST : STD_LOGIC_VECTOR (1 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWLOCK : STD_LOGIC_VECTOR (1 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWCACHE : STD_LOGIC_VECTOR (3 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWPROT : STD_LOGIC_VECTOR (2 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWQOS : STD_LOGIC_VECTOR (3 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWREGION : STD_LOGIC_VECTOR (3 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_WVALID : STD_LOGIC;
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_WDATA : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_WSTRB : STD_LOGIC_VECTOR (3 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_WLAST : STD_LOGIC;
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_WID : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_WUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARVALID : STD_LOGIC;
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARADDR : STD_LOGIC_VECTOR (63 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARID : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARLEN : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARSIZE : STD_LOGIC_VECTOR (2 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARBURST : STD_LOGIC_VECTOR (1 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARLOCK : STD_LOGIC_VECTOR (1 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARCACHE : STD_LOGIC_VECTOR (3 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARPROT : STD_LOGIC_VECTOR (2 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARQOS : STD_LOGIC_VECTOR (3 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARREGION : STD_LOGIC_VECTOR (3 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_RREADY : STD_LOGIC;
    signal grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_BREADY : STD_LOGIC;
    signal grp_memcpy_1_Pipeline_1_fu_44_param_address0 : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_memcpy_1_Pipeline_1_fu_44_param_ce0 : STD_LOGIC;
    signal grp_memcpy_1_Pipeline_1_fu_44_ap_start_reg : STD_LOGIC := '0';
    signal ap_block_state1_ignore_call5 : BOOLEAN;
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal ap_block_state1 : BOOLEAN;
    signal ap_NS_fsm : STD_LOGIC_VECTOR (1 downto 0);
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_ST_fsm_state2_blk : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component Test_area_prmter_memcpy_1_Pipeline_1 IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        m_axi_RESULT_AWVALID : OUT STD_LOGIC;
        m_axi_RESULT_AWREADY : IN STD_LOGIC;
        m_axi_RESULT_AWADDR : OUT STD_LOGIC_VECTOR (63 downto 0);
        m_axi_RESULT_AWID : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_RESULT_AWLEN : OUT STD_LOGIC_VECTOR (31 downto 0);
        m_axi_RESULT_AWSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
        m_axi_RESULT_AWBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
        m_axi_RESULT_AWLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
        m_axi_RESULT_AWCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_RESULT_AWPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
        m_axi_RESULT_AWQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_RESULT_AWREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_RESULT_AWUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_RESULT_WVALID : OUT STD_LOGIC;
        m_axi_RESULT_WREADY : IN STD_LOGIC;
        m_axi_RESULT_WDATA : OUT STD_LOGIC_VECTOR (31 downto 0);
        m_axi_RESULT_WSTRB : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_RESULT_WLAST : OUT STD_LOGIC;
        m_axi_RESULT_WID : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_RESULT_WUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_RESULT_ARVALID : OUT STD_LOGIC;
        m_axi_RESULT_ARREADY : IN STD_LOGIC;
        m_axi_RESULT_ARADDR : OUT STD_LOGIC_VECTOR (63 downto 0);
        m_axi_RESULT_ARID : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_RESULT_ARLEN : OUT STD_LOGIC_VECTOR (31 downto 0);
        m_axi_RESULT_ARSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
        m_axi_RESULT_ARBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
        m_axi_RESULT_ARLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
        m_axi_RESULT_ARCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_RESULT_ARPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
        m_axi_RESULT_ARQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_RESULT_ARREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_RESULT_ARUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_RESULT_RVALID : IN STD_LOGIC;
        m_axi_RESULT_RREADY : OUT STD_LOGIC;
        m_axi_RESULT_RDATA : IN STD_LOGIC_VECTOR (31 downto 0);
        m_axi_RESULT_RLAST : IN STD_LOGIC;
        m_axi_RESULT_RID : IN STD_LOGIC_VECTOR (0 downto 0);
        m_axi_RESULT_RFIFONUM : IN STD_LOGIC_VECTOR (8 downto 0);
        m_axi_RESULT_RUSER : IN STD_LOGIC_VECTOR (0 downto 0);
        m_axi_RESULT_RRESP : IN STD_LOGIC_VECTOR (1 downto 0);
        m_axi_RESULT_BVALID : IN STD_LOGIC;
        m_axi_RESULT_BREADY : OUT STD_LOGIC;
        m_axi_RESULT_BRESP : IN STD_LOGIC_VECTOR (1 downto 0);
        m_axi_RESULT_BID : IN STD_LOGIC_VECTOR (0 downto 0);
        m_axi_RESULT_BUSER : IN STD_LOGIC_VECTOR (0 downto 0);
        param_address0 : OUT STD_LOGIC_VECTOR (0 downto 0);
        param_ce0 : OUT STD_LOGIC;
        param_q0 : IN STD_LOGIC_VECTOR (31 downto 0);
        dest_load : IN STD_LOGIC_VECTOR (63 downto 0);
        dest_cast : IN STD_LOGIC_VECTOR (1 downto 0) );
    end component;



begin
    grp_memcpy_1_Pipeline_1_fu_44 : component Test_area_prmter_memcpy_1_Pipeline_1
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => grp_memcpy_1_Pipeline_1_fu_44_ap_start,
        ap_done => grp_memcpy_1_Pipeline_1_fu_44_ap_done,
        ap_idle => grp_memcpy_1_Pipeline_1_fu_44_ap_idle,
        ap_ready => grp_memcpy_1_Pipeline_1_fu_44_ap_ready,
        m_axi_RESULT_AWVALID => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWVALID,
        m_axi_RESULT_AWREADY => m_axi_RESULT_AWREADY,
        m_axi_RESULT_AWADDR => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWADDR,
        m_axi_RESULT_AWID => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWID,
        m_axi_RESULT_AWLEN => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWLEN,
        m_axi_RESULT_AWSIZE => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWSIZE,
        m_axi_RESULT_AWBURST => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWBURST,
        m_axi_RESULT_AWLOCK => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWLOCK,
        m_axi_RESULT_AWCACHE => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWCACHE,
        m_axi_RESULT_AWPROT => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWPROT,
        m_axi_RESULT_AWQOS => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWQOS,
        m_axi_RESULT_AWREGION => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWREGION,
        m_axi_RESULT_AWUSER => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWUSER,
        m_axi_RESULT_WVALID => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_WVALID,
        m_axi_RESULT_WREADY => m_axi_RESULT_WREADY,
        m_axi_RESULT_WDATA => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_WDATA,
        m_axi_RESULT_WSTRB => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_WSTRB,
        m_axi_RESULT_WLAST => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_WLAST,
        m_axi_RESULT_WID => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_WID,
        m_axi_RESULT_WUSER => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_WUSER,
        m_axi_RESULT_ARVALID => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARVALID,
        m_axi_RESULT_ARREADY => ap_const_logic_0,
        m_axi_RESULT_ARADDR => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARADDR,
        m_axi_RESULT_ARID => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARID,
        m_axi_RESULT_ARLEN => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARLEN,
        m_axi_RESULT_ARSIZE => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARSIZE,
        m_axi_RESULT_ARBURST => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARBURST,
        m_axi_RESULT_ARLOCK => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARLOCK,
        m_axi_RESULT_ARCACHE => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARCACHE,
        m_axi_RESULT_ARPROT => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARPROT,
        m_axi_RESULT_ARQOS => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARQOS,
        m_axi_RESULT_ARREGION => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARREGION,
        m_axi_RESULT_ARUSER => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_ARUSER,
        m_axi_RESULT_RVALID => ap_const_logic_0,
        m_axi_RESULT_RREADY => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_RREADY,
        m_axi_RESULT_RDATA => ap_const_lv32_0,
        m_axi_RESULT_RLAST => ap_const_logic_0,
        m_axi_RESULT_RID => ap_const_lv1_0,
        m_axi_RESULT_RFIFONUM => ap_const_lv9_0,
        m_axi_RESULT_RUSER => ap_const_lv1_0,
        m_axi_RESULT_RRESP => ap_const_lv2_0,
        m_axi_RESULT_BVALID => m_axi_RESULT_BVALID,
        m_axi_RESULT_BREADY => grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_BREADY,
        m_axi_RESULT_BRESP => m_axi_RESULT_BRESP,
        m_axi_RESULT_BID => m_axi_RESULT_BID,
        m_axi_RESULT_BUSER => m_axi_RESULT_BUSER,
        param_address0 => grp_memcpy_1_Pipeline_1_fu_44_param_address0,
        param_ce0 => grp_memcpy_1_Pipeline_1_fu_44_param_ce0,
        param_q0 => param_q0,
        dest_load => dest_read_reg_60,
        dest_cast => empty_reg_65);





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
                elsif (((ap_const_logic_1 = ap_CS_fsm_state2) and (grp_memcpy_1_Pipeline_1_fu_44_ap_done = ap_const_logic_1))) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    grp_memcpy_1_Pipeline_1_fu_44_ap_start_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                grp_memcpy_1_Pipeline_1_fu_44_ap_start_reg <= ap_const_logic_0;
            else
                if ((not(((dest_empty_n = ap_const_logic_0) or (ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                    grp_memcpy_1_Pipeline_1_fu_44_ap_start_reg <= ap_const_logic_1;
                elsif ((grp_memcpy_1_Pipeline_1_fu_44_ap_ready = ap_const_logic_1)) then 
                    grp_memcpy_1_Pipeline_1_fu_44_ap_start_reg <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;

    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state1)) then
                dest_read_reg_60 <= dest_dout;
                empty_reg_65 <= empty_fu_55_p1;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_start, ap_done_reg, ap_CS_fsm, ap_CS_fsm_state1, dest_empty_n, grp_memcpy_1_Pipeline_1_fu_44_ap_done, ap_CS_fsm_state2)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if ((not(((dest_empty_n = ap_const_logic_0) or (ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state2) and (grp_memcpy_1_Pipeline_1_fu_44_ap_done = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state1;
                else
                    ap_NS_fsm <= ap_ST_fsm_state2;
                end if;
            when others =>  
                ap_NS_fsm <= "XX";
        end case;
    end process;
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);

    ap_ST_fsm_state1_blk_assign_proc : process(ap_start, ap_done_reg, dest_empty_n)
    begin
        if (((dest_empty_n = ap_const_logic_0) or (ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) then 
            ap_ST_fsm_state1_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state1_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_ST_fsm_state2_blk_assign_proc : process(grp_memcpy_1_Pipeline_1_fu_44_ap_done)
    begin
        if ((grp_memcpy_1_Pipeline_1_fu_44_ap_done = ap_const_logic_0)) then 
            ap_ST_fsm_state2_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state2_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_block_state1_assign_proc : process(ap_start, ap_done_reg, dest_empty_n)
    begin
                ap_block_state1 <= ((dest_empty_n = ap_const_logic_0) or (ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1));
    end process;


    ap_block_state1_ignore_call5_assign_proc : process(ap_start, ap_done_reg, dest_empty_n)
    begin
                ap_block_state1_ignore_call5 <= ((dest_empty_n = ap_const_logic_0) or (ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1));
    end process;


    ap_done_assign_proc : process(ap_done_reg, grp_memcpy_1_Pipeline_1_fu_44_ap_done, ap_CS_fsm_state2)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state2) and (grp_memcpy_1_Pipeline_1_fu_44_ap_done = ap_const_logic_1))) then 
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


    ap_ready_assign_proc : process(grp_memcpy_1_Pipeline_1_fu_44_ap_done, ap_CS_fsm_state2)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state2) and (grp_memcpy_1_Pipeline_1_fu_44_ap_done = ap_const_logic_1))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    dest_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, dest_empty_n)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            dest_blk_n <= dest_empty_n;
        else 
            dest_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    dest_read_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, dest_empty_n)
    begin
        if ((not(((dest_empty_n = ap_const_logic_0) or (ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            dest_read <= ap_const_logic_1;
        else 
            dest_read <= ap_const_logic_0;
        end if; 
    end process;

    empty_fu_55_p1 <= dest_dout(2 - 1 downto 0);
    grp_memcpy_1_Pipeline_1_fu_44_ap_start <= grp_memcpy_1_Pipeline_1_fu_44_ap_start_reg;
    m_axi_RESULT_ARADDR <= ap_const_lv64_0;
    m_axi_RESULT_ARBURST <= ap_const_lv2_0;
    m_axi_RESULT_ARCACHE <= ap_const_lv4_0;
    m_axi_RESULT_ARID <= ap_const_lv1_0;
    m_axi_RESULT_ARLEN <= ap_const_lv32_0;
    m_axi_RESULT_ARLOCK <= ap_const_lv2_0;
    m_axi_RESULT_ARPROT <= ap_const_lv3_0;
    m_axi_RESULT_ARQOS <= ap_const_lv4_0;
    m_axi_RESULT_ARREGION <= ap_const_lv4_0;
    m_axi_RESULT_ARSIZE <= ap_const_lv3_0;
    m_axi_RESULT_ARUSER <= ap_const_lv1_0;
    m_axi_RESULT_ARVALID <= ap_const_logic_0;
    m_axi_RESULT_AWADDR <= grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWADDR;
    m_axi_RESULT_AWBURST <= grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWBURST;
    m_axi_RESULT_AWCACHE <= grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWCACHE;
    m_axi_RESULT_AWID <= grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWID;
    m_axi_RESULT_AWLEN <= grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWLEN;
    m_axi_RESULT_AWLOCK <= grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWLOCK;
    m_axi_RESULT_AWPROT <= grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWPROT;
    m_axi_RESULT_AWQOS <= grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWQOS;
    m_axi_RESULT_AWREGION <= grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWREGION;
    m_axi_RESULT_AWSIZE <= grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWSIZE;
    m_axi_RESULT_AWUSER <= grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWUSER;

    m_axi_RESULT_AWVALID_assign_proc : process(ap_CS_fsm_state1, grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWVALID, ap_CS_fsm_state2)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state1) or (ap_const_logic_1 = ap_CS_fsm_state2))) then 
            m_axi_RESULT_AWVALID <= grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_AWVALID;
        else 
            m_axi_RESULT_AWVALID <= ap_const_logic_0;
        end if; 
    end process;


    m_axi_RESULT_BREADY_assign_proc : process(ap_CS_fsm_state1, grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_BREADY, ap_CS_fsm_state2)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state1) or (ap_const_logic_1 = ap_CS_fsm_state2))) then 
            m_axi_RESULT_BREADY <= grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_BREADY;
        else 
            m_axi_RESULT_BREADY <= ap_const_logic_0;
        end if; 
    end process;

    m_axi_RESULT_RREADY <= ap_const_logic_0;
    m_axi_RESULT_WDATA <= grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_WDATA;
    m_axi_RESULT_WID <= grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_WID;
    m_axi_RESULT_WLAST <= grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_WLAST;
    m_axi_RESULT_WSTRB <= grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_WSTRB;
    m_axi_RESULT_WUSER <= grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_WUSER;

    m_axi_RESULT_WVALID_assign_proc : process(ap_CS_fsm_state1, grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_WVALID, ap_CS_fsm_state2)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state1) or (ap_const_logic_1 = ap_CS_fsm_state2))) then 
            m_axi_RESULT_WVALID <= grp_memcpy_1_Pipeline_1_fu_44_m_axi_RESULT_WVALID;
        else 
            m_axi_RESULT_WVALID <= ap_const_logic_0;
        end if; 
    end process;

    param_address0 <= grp_memcpy_1_Pipeline_1_fu_44_param_address0;
    param_ce0 <= grp_memcpy_1_Pipeline_1_fu_44_param_ce0;
end behav;
