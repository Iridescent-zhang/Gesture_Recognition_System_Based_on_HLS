// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Version: 2022.2
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1 ns / 1 ps
module test_Hu_xFResizeAreaDownScale_600_1024_1_0_1_2_2_1_300_512_1024_512_s_ouput_buffer_V_eOg (
     
    address0, ce0,
    d0, we0, 
    
      
    address1, ce1,
    
    q1, 
     
    reset, clk);

parameter DataWidth = 16;
parameter AddressWidth = 9;
parameter AddressRange = 512;
 
input[AddressWidth-1:0] address0;
input ce0;
input[DataWidth-1:0] d0;
input we0; 

 
input[AddressWidth-1:0] address1;
input ce1;

output reg[DataWidth-1:0] q1; 

input reset;
input clk;

(* ram_style = "auto"  *)reg [DataWidth-1:0] ram[0:AddressRange-1];


 

always @(posedge clk)  
begin 
    if (ce0) begin
        if (we0) 
            ram[address0] <= d0; 
    end
end 



 
  



always @(posedge clk) 
begin 
    if (ce1) begin
        q1 <= ram[address1];
    end
end 

 
 

endmodule

