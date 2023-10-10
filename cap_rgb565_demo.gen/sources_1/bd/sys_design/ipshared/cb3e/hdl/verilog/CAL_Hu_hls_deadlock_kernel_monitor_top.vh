
wire kernel_monitor_reset;
wire kernel_monitor_clock;
wire kernel_monitor_report;
assign kernel_monitor_reset = ~ap_rst_n;
assign kernel_monitor_clock = ap_clk;
assign kernel_monitor_report = 1'b0;
wire [2:0] axis_block_sigs;
wire [9:0] inst_idle_sigs;
wire [4:0] inst_block_sigs;
wire kernel_block;

assign axis_block_sigs[0] = ~AXIvideo2xfMat_24_9_300_512_1_2_U0.grp_AXIvideo2xfMat_24_9_300_512_1_2_Pipeline_loop_start_hunt_fu_148.INPUT_STREAM_TDATA_blk_n;
assign axis_block_sigs[1] = ~AXIvideo2xfMat_24_9_300_512_1_2_U0.grp_AXIvideo2xfMat_24_9_300_512_1_2_Pipeline_loop_col_zxi2mat_fu_168.INPUT_STREAM_TDATA_blk_n;
assign axis_block_sigs[2] = ~AXIvideo2xfMat_24_9_300_512_1_2_U0.grp_AXIvideo2xfMat_24_9_300_512_1_2_Pipeline_loop_last_hunt_fu_195.INPUT_STREAM_TDATA_blk_n;

assign inst_idle_sigs[0] = entry_proc_U0.ap_idle;
assign inst_block_sigs[0] = (entry_proc_U0.ap_done & ~entry_proc_U0.ap_continue) | ~entry_proc_U0.result_c_blk_n;
assign inst_idle_sigs[1] = AXIvideo2xfMat_24_9_300_512_1_2_U0.ap_idle;
assign inst_block_sigs[1] = (AXIvideo2xfMat_24_9_300_512_1_2_U0.ap_done & ~AXIvideo2xfMat_24_9_300_512_1_2_U0.ap_continue) | ~AXIvideo2xfMat_24_9_300_512_1_2_U0.grp_AXIvideo2xfMat_24_9_300_512_1_2_Pipeline_loop_col_zxi2mat_fu_168.img_0_data14_blk_n | ~AXIvideo2xfMat_24_9_300_512_1_2_U0.img_0_rows_c_blk_n | ~AXIvideo2xfMat_24_9_300_512_1_2_U0.img_0_cols_c_blk_n;
assign inst_idle_sigs[2] = rgb2gray_9_0_300_512_1_2_2_U0.ap_idle;
assign inst_block_sigs[2] = (rgb2gray_9_0_300_512_1_2_2_U0.ap_done & ~rgb2gray_9_0_300_512_1_2_2_U0.ap_continue) | ~rgb2gray_9_0_300_512_1_2_2_U0.p_src_rows_blk_n | ~rgb2gray_9_0_300_512_1_2_2_U0.p_src_cols_blk_n | ~rgb2gray_9_0_300_512_1_2_2_U0.grp_rgb2gray_9_0_300_512_1_2_2_Pipeline_columnloop_fu_66.img_0_data14_blk_n | ~rgb2gray_9_0_300_512_1_2_2_U0.grp_rgb2gray_9_0_300_512_1_2_2_Pipeline_columnloop_fu_66.img_1_data15_blk_n;
assign inst_idle_sigs[3] = HuMoment_0_300_512_1_2_U0.ap_idle;
assign inst_block_sigs[3] = (HuMoment_0_300_512_1_2_U0.ap_done & ~HuMoment_0_300_512_1_2_U0.ap_continue) | ~HuMoment_0_300_512_1_2_U0.grp_HuMoment_0_300_512_1_2_Pipeline_loop_General_rows_fu_172.img_1_data15_blk_n;
assign inst_idle_sigs[4] = Loop_1_proc_U0.ap_idle;
assign inst_block_sigs[4] = (Loop_1_proc_U0.ap_done & ~Loop_1_proc_U0.ap_continue) | ~Loop_1_proc_U0.result_blk_n;

assign inst_idle_sigs[5] = 1'b0;
assign inst_idle_sigs[6] = AXIvideo2xfMat_24_9_300_512_1_2_U0.ap_idle;
assign inst_idle_sigs[7] = AXIvideo2xfMat_24_9_300_512_1_2_U0.grp_AXIvideo2xfMat_24_9_300_512_1_2_Pipeline_loop_start_hunt_fu_148.ap_idle;
assign inst_idle_sigs[8] = AXIvideo2xfMat_24_9_300_512_1_2_U0.grp_AXIvideo2xfMat_24_9_300_512_1_2_Pipeline_loop_col_zxi2mat_fu_168.ap_idle;
assign inst_idle_sigs[9] = AXIvideo2xfMat_24_9_300_512_1_2_U0.grp_AXIvideo2xfMat_24_9_300_512_1_2_Pipeline_loop_last_hunt_fu_195.ap_idle;

CAL_Hu_hls_deadlock_idx0_monitor CAL_Hu_hls_deadlock_idx0_monitor_U (
    .clock(kernel_monitor_clock),
    .reset(kernel_monitor_reset),
    .axis_block_sigs(axis_block_sigs),
    .inst_idle_sigs(inst_idle_sigs),
    .inst_block_sigs(inst_block_sigs),
    .block(kernel_block)
);


always @ (kernel_block or kernel_monitor_reset) begin
    if (kernel_block == 1'b1 && kernel_monitor_reset == 1'b0) begin
        find_kernel_block = 1'b1;
    end
    else begin
        find_kernel_block = 1'b0;
    end
end
