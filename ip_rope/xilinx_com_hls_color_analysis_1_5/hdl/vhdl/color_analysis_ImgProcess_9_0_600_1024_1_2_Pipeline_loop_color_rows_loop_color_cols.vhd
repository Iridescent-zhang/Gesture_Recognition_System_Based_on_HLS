-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity color_analysis_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    img_1_data164_dout : IN STD_LOGIC_VECTOR (23 downto 0);
    img_1_data164_num_data_valid : IN STD_LOGIC_VECTOR (1 downto 0);
    img_1_data164_fifo_cap : IN STD_LOGIC_VECTOR (1 downto 0);
    img_1_data164_empty_n : IN STD_LOGIC;
    img_1_data164_read : OUT STD_LOGIC;
    img_2_data165_din : OUT STD_LOGIC_VECTOR (7 downto 0);
    img_2_data165_num_data_valid : IN STD_LOGIC_VECTOR (1 downto 0);
    img_2_data165_fifo_cap : IN STD_LOGIC_VECTOR (1 downto 0);
    img_2_data165_full_n : IN STD_LOGIC;
    img_2_data165_write : OUT STD_LOGIC;
    bound : IN STD_LOGIC_VECTOR (63 downto 0);
    cb_lower_load : IN STD_LOGIC_VECTOR (31 downto 0);
    cb_upper_load : IN STD_LOGIC_VECTOR (31 downto 0);
    cr_lower_load : IN STD_LOGIC_VECTOR (31 downto 0);
    cr_upper_load : IN STD_LOGIC_VECTOR (31 downto 0) );
end;


architecture behav of color_analysis_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv64_0 : STD_LOGIC_VECTOR (63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv64_1 : STD_LOGIC_VECTOR (63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000001";
    constant ap_const_lv32_10 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000010000";
    constant ap_const_lv32_17 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000010111";
    constant ap_const_lv32_8 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001000";
    constant ap_const_lv32_F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001111";
    constant ap_const_lv15_7FD5 : STD_LOGIC_VECTOR (14 downto 0) := "111111111010101";
    constant ap_const_lv7_0 : STD_LOGIC_VECTOR (6 downto 0) := "0000000";
    constant ap_const_lv8_80 : STD_LOGIC_VECTOR (7 downto 0) := "10000000";
    constant ap_const_lv8_FF : STD_LOGIC_VECTOR (7 downto 0) := "11111111";
    constant ap_const_lv8_0 : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    constant ap_const_lv15_55 : STD_LOGIC_VECTOR (14 downto 0) := "000000001010101";
    constant ap_const_lv15_6B : STD_LOGIC_VECTOR (14 downto 0) := "000000001101011";
    constant ap_const_lv13_15 : STD_LOGIC_VECTOR (12 downto 0) := "0000000010101";

attribute shreg_extract : string;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (0 downto 0) := "1";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC;
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter2 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter3 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter4 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter5 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter6 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter7 : STD_LOGIC := '0';
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state2_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_state3_pp0_stage0_iter2 : BOOLEAN;
    signal ap_block_state4_pp0_stage0_iter3 : BOOLEAN;
    signal ap_block_state5_pp0_stage0_iter4 : BOOLEAN;
    signal ap_block_state6_pp0_stage0_iter5 : BOOLEAN;
    signal ap_block_state7_pp0_stage0_iter6 : BOOLEAN;
    signal ap_block_state8_pp0_stage0_iter7 : BOOLEAN;
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal icmp_ln22_fu_137_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_condition_exit_pp0_iter1_stage0 : STD_LOGIC;
    signal ap_loop_exit_ready : STD_LOGIC;
    signal ap_ready_int : STD_LOGIC;
    signal img_1_data164_blk_n : STD_LOGIC;
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal img_2_data165_blk_n : STD_LOGIC;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal B_V_fu_153_p1 : STD_LOGIC_VECTOR (7 downto 0);
    signal B_V_reg_367 : STD_LOGIC_VECTOR (7 downto 0);
    signal B_V_reg_367_pp0_iter3_reg : STD_LOGIC_VECTOR (7 downto 0);
    signal B_V_reg_367_pp0_iter4_reg : STD_LOGIC_VECTOR (7 downto 0);
    signal trunc_ln_reg_373 : STD_LOGIC_VECTOR (7 downto 0);
    signal trunc_ln_reg_373_pp0_iter3_reg : STD_LOGIC_VECTOR (7 downto 0);
    signal zext_ln1494_2_fu_177_p1 : STD_LOGIC_VECTOR (14 downto 0);
    signal trunc_ln1_reg_400 : STD_LOGIC_VECTOR (7 downto 0);
    signal grp_fu_314_p3 : STD_LOGIC_VECTOR (15 downto 0);
    signal icmp_ln1035_fu_258_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln1035_reg_410 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln1027_fu_263_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln1027_reg_415 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln1035_8_fu_272_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln1035_8_reg_420 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln1027_102_fu_277_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln1027_102_reg_425 : STD_LOGIC_VECTOR (0 downto 0);
    signal indvar_flatten_fu_82 : STD_LOGIC_VECTOR (63 downto 0);
    signal add_ln22_fu_142_p2 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_loop_init : STD_LOGIC;
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal tmp_fu_167_p4 : STD_LOGIC_VECTOR (7 downto 0);
    signal ret_V_10_fu_187_p0 : STD_LOGIC_VECTOR (7 downto 0);
    signal ret_V_10_fu_187_p1 : STD_LOGIC_VECTOR (6 downto 0);
    signal ret_V_10_fu_187_p2 : STD_LOGIC_VECTOR (14 downto 0);
    signal ret_V_13_fu_197_p3 : STD_LOGIC_VECTOR (14 downto 0);
    signal ret_V_12_fu_208_p3 : STD_LOGIC_VECTOR (14 downto 0);
    signal grp_fu_305_p3 : STD_LOGIC_VECTOR (15 downto 0);
    signal zext_ln1495_fu_215_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal ret_V_4_fu_219_p2 : STD_LOGIC_VECTOR (15 downto 0);
    attribute use_dsp48 : string;
    attribute use_dsp48 of ret_V_4_fu_219_p2 : signal is "no";
    signal grp_fu_322_p3 : STD_LOGIC_VECTOR (15 downto 0);
    signal trunc_ln1669_1_fu_239_p4 : STD_LOGIC_VECTOR (7 downto 0);
    signal Cb_V_fu_234_p2 : STD_LOGIC_VECTOR (7 downto 0);
    signal zext_ln1035_fu_254_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal Cr_V_fu_248_p2 : STD_LOGIC_VECTOR (7 downto 0);
    signal zext_ln1035_1_fu_268_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal and_ln40_1_fu_286_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln40_fu_282_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln40_2_fu_290_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_fu_305_p0 : STD_LOGIC_VECTOR (7 downto 0);
    signal grp_fu_305_p1 : STD_LOGIC_VECTOR (6 downto 0);
    signal grp_fu_314_p0 : STD_LOGIC_VECTOR (7 downto 0);
    signal grp_fu_314_p1 : STD_LOGIC_VECTOR (6 downto 0);
    signal grp_fu_314_p2 : STD_LOGIC_VECTOR (14 downto 0);
    signal grp_fu_322_p0 : STD_LOGIC_VECTOR (7 downto 0);
    signal grp_fu_322_p1 : STD_LOGIC_VECTOR (4 downto 0);
    signal grp_fu_305_ce : STD_LOGIC;
    signal grp_fu_314_ce : STD_LOGIC;
    signal grp_fu_322_ce : STD_LOGIC;
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_continue_int : STD_LOGIC;
    signal ap_done_int : STD_LOGIC;
    signal ap_loop_exit_ready_pp0_iter2_reg : STD_LOGIC;
    signal ap_loop_exit_ready_pp0_iter3_reg : STD_LOGIC;
    signal ap_loop_exit_ready_pp0_iter4_reg : STD_LOGIC;
    signal ap_loop_exit_ready_pp0_iter5_reg : STD_LOGIC;
    signal ap_loop_exit_ready_pp0_iter6_reg : STD_LOGIC;
    signal ap_NS_fsm : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_enable_pp0 : STD_LOGIC;
    signal ap_start_int : STD_LOGIC;
    signal grp_fu_314_p20 : STD_LOGIC_VECTOR (15 downto 0);
    signal grp_fu_322_p00 : STD_LOGIC_VECTOR (12 downto 0);
    signal ret_V_10_fu_187_p00 : STD_LOGIC_VECTOR (14 downto 0);
    signal ap_ce_reg : STD_LOGIC;

    component color_analysis_mul_8ns_7s_15_1_1 IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        din0 : IN STD_LOGIC_VECTOR (7 downto 0);
        din1 : IN STD_LOGIC_VECTOR (6 downto 0);
        dout : OUT STD_LOGIC_VECTOR (14 downto 0) );
    end component;


    component color_analysis_mac_mulsub_8ns_7ns_15s_16_4_1 IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        din2_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (7 downto 0);
        din1 : IN STD_LOGIC_VECTOR (6 downto 0);
        din2 : IN STD_LOGIC_VECTOR (14 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (15 downto 0) );
    end component;


    component color_analysis_mac_mulsub_8ns_7ns_15ns_16_4_1 IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        din2_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (7 downto 0);
        din1 : IN STD_LOGIC_VECTOR (6 downto 0);
        din2 : IN STD_LOGIC_VECTOR (14 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (15 downto 0) );
    end component;


    component color_analysis_mac_mulsub_8ns_5ns_16ns_16_4_1 IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        din2_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (7 downto 0);
        din1 : IN STD_LOGIC_VECTOR (4 downto 0);
        din2 : IN STD_LOGIC_VECTOR (15 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (15 downto 0) );
    end component;


    component color_analysis_flow_control_loop_pipe_sequential_init IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_start_int : OUT STD_LOGIC;
        ap_loop_init : OUT STD_LOGIC;
        ap_ready_int : IN STD_LOGIC;
        ap_loop_exit_ready : IN STD_LOGIC;
        ap_loop_exit_done : IN STD_LOGIC;
        ap_continue_int : OUT STD_LOGIC;
        ap_done_int : IN STD_LOGIC );
    end component;



begin
    mul_8ns_7s_15_1_1_U123 : component color_analysis_mul_8ns_7s_15_1_1
    generic map (
        ID => 1,
        NUM_STAGE => 1,
        din0_WIDTH => 8,
        din1_WIDTH => 7,
        dout_WIDTH => 15)
    port map (
        din0 => ret_V_10_fu_187_p0,
        din1 => ret_V_10_fu_187_p1,
        dout => ret_V_10_fu_187_p2);

    mac_mulsub_8ns_7ns_15s_16_4_1_U124 : component color_analysis_mac_mulsub_8ns_7ns_15s_16_4_1
    generic map (
        ID => 1,
        NUM_STAGE => 4,
        din0_WIDTH => 8,
        din1_WIDTH => 7,
        din2_WIDTH => 15,
        dout_WIDTH => 16)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => grp_fu_305_p0,
        din1 => grp_fu_305_p1,
        din2 => ret_V_10_fu_187_p2,
        ce => grp_fu_305_ce,
        dout => grp_fu_305_p3);

    mac_mulsub_8ns_7ns_15ns_16_4_1_U125 : component color_analysis_mac_mulsub_8ns_7ns_15ns_16_4_1
    generic map (
        ID => 1,
        NUM_STAGE => 4,
        din0_WIDTH => 8,
        din1_WIDTH => 7,
        din2_WIDTH => 15,
        dout_WIDTH => 16)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => grp_fu_314_p0,
        din1 => grp_fu_314_p1,
        din2 => grp_fu_314_p2,
        ce => grp_fu_314_ce,
        dout => grp_fu_314_p3);

    mac_mulsub_8ns_5ns_16ns_16_4_1_U126 : component color_analysis_mac_mulsub_8ns_5ns_16ns_16_4_1
    generic map (
        ID => 1,
        NUM_STAGE => 4,
        din0_WIDTH => 8,
        din1_WIDTH => 5,
        din2_WIDTH => 16,
        dout_WIDTH => 16)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => grp_fu_322_p0,
        din1 => grp_fu_322_p1,
        din2 => grp_fu_314_p3,
        ce => grp_fu_322_ce,
        dout => grp_fu_322_p3);

    flow_control_loop_pipe_sequential_init_U : component color_analysis_flow_control_loop_pipe_sequential_init
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => ap_start,
        ap_ready => ap_ready,
        ap_done => ap_done,
        ap_start_int => ap_start_int,
        ap_loop_init => ap_loop_init,
        ap_ready_int => ap_ready_int,
        ap_loop_exit_ready => ap_condition_exit_pp0_iter1_stage0,
        ap_loop_exit_done => ap_done_int,
        ap_continue_int => ap_continue_int,
        ap_done_int => ap_done_int);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
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
                if ((ap_continue_int = ap_const_logic_1)) then 
                    ap_done_reg <= ap_const_logic_0;
                elsif (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_loop_exit_ready_pp0_iter6_reg = ap_const_logic_1))) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter1_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
            else
                if ((ap_const_logic_1 = ap_condition_exit_pp0_iter1_stage0)) then 
                    ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
                elsif (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                    ap_enable_reg_pp0_iter1 <= ap_start_int;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter2_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter2 <= ap_const_logic_0;
            else
                if ((ap_const_logic_1 = ap_condition_exit_pp0_iter1_stage0)) then 
                    ap_enable_reg_pp0_iter2 <= ap_const_logic_0;
                elsif ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter3_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter3 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter4_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter4 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter4 <= ap_enable_reg_pp0_iter3;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter5_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter5 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter5 <= ap_enable_reg_pp0_iter4;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter6_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter6 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter6 <= ap_enable_reg_pp0_iter5;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter7_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter7 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter7 <= ap_enable_reg_pp0_iter6;
                end if; 
            end if;
        end if;
    end process;


    indvar_flatten_fu_82_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                if ((ap_loop_init = ap_const_logic_1)) then 
                    indvar_flatten_fu_82 <= ap_const_lv64_0;
                elsif (((icmp_ln22_fu_137_p2 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1))) then 
                    indvar_flatten_fu_82 <= add_ln22_fu_142_p2;
                end if;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_boolean_0 = ap_block_pp0_stage0_11001)) then
                B_V_reg_367 <= B_V_fu_153_p1;
                B_V_reg_367_pp0_iter3_reg <= B_V_reg_367;
                B_V_reg_367_pp0_iter4_reg <= B_V_reg_367_pp0_iter3_reg;
                ap_loop_exit_ready_pp0_iter3_reg <= ap_loop_exit_ready_pp0_iter2_reg;
                ap_loop_exit_ready_pp0_iter4_reg <= ap_loop_exit_ready_pp0_iter3_reg;
                ap_loop_exit_ready_pp0_iter5_reg <= ap_loop_exit_ready_pp0_iter4_reg;
                ap_loop_exit_ready_pp0_iter6_reg <= ap_loop_exit_ready_pp0_iter5_reg;
                icmp_ln1027_102_reg_425 <= icmp_ln1027_102_fu_277_p2;
                icmp_ln1027_reg_415 <= icmp_ln1027_fu_263_p2;
                icmp_ln1035_8_reg_420 <= icmp_ln1035_8_fu_272_p2;
                icmp_ln1035_reg_410 <= icmp_ln1035_fu_258_p2;
                trunc_ln1_reg_400 <= ret_V_4_fu_219_p2(15 downto 8);
                trunc_ln_reg_373 <= img_1_data164_dout(23 downto 16);
                trunc_ln_reg_373_pp0_iter3_reg <= trunc_ln_reg_373;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                ap_loop_exit_ready_pp0_iter2_reg <= ap_loop_exit_ready;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_CS_fsm)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_pp0_stage0 => 
                ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
            when others =>  
                ap_NS_fsm <= "X";
        end case;
    end process;
    B_V_fu_153_p1 <= img_1_data164_dout(8 - 1 downto 0);
    Cb_V_fu_234_p2 <= (trunc_ln1_reg_400 xor ap_const_lv8_80);
    Cr_V_fu_248_p2 <= (trunc_ln1669_1_fu_239_p4 xor ap_const_lv8_80);
    add_ln22_fu_142_p2 <= std_logic_vector(unsigned(indvar_flatten_fu_82) + unsigned(ap_const_lv64_1));
    and_ln40_1_fu_286_p2 <= (icmp_ln1035_8_reg_420 and icmp_ln1027_102_reg_425);
    and_ln40_2_fu_290_p2 <= (and_ln40_fu_282_p2 and and_ln40_1_fu_286_p2);
    and_ln40_fu_282_p2 <= (icmp_ln1035_reg_410 and icmp_ln1027_reg_415);
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(0);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage0_01001_assign_proc : process(ap_enable_reg_pp0_iter2, ap_enable_reg_pp0_iter7, img_1_data164_empty_n, img_2_data165_full_n)
    begin
                ap_block_pp0_stage0_01001 <= (((img_2_data165_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter7 = ap_const_logic_1)) or ((img_1_data164_empty_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1)));
    end process;


    ap_block_pp0_stage0_11001_assign_proc : process(ap_enable_reg_pp0_iter2, ap_enable_reg_pp0_iter7, img_1_data164_empty_n, img_2_data165_full_n)
    begin
                ap_block_pp0_stage0_11001 <= (((img_2_data165_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter7 = ap_const_logic_1)) or ((img_1_data164_empty_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1)));
    end process;


    ap_block_pp0_stage0_subdone_assign_proc : process(ap_enable_reg_pp0_iter2, ap_enable_reg_pp0_iter7, img_1_data164_empty_n, img_2_data165_full_n)
    begin
                ap_block_pp0_stage0_subdone <= (((img_2_data165_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter7 = ap_const_logic_1)) or ((img_1_data164_empty_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1)));
    end process;

        ap_block_state1_pp0_stage0_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state2_pp0_stage0_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_state3_pp0_stage0_iter2_assign_proc : process(img_1_data164_empty_n)
    begin
                ap_block_state3_pp0_stage0_iter2 <= (img_1_data164_empty_n = ap_const_logic_0);
    end process;

        ap_block_state4_pp0_stage0_iter3 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state5_pp0_stage0_iter4 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state6_pp0_stage0_iter5 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state7_pp0_stage0_iter6 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_state8_pp0_stage0_iter7_assign_proc : process(img_2_data165_full_n)
    begin
                ap_block_state8_pp0_stage0_iter7 <= (img_2_data165_full_n = ap_const_logic_0);
    end process;


    ap_condition_exit_pp0_iter1_stage0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0_subdone, icmp_ln22_fu_137_p2)
    begin
        if (((icmp_ln22_fu_137_p2 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_condition_exit_pp0_iter1_stage0 <= ap_const_logic_1;
        else 
            ap_condition_exit_pp0_iter1_stage0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_done_int_assign_proc : process(ap_block_pp0_stage0_subdone, ap_done_reg, ap_loop_exit_ready_pp0_iter6_reg)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_loop_exit_ready_pp0_iter6_reg = ap_const_logic_1))) then 
            ap_done_int <= ap_const_logic_1;
        else 
            ap_done_int <= ap_done_reg;
        end if; 
    end process;

    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);
    ap_enable_reg_pp0_iter0 <= ap_start_int;

    ap_idle_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_idle_pp0, ap_start_int)
    begin
        if (((ap_idle_pp0 = ap_const_logic_1) and (ap_start_int = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2, ap_enable_reg_pp0_iter3, ap_enable_reg_pp0_iter4, ap_enable_reg_pp0_iter5, ap_enable_reg_pp0_iter6, ap_enable_reg_pp0_iter7)
    begin
        if (((ap_enable_reg_pp0_iter7 = ap_const_logic_0) and (ap_enable_reg_pp0_iter6 = ap_const_logic_0) and (ap_enable_reg_pp0_iter5 = ap_const_logic_0) and (ap_enable_reg_pp0_iter4 = ap_const_logic_0) and (ap_enable_reg_pp0_iter3 = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;

    ap_loop_exit_ready <= ap_condition_exit_pp0_iter1_stage0;

    ap_ready_int_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0_subdone)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_ready_int <= ap_const_logic_1;
        else 
            ap_ready_int <= ap_const_logic_0;
        end if; 
    end process;


    grp_fu_305_ce_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            grp_fu_305_ce <= ap_const_logic_1;
        else 
            grp_fu_305_ce <= ap_const_logic_0;
        end if; 
    end process;

    grp_fu_305_p0 <= zext_ln1494_2_fu_177_p1(8 - 1 downto 0);
    grp_fu_305_p1 <= ap_const_lv15_55(7 - 1 downto 0);

    grp_fu_314_ce_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            grp_fu_314_ce <= ap_const_logic_1;
        else 
            grp_fu_314_ce <= ap_const_logic_0;
        end if; 
    end process;

    grp_fu_314_p0 <= zext_ln1494_2_fu_177_p1(8 - 1 downto 0);
    grp_fu_314_p1 <= ap_const_lv15_6B(7 - 1 downto 0);
    grp_fu_314_p2 <= grp_fu_314_p20(15 - 1 downto 0);
    grp_fu_314_p20 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(ret_V_13_fu_197_p3),16));

    grp_fu_322_ce_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            grp_fu_322_ce <= ap_const_logic_1;
        else 
            grp_fu_322_ce <= ap_const_logic_0;
        end if; 
    end process;

    grp_fu_322_p0 <= grp_fu_322_p00(8 - 1 downto 0);
    grp_fu_322_p00 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(B_V_reg_367),13));
    grp_fu_322_p1 <= ap_const_lv13_15(5 - 1 downto 0);
    icmp_ln1027_102_fu_277_p2 <= "1" when (signed(zext_ln1035_1_fu_268_p1) < signed(cr_upper_load)) else "0";
    icmp_ln1027_fu_263_p2 <= "1" when (signed(zext_ln1035_fu_254_p1) < signed(cb_upper_load)) else "0";
    icmp_ln1035_8_fu_272_p2 <= "1" when (signed(zext_ln1035_1_fu_268_p1) > signed(cr_lower_load)) else "0";
    icmp_ln1035_fu_258_p2 <= "1" when (signed(zext_ln1035_fu_254_p1) > signed(cb_lower_load)) else "0";
    icmp_ln22_fu_137_p2 <= "1" when (indvar_flatten_fu_82 = bound) else "0";

    img_1_data164_blk_n_assign_proc : process(ap_enable_reg_pp0_iter2, img_1_data164_empty_n, ap_block_pp0_stage0)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
            img_1_data164_blk_n <= img_1_data164_empty_n;
        else 
            img_1_data164_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    img_1_data164_read_assign_proc : process(ap_enable_reg_pp0_iter2, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
            img_1_data164_read <= ap_const_logic_1;
        else 
            img_1_data164_read <= ap_const_logic_0;
        end if; 
    end process;


    img_2_data165_blk_n_assign_proc : process(ap_enable_reg_pp0_iter7, img_2_data165_full_n, ap_block_pp0_stage0)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter7 = ap_const_logic_1))) then 
            img_2_data165_blk_n <= img_2_data165_full_n;
        else 
            img_2_data165_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    img_2_data165_din <= 
        ap_const_lv8_FF when (and_ln40_2_fu_290_p2(0) = '1') else 
        ap_const_lv8_0;

    img_2_data165_write_assign_proc : process(ap_enable_reg_pp0_iter7, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter7 = ap_const_logic_1))) then 
            img_2_data165_write <= ap_const_logic_1;
        else 
            img_2_data165_write <= ap_const_logic_0;
        end if; 
    end process;

    ret_V_10_fu_187_p0 <= ret_V_10_fu_187_p00(8 - 1 downto 0);
    ret_V_10_fu_187_p00 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(trunc_ln_reg_373_pp0_iter3_reg),15));
    ret_V_10_fu_187_p1 <= ap_const_lv15_7FD5(7 - 1 downto 0);
    ret_V_12_fu_208_p3 <= (B_V_reg_367_pp0_iter4_reg & ap_const_lv7_0);
    ret_V_13_fu_197_p3 <= (trunc_ln_reg_373_pp0_iter3_reg & ap_const_lv7_0);
    ret_V_4_fu_219_p2 <= std_logic_vector(signed(grp_fu_305_p3) + signed(zext_ln1495_fu_215_p1));
    tmp_fu_167_p4 <= img_1_data164_dout(15 downto 8);
    trunc_ln1669_1_fu_239_p4 <= grp_fu_322_p3(15 downto 8);
    zext_ln1035_1_fu_268_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(Cr_V_fu_248_p2),32));
    zext_ln1035_fu_254_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(Cb_V_fu_234_p2),32));
    zext_ln1494_2_fu_177_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(tmp_fu_167_p4),15));
    zext_ln1495_fu_215_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(ret_V_12_fu_208_p3),16));
end behav;
