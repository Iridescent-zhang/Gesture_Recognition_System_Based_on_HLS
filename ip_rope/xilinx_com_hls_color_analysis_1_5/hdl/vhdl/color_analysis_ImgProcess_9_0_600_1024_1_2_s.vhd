-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity color_analysis_ImgProcess_9_0_600_1024_1_2_s is
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
    cb_lower_dout : IN STD_LOGIC_VECTOR (31 downto 0);
    cb_lower_num_data_valid : IN STD_LOGIC_VECTOR (3 downto 0);
    cb_lower_fifo_cap : IN STD_LOGIC_VECTOR (3 downto 0);
    cb_lower_empty_n : IN STD_LOGIC;
    cb_lower_read : OUT STD_LOGIC;
    cb_upper_dout : IN STD_LOGIC_VECTOR (31 downto 0);
    cb_upper_num_data_valid : IN STD_LOGIC_VECTOR (3 downto 0);
    cb_upper_fifo_cap : IN STD_LOGIC_VECTOR (3 downto 0);
    cb_upper_empty_n : IN STD_LOGIC;
    cb_upper_read : OUT STD_LOGIC;
    cr_lower_dout : IN STD_LOGIC_VECTOR (31 downto 0);
    cr_lower_num_data_valid : IN STD_LOGIC_VECTOR (3 downto 0);
    cr_lower_fifo_cap : IN STD_LOGIC_VECTOR (3 downto 0);
    cr_lower_empty_n : IN STD_LOGIC;
    cr_lower_read : OUT STD_LOGIC;
    cr_upper_dout : IN STD_LOGIC_VECTOR (31 downto 0);
    cr_upper_num_data_valid : IN STD_LOGIC_VECTOR (3 downto 0);
    cr_upper_fifo_cap : IN STD_LOGIC_VECTOR (3 downto 0);
    cr_upper_empty_n : IN STD_LOGIC;
    cr_upper_read : OUT STD_LOGIC );
end;


architecture behav of color_analysis_ImgProcess_9_0_600_1024_1_2_s is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (4 downto 0) := "00001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (4 downto 0) := "00010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (4 downto 0) := "00100";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (4 downto 0) := "01000";
    constant ap_ST_fsm_state5 : STD_LOGIC_VECTOR (4 downto 0) := "10000";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv32_4 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000100";
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";

attribute shreg_extract : string;
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (4 downto 0) := "00001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal cb_lower_blk_n : STD_LOGIC;
    signal ap_CS_fsm_state3 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state3 : signal is "none";
    signal cb_upper_blk_n : STD_LOGIC;
    signal cr_lower_blk_n : STD_LOGIC;
    signal cr_upper_blk_n : STD_LOGIC;
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal cr_upper_read_reg_125 : STD_LOGIC_VECTOR (31 downto 0);
    signal cr_lower_read_reg_130 : STD_LOGIC_VECTOR (31 downto 0);
    signal cb_upper_read_reg_135 : STD_LOGIC_VECTOR (31 downto 0);
    signal cb_lower_read_reg_140 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_99_p2 : STD_LOGIC_VECTOR (63 downto 0);
    signal bound_reg_145 : STD_LOGIC_VECTOR (63 downto 0);
    signal grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_start : STD_LOGIC;
    signal grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_done : STD_LOGIC;
    signal grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_idle : STD_LOGIC;
    signal grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_ready : STD_LOGIC;
    signal grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_img_1_data164_read : STD_LOGIC;
    signal grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_img_2_data165_din : STD_LOGIC_VECTOR (7 downto 0);
    signal grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_img_2_data165_write : STD_LOGIC;
    signal grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_start_reg : STD_LOGIC := '0';
    signal ap_NS_fsm : STD_LOGIC_VECTOR (4 downto 0);
    signal ap_NS_fsm_state4 : STD_LOGIC;
    signal ap_CS_fsm_state5 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state5 : signal is "none";
    signal ap_block_state1 : BOOLEAN;
    signal ap_block_state3 : BOOLEAN;
    signal grp_fu_99_p0 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_99_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_fu_99_ce : STD_LOGIC;
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_ST_fsm_state2_blk : STD_LOGIC;
    signal ap_ST_fsm_state3_blk : STD_LOGIC;
    signal ap_ST_fsm_state4_blk : STD_LOGIC;
    signal ap_ST_fsm_state5_blk : STD_LOGIC;
    signal grp_fu_99_p00 : STD_LOGIC_VECTOR (63 downto 0);
    signal grp_fu_99_p10 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_ce_reg : STD_LOGIC;

    component color_analysis_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols IS
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
    end component;


    component color_analysis_mul_32ns_32ns_64_2_1 IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (31 downto 0);
        din1 : IN STD_LOGIC_VECTOR (31 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (63 downto 0) );
    end component;



begin
    grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80 : component color_analysis_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_start,
        ap_done => grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_done,
        ap_idle => grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_idle,
        ap_ready => grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_ready,
        img_1_data164_dout => img_1_data164_dout,
        img_1_data164_num_data_valid => ap_const_lv2_0,
        img_1_data164_fifo_cap => ap_const_lv2_0,
        img_1_data164_empty_n => img_1_data164_empty_n,
        img_1_data164_read => grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_img_1_data164_read,
        img_2_data165_din => grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_img_2_data165_din,
        img_2_data165_num_data_valid => ap_const_lv2_0,
        img_2_data165_fifo_cap => ap_const_lv2_0,
        img_2_data165_full_n => img_2_data165_full_n,
        img_2_data165_write => grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_img_2_data165_write,
        bound => bound_reg_145,
        cb_lower_load => cb_lower_read_reg_140,
        cb_upper_load => cb_upper_read_reg_135,
        cr_lower_load => cr_lower_read_reg_130,
        cr_upper_load => cr_upper_read_reg_125);

    mul_32ns_32ns_64_2_1_U138 : component color_analysis_mul_32ns_32ns_64_2_1
    generic map (
        ID => 1,
        NUM_STAGE => 2,
        din0_WIDTH => 32,
        din1_WIDTH => 32,
        dout_WIDTH => 64)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => grp_fu_99_p0,
        din1 => grp_fu_99_p1,
        ce => grp_fu_99_ce,
        dout => grp_fu_99_p2);





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
                elsif (((ap_const_logic_1 = ap_CS_fsm_state5) and (grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_done = ap_const_logic_1))) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_start_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_start_reg <= ap_const_logic_0;
            else
                if (((ap_const_logic_1 = ap_CS_fsm_state3) and (ap_const_logic_1 = ap_NS_fsm_state4))) then 
                    grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_start_reg <= ap_const_logic_1;
                elsif ((grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_ready = ap_const_logic_1)) then 
                    grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_start_reg <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;

    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state3)) then
                bound_reg_145 <= grp_fu_99_p2;
                cb_lower_read_reg_140 <= cb_lower_dout;
                cb_upper_read_reg_135 <= cb_upper_dout;
                cr_lower_read_reg_130 <= cr_lower_dout;
                cr_upper_read_reg_125 <= cr_upper_dout;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_start, ap_done_reg, ap_CS_fsm, ap_CS_fsm_state1, cb_lower_empty_n, cb_upper_empty_n, cr_lower_empty_n, cr_upper_empty_n, ap_CS_fsm_state3, grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_done, ap_CS_fsm_state5)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if ((not(((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                ap_NS_fsm <= ap_ST_fsm_state3;
            when ap_ST_fsm_state3 => 
                if ((not(((cr_upper_empty_n = ap_const_logic_0) or (cr_lower_empty_n = ap_const_logic_0) or (cb_upper_empty_n = ap_const_logic_0) or (cb_lower_empty_n = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state3))) then
                    ap_NS_fsm <= ap_ST_fsm_state4;
                else
                    ap_NS_fsm <= ap_ST_fsm_state3;
                end if;
            when ap_ST_fsm_state4 => 
                ap_NS_fsm <= ap_ST_fsm_state5;
            when ap_ST_fsm_state5 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state5) and (grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_done = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state1;
                else
                    ap_NS_fsm <= ap_ST_fsm_state5;
                end if;
            when others =>  
                ap_NS_fsm <= "XXXXX";
        end case;
    end process;
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state3 <= ap_CS_fsm(2);
    ap_CS_fsm_state5 <= ap_CS_fsm(4);
    ap_NS_fsm_state4 <= ap_NS_fsm(3);

    ap_ST_fsm_state1_blk_assign_proc : process(ap_start, ap_done_reg)
    begin
        if (((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) then 
            ap_ST_fsm_state1_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state1_blk <= ap_const_logic_0;
        end if; 
    end process;

    ap_ST_fsm_state2_blk <= ap_const_logic_0;

    ap_ST_fsm_state3_blk_assign_proc : process(cb_lower_empty_n, cb_upper_empty_n, cr_lower_empty_n, cr_upper_empty_n)
    begin
        if (((cr_upper_empty_n = ap_const_logic_0) or (cr_lower_empty_n = ap_const_logic_0) or (cb_upper_empty_n = ap_const_logic_0) or (cb_lower_empty_n = ap_const_logic_0))) then 
            ap_ST_fsm_state3_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state3_blk <= ap_const_logic_0;
        end if; 
    end process;

    ap_ST_fsm_state4_blk <= ap_const_logic_0;

    ap_ST_fsm_state5_blk_assign_proc : process(grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_done)
    begin
        if ((grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_done = ap_const_logic_0)) then 
            ap_ST_fsm_state5_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state5_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_block_state1_assign_proc : process(ap_start, ap_done_reg)
    begin
                ap_block_state1 <= ((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0));
    end process;


    ap_block_state3_assign_proc : process(cb_lower_empty_n, cb_upper_empty_n, cr_lower_empty_n, cr_upper_empty_n)
    begin
                ap_block_state3 <= ((cr_upper_empty_n = ap_const_logic_0) or (cr_lower_empty_n = ap_const_logic_0) or (cb_upper_empty_n = ap_const_logic_0) or (cb_lower_empty_n = ap_const_logic_0));
    end process;


    ap_done_assign_proc : process(ap_done_reg, grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_done, ap_CS_fsm_state5)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state5) and (grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_done = ap_const_logic_1))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_done_reg;
        end if; 
    end process;


    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_0))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_done, ap_CS_fsm_state5)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state5) and (grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_done = ap_const_logic_1))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    cb_lower_blk_n_assign_proc : process(cb_lower_empty_n, ap_CS_fsm_state3)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
            cb_lower_blk_n <= cb_lower_empty_n;
        else 
            cb_lower_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    cb_lower_read_assign_proc : process(cb_lower_empty_n, cb_upper_empty_n, cr_lower_empty_n, cr_upper_empty_n, ap_CS_fsm_state3)
    begin
        if ((not(((cr_upper_empty_n = ap_const_logic_0) or (cr_lower_empty_n = ap_const_logic_0) or (cb_upper_empty_n = ap_const_logic_0) or (cb_lower_empty_n = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state3))) then 
            cb_lower_read <= ap_const_logic_1;
        else 
            cb_lower_read <= ap_const_logic_0;
        end if; 
    end process;


    cb_upper_blk_n_assign_proc : process(cb_upper_empty_n, ap_CS_fsm_state3)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
            cb_upper_blk_n <= cb_upper_empty_n;
        else 
            cb_upper_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    cb_upper_read_assign_proc : process(cb_lower_empty_n, cb_upper_empty_n, cr_lower_empty_n, cr_upper_empty_n, ap_CS_fsm_state3)
    begin
        if ((not(((cr_upper_empty_n = ap_const_logic_0) or (cr_lower_empty_n = ap_const_logic_0) or (cb_upper_empty_n = ap_const_logic_0) or (cb_lower_empty_n = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state3))) then 
            cb_upper_read <= ap_const_logic_1;
        else 
            cb_upper_read <= ap_const_logic_0;
        end if; 
    end process;


    cr_lower_blk_n_assign_proc : process(cr_lower_empty_n, ap_CS_fsm_state3)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
            cr_lower_blk_n <= cr_lower_empty_n;
        else 
            cr_lower_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    cr_lower_read_assign_proc : process(cb_lower_empty_n, cb_upper_empty_n, cr_lower_empty_n, cr_upper_empty_n, ap_CS_fsm_state3)
    begin
        if ((not(((cr_upper_empty_n = ap_const_logic_0) or (cr_lower_empty_n = ap_const_logic_0) or (cb_upper_empty_n = ap_const_logic_0) or (cb_lower_empty_n = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state3))) then 
            cr_lower_read <= ap_const_logic_1;
        else 
            cr_lower_read <= ap_const_logic_0;
        end if; 
    end process;


    cr_upper_blk_n_assign_proc : process(cr_upper_empty_n, ap_CS_fsm_state3)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
            cr_upper_blk_n <= cr_upper_empty_n;
        else 
            cr_upper_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    cr_upper_read_assign_proc : process(cb_lower_empty_n, cb_upper_empty_n, cr_lower_empty_n, cr_upper_empty_n, ap_CS_fsm_state3)
    begin
        if ((not(((cr_upper_empty_n = ap_const_logic_0) or (cr_lower_empty_n = ap_const_logic_0) or (cb_upper_empty_n = ap_const_logic_0) or (cb_lower_empty_n = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state3))) then 
            cr_upper_read <= ap_const_logic_1;
        else 
            cr_upper_read <= ap_const_logic_0;
        end if; 
    end process;

    grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_start <= grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_ap_start_reg;

    grp_fu_99_ce_assign_proc : process(cb_lower_empty_n, cb_upper_empty_n, cr_lower_empty_n, cr_upper_empty_n, ap_CS_fsm_state3, ap_CS_fsm_state2)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state2) or (not(((cr_upper_empty_n = ap_const_logic_0) or (cr_lower_empty_n = ap_const_logic_0) or (cb_upper_empty_n = ap_const_logic_0) or (cb_lower_empty_n = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state3)))) then 
            grp_fu_99_ce <= ap_const_logic_1;
        else 
            grp_fu_99_ce <= ap_const_logic_0;
        end if; 
    end process;

    grp_fu_99_p0 <= grp_fu_99_p00(32 - 1 downto 0);
    grp_fu_99_p00 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(p_read),64));
    grp_fu_99_p1 <= grp_fu_99_p10(32 - 1 downto 0);
    grp_fu_99_p10 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(p_read1),64));

    img_1_data164_read_assign_proc : process(grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_img_1_data164_read, ap_CS_fsm_state5)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state5)) then 
            img_1_data164_read <= grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_img_1_data164_read;
        else 
            img_1_data164_read <= ap_const_logic_0;
        end if; 
    end process;

    img_2_data165_din <= grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_img_2_data165_din;

    img_2_data165_write_assign_proc : process(grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_img_2_data165_write, ap_CS_fsm_state5)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state5)) then 
            img_2_data165_write <= grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80_img_2_data165_write;
        else 
            img_2_data165_write <= ap_const_logic_0;
        end if; 
    end process;

end behav;
