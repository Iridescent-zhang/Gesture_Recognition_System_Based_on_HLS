// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Version: 2022.2
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
module test_Hu_xFSobelFilter3x3_0_0_600_1024_1_0_0_1_2_2_2_1_1_1024_false_s_buf_V_RAM_S2P_BRbkb (
     
    address0, ce0,
    
    q0, 
      
    address1, ce1,
    d1, we1, 
    
     
    reset, clk);

parameter DataWidth = 8;
parameter AddressWidth = 10;
parameter AddressRange = 1024;
 
input[AddressWidth-1:0] address0;
input ce0;

output reg[DataWidth-1:0] q0; 
 
input[AddressWidth-1:0] address1;
input ce1;
input[DataWidth-1:0] d1;
input we1; 


input reset;
input clk;

(* ram_style = "block"  *)reg [DataWidth-1:0] ram[0:AddressRange-1];


 



always @(posedge clk) 
begin 
    if (ce0) begin
        q0 <= ram[address0];
    end
end 

 
  

always @(posedge clk)  
begin 
    if (ce1) begin
        if (we1) 
            ram[address1] <= d1; 
    end
end 



 
 

endmodule

