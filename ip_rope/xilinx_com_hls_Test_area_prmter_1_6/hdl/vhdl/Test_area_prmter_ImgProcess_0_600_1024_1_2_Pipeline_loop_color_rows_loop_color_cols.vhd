-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Test_area_prmter_ImgProcess_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    img_1_data15_dout : IN STD_LOGIC_VECTOR (7 downto 0);
    img_1_data15_num_data_valid : IN STD_LOGIC_VECTOR (1 downto 0);
    img_1_data15_fifo_cap : IN STD_LOGIC_VECTOR (1 downto 0);
    img_1_data15_empty_n : IN STD_LOGIC;
    img_1_data15_read : OUT STD_LOGIC;
    row_mark_address0 : OUT STD_LOGIC_VECTOR (9 downto 0);
    row_mark_ce0 : OUT STD_LOGIC;
    row_mark_we0 : OUT STD_LOGIC;
    row_mark_d0 : OUT STD_LOGIC_VECTOR (0 downto 0);
    col_mark_address0 : OUT STD_LOGIC_VECTOR (9 downto 0);
    col_mark_ce0 : OUT STD_LOGIC;
    col_mark_we0 : OUT STD_LOGIC;
    col_mark_d0 : OUT STD_LOGIC_VECTOR (0 downto 0);
    area_out : OUT STD_LOGIC_VECTOR (31 downto 0);
    area_out_ap_vld : OUT STD_LOGIC );
end;


architecture behav of Test_area_prmter_ImgProcess_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv11_0 : STD_LOGIC_VECTOR (10 downto 0) := "00000000000";
    constant ap_const_lv10_0 : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
    constant ap_const_lv20_0 : STD_LOGIC_VECTOR (19 downto 0) := "00000000000000000000";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv20_96000 : STD_LOGIC_VECTOR (19 downto 0) := "10010110000000000000";
    constant ap_const_lv20_1 : STD_LOGIC_VECTOR (19 downto 0) := "00000000000000000001";
    constant ap_const_lv8_FF : STD_LOGIC_VECTOR (7 downto 0) := "11111111";
    constant ap_const_lv11_400 : STD_LOGIC_VECTOR (10 downto 0) := "10000000000";
    constant ap_const_lv10_1 : STD_LOGIC_VECTOR (9 downto 0) := "0000000001";
    constant ap_const_lv11_1 : STD_LOGIC_VECTOR (10 downto 0) := "00000000001";

attribute shreg_extract : string;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (0 downto 0) := "1";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC;
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_enable_reg_pp0_iter2 : STD_LOGIC := '0';
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state2_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_state3_pp0_stage0_iter2 : BOOLEAN;
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal icmp_ln40_fu_138_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_condition_exit_pp0_iter0_stage0 : STD_LOGIC;
    signal ap_loop_exit_ready : STD_LOGIC;
    signal ap_ready_int : STD_LOGIC;
    signal img_1_data15_blk_n : STD_LOGIC;
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal icmp_ln40_reg_268 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln1019_fu_155_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln1019_reg_272 : STD_LOGIC_VECTOR (0 downto 0);
    signal zext_ln40_fu_195_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal zext_ln43_fu_200_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal j_fu_58 : STD_LOGIC_VECTOR (10 downto 0);
    signal add_ln43_fu_219_p2 : STD_LOGIC_VECTOR (10 downto 0);
    signal ap_loop_init : STD_LOGIC;
    signal i_fu_62 : STD_LOGIC_VECTOR (9 downto 0);
    signal select_ln40_1_fu_187_p3 : STD_LOGIC_VECTOR (9 downto 0);
    signal indvar_flatten_fu_66 : STD_LOGIC_VECTOR (19 downto 0);
    signal add_ln40_fu_144_p2 : STD_LOGIC_VECTOR (19 downto 0);
    signal ap_sig_allocacmp_indvar_flatten_load : STD_LOGIC_VECTOR (19 downto 0);
    signal area_fu_70 : STD_LOGIC_VECTOR (31 downto 0);
    signal area_1_fu_208_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal icmp_ln43_fu_167_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal add_ln40_1_fu_181_p2 : STD_LOGIC_VECTOR (9 downto 0);
    signal select_ln40_fu_173_p3 : STD_LOGIC_VECTOR (10 downto 0);
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_continue_int : STD_LOGIC;
    signal ap_done_int : STD_LOGIC;
    signal ap_loop_exit_ready_pp0_iter1_reg : STD_LOGIC;
    signal ap_NS_fsm : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_enable_pp0 : STD_LOGIC;
    signal ap_start_int : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component Test_area_prmter_flow_control_loop_pipe_sequential_init IS
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
    flow_control_loop_pipe_sequential_init_U : component Test_area_prmter_flow_control_loop_pipe_sequential_init
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => ap_start,
        ap_ready => ap_ready,
        ap_done => ap_done,
        ap_start_int => ap_start_int,
        ap_loop_init => ap_loop_init,
        ap_ready_int => ap_ready_int,
        ap_loop_exit_ready => ap_condition_exit_pp0_iter0_stage0,
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
                elsif (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_loop_exit_ready_pp0_iter1_reg = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
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
                if ((ap_const_logic_1 = ap_condition_exit_pp0_iter0_stage0)) then 
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
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
                end if; 
            end if;
        end if;
    end process;


    area_fu_70_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_boolean_0 = ap_block_pp0_stage0_11001)) then
                if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_loop_init = ap_const_logic_1))) then 
                    area_fu_70 <= ap_const_lv32_0;
                elsif (((icmp_ln1019_reg_272 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
                    area_fu_70 <= area_1_fu_208_p2;
                end if;
            end if; 
        end if;
    end process;

    i_fu_62_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_boolean_0 = ap_block_pp0_stage0_11001)) then
                if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_loop_init = ap_const_logic_1))) then 
                    i_fu_62 <= ap_const_lv10_0;
                elsif ((ap_enable_reg_pp0_iter2 = ap_const_logic_1)) then 
                    i_fu_62 <= select_ln40_1_fu_187_p3;
                end if;
            end if; 
        end if;
    end process;

    indvar_flatten_fu_66_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                if (((icmp_ln40_fu_138_p2 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1))) then 
                    indvar_flatten_fu_66 <= add_ln40_fu_144_p2;
                elsif ((ap_loop_init = ap_const_logic_1)) then 
                    indvar_flatten_fu_66 <= ap_const_lv20_0;
                end if;
            end if; 
        end if;
    end process;

    j_fu_58_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_boolean_0 = ap_block_pp0_stage0_11001)) then
                if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_loop_init = ap_const_logic_1))) then 
                    j_fu_58 <= ap_const_lv11_0;
                elsif ((ap_enable_reg_pp0_iter2 = ap_const_logic_1)) then 
                    j_fu_58 <= add_ln43_fu_219_p2;
                end if;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                ap_loop_exit_ready_pp0_iter1_reg <= ap_loop_exit_ready;
                icmp_ln1019_reg_272 <= icmp_ln1019_fu_155_p2;
                icmp_ln40_reg_268 <= icmp_ln40_fu_138_p2;
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
    add_ln40_1_fu_181_p2 <= std_logic_vector(unsigned(i_fu_62) + unsigned(ap_const_lv10_1));
    add_ln40_fu_144_p2 <= std_logic_vector(unsigned(ap_sig_allocacmp_indvar_flatten_load) + unsigned(ap_const_lv20_1));
    add_ln43_fu_219_p2 <= std_logic_vector(unsigned(select_ln40_fu_173_p3) + unsigned(ap_const_lv11_1));
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(0);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage0_01001_assign_proc : process(ap_enable_reg_pp0_iter1, img_1_data15_empty_n)
    begin
                ap_block_pp0_stage0_01001 <= ((img_1_data15_empty_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1));
    end process;


    ap_block_pp0_stage0_11001_assign_proc : process(ap_enable_reg_pp0_iter1, img_1_data15_empty_n)
    begin
                ap_block_pp0_stage0_11001 <= ((img_1_data15_empty_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1));
    end process;


    ap_block_pp0_stage0_subdone_assign_proc : process(ap_enable_reg_pp0_iter1, img_1_data15_empty_n)
    begin
                ap_block_pp0_stage0_subdone <= ((img_1_data15_empty_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1));
    end process;

        ap_block_state1_pp0_stage0_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_state2_pp0_stage0_iter1_assign_proc : process(img_1_data15_empty_n)
    begin
                ap_block_state2_pp0_stage0_iter1 <= (img_1_data15_empty_n = ap_const_logic_0);
    end process;

        ap_block_state3_pp0_stage0_iter2 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_condition_exit_pp0_iter0_stage0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0_subdone, icmp_ln40_fu_138_p2)
    begin
        if (((icmp_ln40_fu_138_p2 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_condition_exit_pp0_iter0_stage0 <= ap_const_logic_1;
        else 
            ap_condition_exit_pp0_iter0_stage0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_done_int_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_subdone, ap_done_reg, ap_loop_exit_ready_pp0_iter1_reg)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_loop_exit_ready_pp0_iter1_reg = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
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


    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter2)
    begin
        if (((ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;

    ap_loop_exit_ready <= ap_condition_exit_pp0_iter0_stage0;

    ap_ready_int_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0_subdone)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_ready_int <= ap_const_logic_1;
        else 
            ap_ready_int <= ap_const_logic_0;
        end if; 
    end process;


    ap_sig_allocacmp_indvar_flatten_load_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0, ap_loop_init, indvar_flatten_fu_66)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_loop_init = ap_const_logic_1))) then 
            ap_sig_allocacmp_indvar_flatten_load <= ap_const_lv20_0;
        else 
            ap_sig_allocacmp_indvar_flatten_load <= indvar_flatten_fu_66;
        end if; 
    end process;

    area_1_fu_208_p2 <= std_logic_vector(unsigned(area_fu_70) + unsigned(ap_const_lv32_1));
    area_out <= area_fu_70;

    area_out_ap_vld_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001, icmp_ln40_reg_268)
    begin
        if (((icmp_ln40_reg_268 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            area_out_ap_vld <= ap_const_logic_1;
        else 
            area_out_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    col_mark_address0 <= zext_ln43_fu_200_p1(10 - 1 downto 0);

    col_mark_ce0_assign_proc : process(ap_enable_reg_pp0_iter2, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
            col_mark_ce0 <= ap_const_logic_1;
        else 
            col_mark_ce0 <= ap_const_logic_0;
        end if; 
    end process;

    col_mark_d0 <= ap_const_lv1_1;

    col_mark_we0_assign_proc : process(ap_enable_reg_pp0_iter2, ap_block_pp0_stage0_11001, icmp_ln1019_reg_272)
    begin
        if (((icmp_ln1019_reg_272 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
            col_mark_we0 <= ap_const_logic_1;
        else 
            col_mark_we0 <= ap_const_logic_0;
        end if; 
    end process;

    icmp_ln1019_fu_155_p2 <= "1" when (img_1_data15_dout = ap_const_lv8_FF) else "0";
    icmp_ln40_fu_138_p2 <= "1" when (ap_sig_allocacmp_indvar_flatten_load = ap_const_lv20_96000) else "0";
    icmp_ln43_fu_167_p2 <= "1" when (j_fu_58 = ap_const_lv11_400) else "0";

    img_1_data15_blk_n_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, img_1_data15_empty_n, ap_block_pp0_stage0)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            img_1_data15_blk_n <= img_1_data15_empty_n;
        else 
            img_1_data15_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    img_1_data15_read_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            img_1_data15_read <= ap_const_logic_1;
        else 
            img_1_data15_read <= ap_const_logic_0;
        end if; 
    end process;

    row_mark_address0 <= zext_ln40_fu_195_p1(10 - 1 downto 0);

    row_mark_ce0_assign_proc : process(ap_enable_reg_pp0_iter2, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
            row_mark_ce0 <= ap_const_logic_1;
        else 
            row_mark_ce0 <= ap_const_logic_0;
        end if; 
    end process;

    row_mark_d0 <= ap_const_lv1_1;

    row_mark_we0_assign_proc : process(ap_enable_reg_pp0_iter2, ap_block_pp0_stage0_11001, icmp_ln1019_reg_272)
    begin
        if (((icmp_ln1019_reg_272 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then 
            row_mark_we0 <= ap_const_logic_1;
        else 
            row_mark_we0 <= ap_const_logic_0;
        end if; 
    end process;

    select_ln40_1_fu_187_p3 <= 
        add_ln40_1_fu_181_p2 when (icmp_ln43_fu_167_p2(0) = '1') else 
        i_fu_62;
    select_ln40_fu_173_p3 <= 
        ap_const_lv11_0 when (icmp_ln43_fu_167_p2(0) = '1') else 
        j_fu_58;
    zext_ln40_fu_195_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(select_ln40_1_fu_187_p3),64));
    zext_ln43_fu_200_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(select_ln40_fu_173_p3),64));
end behav;
