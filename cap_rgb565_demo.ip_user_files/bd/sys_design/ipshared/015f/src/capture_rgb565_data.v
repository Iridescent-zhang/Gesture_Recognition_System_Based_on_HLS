`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/22 13:49:46
// Design Name: 
// Module Name: capture_rgb565_data
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module capture_rgb565_data
#(
	parameter	integer		CMOS_FRAME_WAITCNT	=	10,		//Wait n fps for steady(OmniVision need 10 Frame)
	parameter	integer		CLOCK_CMOS          =	24000000	
)
(
	//global clock
	input				clk_cmos,			//24MHz CMOS Driver clock input
	input				rst_n,				//global reset

	//CMOS Sensor Interface
	input				cmos_pclk,			//24MHz CMOS Pixel clock input
	output				cmos_xclk,			//24MHz drive clock
	input				cmos_vsync,			//H : Data Valid; L : Frame Sync(Set it by register)
	input				cmos_href,			//H : Data vaild, L : Line Sync
	output              cmos_rst_n,  		//cmos 复位信号，低电平有效
    output              cmos_pwdn,
	input		[7:0]	cmos_data,			//8 bits cmos data input
	
	//CMOS SYNC Data output
	output				cmos_frame_vsync,	//cmos frame data vsync valid signal
	output				cmos_frame_href,	//cmos frame data href vaild  signal
	output		[23:0]	cmos_frame_data,	//cmos frame RGB output: {{R[4:0],G[5:3]}, {G2:0}, B[4:0]}	

	output				cmos_frame_clk,
	output				cmos_frame_clken,	//cmos frame data output/capture enable clock, 12MHz
	
	//user interface
	output		[7:0]	cmos_fps_rate		//cmos frame output rate
);


assign	cmos_xclk = clk_cmos;	//24MHz CMOS XCLK output
assign  cmos_rst_n = 1'b1;
assign  cmos_pwdn = 1'b0;
//-----------------------------------------------------
//Sensor HS & VS Vaild Capture
/**************************************************					       
         _________________________________
VS______|                                 |________
	            _______	 	     _______
HS_____________|       |__...___|       |____________
**************************************************/
//-------------------------------------------------------------
//sync the frame vsync and href signal and generate frame begin & end signal
reg	[1:0]	cmos_vsync_r, cmos_href_r;
always@(posedge cmos_pclk or negedge rst_n)
begin
	if(!rst_n)
		begin
		cmos_vsync_r <= 0;
		cmos_href_r <= 0;
		end
	else
		begin
		cmos_vsync_r <= {cmos_vsync_r[0], cmos_vsync};
		cmos_href_r <= {cmos_href_r[0], cmos_href};
		end
end
//wire	cmos_vsync_begin 	= 	(~cmos_vsync_r[1] & cmos_vsync_r[0]) ? 1'b1 : 1'b0;	
wire	cmos_vsync_end 		= 	(cmos_vsync_r[1] & ~cmos_vsync_r[0]) ? 1'b1 : 1'b0;	//下降沿

//----------------------------------------------------------------------------------
//Wait for Sensor output Data valid 10 Frame of OmniVision
reg	[3:0]	cmos_fps_cnt;
always@(posedge cmos_pclk or negedge rst_n)
begin
	if(!rst_n)
		cmos_fps_cnt <= 0;
	else	//Wait until cmos init complete
		begin
		if(cmos_fps_cnt < CMOS_FRAME_WAITCNT)	
			cmos_fps_cnt <= cmos_vsync_end ? cmos_fps_cnt + 1'b1 : cmos_fps_cnt;
		else
			cmos_fps_cnt <= CMOS_FRAME_WAITCNT;
		end
end

//----------------------------------------------------------------------------------
//Come ture frame synchronization to ignore error frame or has not capture when vsync begin
reg		frame_sync_flag;
always@(posedge cmos_pclk or negedge rst_n)
begin
	if(!rst_n)
		frame_sync_flag <= 0;
	else if(cmos_fps_cnt == CMOS_FRAME_WAITCNT && cmos_vsync_end == 1)
		frame_sync_flag <= 1;
	else
		frame_sync_flag <= frame_sync_flag;
end


//----------------------------------------------------------------------------------
//capture and sync RGB565 cmos_data
reg	[7:0]	cmos_data_r;
reg	[15:0]	cmos_frame_data_r;
reg			byte_flag;
always@(posedge cmos_pclk or negedge rst_n)
begin
	if(!rst_n)
		begin
		cmos_data_r <= 0;
		byte_flag <= 0;
		cmos_frame_data_r <= 0;
		end
	else if(cmos_href)
		begin
		byte_flag <= ~byte_flag;
		cmos_data_r <= cmos_data;
		if(byte_flag == 1'b1)
			cmos_frame_data_r <= {cmos_data_r, cmos_data};	//MSB -> LSB
		else
			cmos_frame_data_r <= cmos_frame_data_r;
		end
	else
		begin
		cmos_data_r <= 0;
		byte_flag <= 0;
		cmos_frame_data_r <= cmos_frame_data_r;
		end
end


//-----------------------------------------------
//Generate cmos data enable clock signal
reg	byte_flag_r;
always@(posedge cmos_pclk or negedge rst_n)
begin
	if(!rst_n)
		byte_flag_r <= 0;
	else
		byte_flag_r <= byte_flag;
end
assign	cmos_frame_vsync = frame_sync_flag ? cmos_vsync_r[1] : 1'b0;//Lag 2 clocks
assign	cmos_frame_href  = frame_sync_flag ? cmos_href_r[1] : 1'b0;	//Lag 2 clocks
assign	cmos_frame_data = (frame_sync_flag & cmos_frame_href) ? {cmos_frame_data_r[15:11], 3'd0, cmos_frame_data_r[10:5], 2'd0,
							 cmos_frame_data_r[4:0], 3'd0} : 24'd0;
assign	cmos_frame_clken = frame_sync_flag ? (byte_flag_r & cmos_frame_href) || (!cmos_frame_href) : 1'b0;
assign  cmos_frame_clk   = cmos_pclk; 

 
//----------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------
//Delay 2s for cmos fps counter
localparam	DELAY_TOP = 2 * CLOCK_CMOS;	//2s delay
reg	[27:0]	delay_cnt;
always@(posedge cmos_pclk or negedge rst_n)
begin
	if(!rst_n)
		delay_cnt <= 0;
	else if(delay_cnt < DELAY_TOP - 1'b1)
		delay_cnt <= delay_cnt + 1'b1;
	else
		delay_cnt <= 0;
end
wire	delay_2s = (delay_cnt == DELAY_TOP - 1'b1) ? 1'b1 : 1'b0;

//-------------------------------------
//cmos image output rate counter
reg	[8:0]	cmos_fps_cnt2;
reg [7:0]	cmos_fps_rate_r;
always@(posedge cmos_pclk or negedge rst_n)
begin
	if(!rst_n)
		begin
		cmos_fps_cnt2 <= 0;
		cmos_fps_rate_r <= 0;
		end
	else if(delay_2s == 1'b0)	//time is not reached
		begin
		cmos_fps_cnt2 <= cmos_vsync_end ? cmos_fps_cnt2 + 1'b1 : cmos_fps_cnt2;
		cmos_fps_rate_r <= cmos_fps_rate_r;
		end
	else	//time up
		begin
		cmos_fps_cnt2 <= 0;
		cmos_fps_rate_r <= cmos_fps_cnt2[8:1];	//divide by 2
		end
end

assign cmos_fps_rate = frame_sync_flag ? cmos_fps_rate_r : 8'd0;

endmodule


