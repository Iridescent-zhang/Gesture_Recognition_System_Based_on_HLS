-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity test_Hu_xFResizeAreaDownScale_600_1024_1_0_1_2_2_1_300_512_1024_512_s is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    img_3_data68_dout : IN STD_LOGIC_VECTOR (7 downto 0);
    img_3_data68_num_data_valid : IN STD_LOGIC_VECTOR (1 downto 0);
    img_3_data68_fifo_cap : IN STD_LOGIC_VECTOR (1 downto 0);
    img_3_data68_empty_n : IN STD_LOGIC;
    img_3_data68_read : OUT STD_LOGIC;
    img_4_data69_din : OUT STD_LOGIC_VECTOR (7 downto 0);
    img_4_data69_num_data_valid : IN STD_LOGIC_VECTOR (1 downto 0);
    img_4_data69_fifo_cap : IN STD_LOGIC_VECTOR (1 downto 0);
    img_4_data69_full_n : IN STD_LOGIC;
    img_4_data69_write : OUT STD_LOGIC );
end;


architecture behav of test_Hu_xFResizeAreaDownScale_600_1024_1_0_1_2_2_1_300_512_1024_512_s is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (3 downto 0) := "0010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (3 downto 0) := "0100";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (3 downto 0) := "1000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv25_8000 : STD_LOGIC_VECTOR (24 downto 0) := "0000000001000000000000000";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv16_8000 : STD_LOGIC_VECTOR (15 downto 0) := "1000000000000000";
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";

attribute shreg_extract : string;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal ouput_buffer_V_address0 : STD_LOGIC_VECTOR (8 downto 0);
    signal ouput_buffer_V_ce0 : STD_LOGIC;
    signal ouput_buffer_V_we0 : STD_LOGIC;
    signal ouput_buffer_V_d0 : STD_LOGIC_VECTOR (15 downto 0);
    signal ouput_buffer_V_ce1 : STD_LOGIC;
    signal ouput_buffer_V_q1 : STD_LOGIC_VECTOR (15 downto 0);
    signal grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_start : STD_LOGIC;
    signal grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_done : STD_LOGIC;
    signal grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_idle : STD_LOGIC;
    signal grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_ready : STD_LOGIC;
    signal grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_address0 : STD_LOGIC_VECTOR (8 downto 0);
    signal grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_ce0 : STD_LOGIC;
    signal grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_we0 : STD_LOGIC;
    signal grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_d0 : STD_LOGIC_VECTOR (15 downto 0);
    signal grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_start : STD_LOGIC;
    signal grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_done : STD_LOGIC;
    signal grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_idle : STD_LOGIC;
    signal grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_ready : STD_LOGIC;
    signal grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_img_3_data68_read : STD_LOGIC;
    signal grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_img_4_data69_din : STD_LOGIC_VECTOR (7 downto 0);
    signal grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_img_4_data69_write : STD_LOGIC;
    signal grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_address0 : STD_LOGIC_VECTOR (8 downto 0);
    signal grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_ce0 : STD_LOGIC;
    signal grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_we0 : STD_LOGIC;
    signal grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_d0 : STD_LOGIC_VECTOR (15 downto 0);
    signal grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_address1 : STD_LOGIC_VECTOR (8 downto 0);
    signal grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_ce1 : STD_LOGIC;
    signal grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_start_reg : STD_LOGIC := '0';
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_start_reg : STD_LOGIC := '0';
    signal ap_CS_fsm_state3 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state3 : signal is "none";
    signal ap_CS_fsm_state4 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state4 : signal is "none";
    signal ap_NS_fsm : STD_LOGIC_VECTOR (3 downto 0);
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_ST_fsm_state2_blk : STD_LOGIC;
    signal ap_ST_fsm_state3_blk : STD_LOGIC;
    signal ap_ST_fsm_state4_blk : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component test_Hu_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4 IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        ouput_buffer_V_address0 : OUT STD_LOGIC_VECTOR (8 downto 0);
        ouput_buffer_V_ce0 : OUT STD_LOGIC;
        ouput_buffer_V_we0 : OUT STD_LOGIC;
        ouput_buffer_V_d0 : OUT STD_LOGIC_VECTOR (15 downto 0) );
    end component;


    component test_Hu_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        img_3_data68_dout : IN STD_LOGIC_VECTOR (7 downto 0);
        img_3_data68_num_data_valid : IN STD_LOGIC_VECTOR (1 downto 0);
        img_3_data68_fifo_cap : IN STD_LOGIC_VECTOR (1 downto 0);
        img_3_data68_empty_n : IN STD_LOGIC;
        img_3_data68_read : OUT STD_LOGIC;
        img_4_data69_din : OUT STD_LOGIC_VECTOR (7 downto 0);
        img_4_data69_num_data_valid : IN STD_LOGIC_VECTOR (1 downto 0);
        img_4_data69_fifo_cap : IN STD_LOGIC_VECTOR (1 downto 0);
        img_4_data69_full_n : IN STD_LOGIC;
        img_4_data69_write : OUT STD_LOGIC;
        out_div_4_cast15 : IN STD_LOGIC_VECTOR (24 downto 0);
        out_div_4_cast8 : IN STD_LOGIC_VECTOR (15 downto 0);
        conv3_i_i243_cast : IN STD_LOGIC_VECTOR (15 downto 0);
        ouput_buffer_V_address0 : OUT STD_LOGIC_VECTOR (8 downto 0);
        ouput_buffer_V_ce0 : OUT STD_LOGIC;
        ouput_buffer_V_we0 : OUT STD_LOGIC;
        ouput_buffer_V_d0 : OUT STD_LOGIC_VECTOR (15 downto 0);
        ouput_buffer_V_address1 : OUT STD_LOGIC_VECTOR (8 downto 0);
        ouput_buffer_V_ce1 : OUT STD_LOGIC;
        ouput_buffer_V_q1 : IN STD_LOGIC_VECTOR (15 downto 0);
        out_div_3 : IN STD_LOGIC_VECTOR (15 downto 0) );
    end component;


    component test_Hu_xFResizeAreaDownScale_600_1024_1_0_1_2_2_1_300_512_1024_512_s_ouput_buffer_V_eOg IS
    generic (
        DataWidth : INTEGER;
        AddressRange : INTEGER;
        AddressWidth : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR (8 downto 0);
        ce0 : IN STD_LOGIC;
        we0 : IN STD_LOGIC;
        d0 : IN STD_LOGIC_VECTOR (15 downto 0);
        address1 : IN STD_LOGIC_VECTOR (8 downto 0);
        ce1 : IN STD_LOGIC;
        q1 : OUT STD_LOGIC_VECTOR (15 downto 0) );
    end component;



begin
    ouput_buffer_V_U : component test_Hu_xFResizeAreaDownScale_600_1024_1_0_1_2_2_1_300_512_1024_512_s_ouput_buffer_V_eOg
    generic map (
        DataWidth => 16,
        AddressRange => 512,
        AddressWidth => 9)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        address0 => ouput_buffer_V_address0,
        ce0 => ouput_buffer_V_ce0,
        we0 => ouput_buffer_V_we0,
        d0 => ouput_buffer_V_d0,
        address1 => grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_address1,
        ce1 => ouput_buffer_V_ce1,
        q1 => ouput_buffer_V_q1);

    grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30 : component test_Hu_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_start,
        ap_done => grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_done,
        ap_idle => grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_idle,
        ap_ready => grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_ready,
        ouput_buffer_V_address0 => grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_address0,
        ouput_buffer_V_ce0 => grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_ce0,
        ouput_buffer_V_we0 => grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_we0,
        ouput_buffer_V_d0 => grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_d0);

    grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36 : component test_Hu_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_start,
        ap_done => grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_done,
        ap_idle => grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_idle,
        ap_ready => grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_ready,
        img_3_data68_dout => img_3_data68_dout,
        img_3_data68_num_data_valid => ap_const_lv2_0,
        img_3_data68_fifo_cap => ap_const_lv2_0,
        img_3_data68_empty_n => img_3_data68_empty_n,
        img_3_data68_read => grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_img_3_data68_read,
        img_4_data69_din => grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_img_4_data69_din,
        img_4_data69_num_data_valid => ap_const_lv2_0,
        img_4_data69_fifo_cap => ap_const_lv2_0,
        img_4_data69_full_n => img_4_data69_full_n,
        img_4_data69_write => grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_img_4_data69_write,
        out_div_4_cast15 => ap_const_lv25_8000,
        out_div_4_cast8 => ap_const_lv16_8000,
        conv3_i_i243_cast => ap_const_lv16_8000,
        ouput_buffer_V_address0 => grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_address0,
        ouput_buffer_V_ce0 => grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_ce0,
        ouput_buffer_V_we0 => grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_we0,
        ouput_buffer_V_d0 => grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_d0,
        ouput_buffer_V_address1 => grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_address1,
        ouput_buffer_V_ce1 => grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_ce1,
        ouput_buffer_V_q1 => ouput_buffer_V_q1,
        out_div_3 => ap_const_lv16_8000);





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


    grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_start_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_start_reg <= ap_const_logic_0;
            else
                if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
                    grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_start_reg <= ap_const_logic_1;
                elsif ((grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_ready = ap_const_logic_1)) then 
                    grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_start_reg <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_start_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_start_reg <= ap_const_logic_0;
            else
                if (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                    grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_start_reg <= ap_const_logic_1;
                elsif ((grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_ready = ap_const_logic_1)) then 
                    grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_start_reg <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    ap_NS_fsm_assign_proc : process (ap_start, ap_CS_fsm, ap_CS_fsm_state1, grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_done, grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_done, ap_CS_fsm_state2, ap_CS_fsm_state4)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                if (((grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_done = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then
                    ap_NS_fsm <= ap_ST_fsm_state3;
                else
                    ap_NS_fsm <= ap_ST_fsm_state2;
                end if;
            when ap_ST_fsm_state3 => 
                ap_NS_fsm <= ap_ST_fsm_state4;
            when ap_ST_fsm_state4 => 
                if (((grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_done = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state4))) then
                    ap_NS_fsm <= ap_ST_fsm_state1;
                else
                    ap_NS_fsm <= ap_ST_fsm_state4;
                end if;
            when others =>  
                ap_NS_fsm <= "XXXX";
        end case;
    end process;
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state3 <= ap_CS_fsm(2);
    ap_CS_fsm_state4 <= ap_CS_fsm(3);

    ap_ST_fsm_state1_blk_assign_proc : process(ap_start)
    begin
        if ((ap_start = ap_const_logic_0)) then 
            ap_ST_fsm_state1_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state1_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_ST_fsm_state2_blk_assign_proc : process(grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_done)
    begin
        if ((grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_done = ap_const_logic_0)) then 
            ap_ST_fsm_state2_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state2_blk <= ap_const_logic_0;
        end if; 
    end process;

    ap_ST_fsm_state3_blk <= ap_const_logic_0;

    ap_ST_fsm_state4_blk_assign_proc : process(grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_done)
    begin
        if ((grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_done = ap_const_logic_0)) then 
            ap_ST_fsm_state4_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state4_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_done_assign_proc : process(ap_start, ap_CS_fsm_state1, grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_done, ap_CS_fsm_state4)
    begin
        if ((((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1)) or ((grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_done = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state4)))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_const_logic_0;
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


    ap_ready_assign_proc : process(grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_done, ap_CS_fsm_state4)
    begin
        if (((grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_done = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state4))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;

    grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_start <= grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ap_start_reg;
    grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_start <= grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ap_start_reg;

    img_3_data68_read_assign_proc : process(grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_img_3_data68_read, ap_CS_fsm_state4)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
            img_3_data68_read <= grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_img_3_data68_read;
        else 
            img_3_data68_read <= ap_const_logic_0;
        end if; 
    end process;

    img_4_data69_din <= grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_img_4_data69_din;

    img_4_data69_write_assign_proc : process(grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_img_4_data69_write, ap_CS_fsm_state4)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
            img_4_data69_write <= grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_img_4_data69_write;
        else 
            img_4_data69_write <= ap_const_logic_0;
        end if; 
    end process;


    ouput_buffer_V_address0_assign_proc : process(grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_address0, grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_address0, ap_CS_fsm_state2, ap_CS_fsm_state4)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
            ouput_buffer_V_address0 <= grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_address0;
        elsif ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
            ouput_buffer_V_address0 <= grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_address0;
        else 
            ouput_buffer_V_address0 <= "XXXXXXXXX";
        end if; 
    end process;


    ouput_buffer_V_ce0_assign_proc : process(grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_ce0, grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_ce0, ap_CS_fsm_state2, ap_CS_fsm_state4)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
            ouput_buffer_V_ce0 <= grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_ce0;
        elsif ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
            ouput_buffer_V_ce0 <= grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_ce0;
        else 
            ouput_buffer_V_ce0 <= ap_const_logic_0;
        end if; 
    end process;


    ouput_buffer_V_ce1_assign_proc : process(grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_ce1, ap_CS_fsm_state4)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
            ouput_buffer_V_ce1 <= grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_ce1;
        else 
            ouput_buffer_V_ce1 <= ap_const_logic_0;
        end if; 
    end process;


    ouput_buffer_V_d0_assign_proc : process(grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_d0, grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_d0, ap_CS_fsm_state2, ap_CS_fsm_state4)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
            ouput_buffer_V_d0 <= grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_d0;
        elsif ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
            ouput_buffer_V_d0 <= grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_d0;
        else 
            ouput_buffer_V_d0 <= "XXXXXXXXXXXXXXXX";
        end if; 
    end process;


    ouput_buffer_V_we0_assign_proc : process(grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_we0, grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_we0, ap_CS_fsm_state2, ap_CS_fsm_state4)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
            ouput_buffer_V_we0 <= grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36_ouput_buffer_V_we0;
        elsif ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
            ouput_buffer_V_we0 <= grp_xFResizeAreaDownScale_Pipeline_VITIS_LOOP_660_4_fu_30_ouput_buffer_V_we0;
        else 
            ouput_buffer_V_we0 <= ap_const_logic_0;
        end if; 
    end process;

end behav;
