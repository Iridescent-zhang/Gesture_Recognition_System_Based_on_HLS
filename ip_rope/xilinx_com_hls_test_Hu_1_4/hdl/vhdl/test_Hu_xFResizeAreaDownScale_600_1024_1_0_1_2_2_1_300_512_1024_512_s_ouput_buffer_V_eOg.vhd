-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity test_Hu_xFResizeAreaDownScale_600_1024_1_0_1_2_2_1_300_512_1024_512_s_ouput_buffer_V_eOg is 
    generic(
        MEM_TYPE        : string    := "auto"; 
        DataWidth       : integer   := 16; 
        AddressWidth    : integer   := 9;
        AddressRange    : integer   := 512
    ); 
    port (
        address0    : in std_logic_vector(AddressWidth-1 downto 0); 
        ce0         : in std_logic; 
        d0          : in std_logic_vector(DataWidth-1 downto 0); 
        we0         : in std_logic; 
        address1    : in std_logic_vector(AddressWidth-1 downto 0); 
        ce1         : in std_logic; 
        q1          : out std_logic_vector(DataWidth-1 downto 0);
        reset           : in std_logic; 
        clk             : in std_logic 
    ); 
end entity; 

architecture rtl of test_Hu_xFResizeAreaDownScale_600_1024_1_0_1_2_2_1_300_512_1024_512_s_ouput_buffer_V_eOg is 

signal address1_tmp : std_logic_vector(AddressWidth-1 downto 0);


type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 
-- Init 
signal ram : mem_array;
attribute syn_ramstyle : string;
attribute syn_ramstyle of ram : signal is "auto";
attribute ram_style : string;
attribute ram_style of ram : signal is MEM_TYPE;

begin 




p_memory_access_0: process (clk)  
begin 
    if (clk'event and clk = '1') then
        if (ce0 = '1') then 
            if (we0 = '1') then 
                ram(CONV_INTEGER(address0)) <= d0; 
            end if;
        end if;
    end if;
end process;      




 
memory_access_guard_1: process (address1) 
begin
    address1_tmp <= address1;
--synthesis translate_off
    if (CONV_INTEGER(address1) > AddressRange-1) then
        address1_tmp <= (others => '0');
    else 
       address1_tmp <= address1;
    end if;
--synthesis translate_on
end process;   -- 



p_memory_access_1: process (clk)
begin 
    if (clk'event and clk = '1') then
        if (ce1 = '1') then 
            q1 <= ram(CONV_INTEGER(address1_tmp));
        end if;
    end if;
end process;



 

end rtl;
