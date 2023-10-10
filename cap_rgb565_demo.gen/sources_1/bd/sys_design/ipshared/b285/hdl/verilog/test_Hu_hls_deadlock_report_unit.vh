   
    parameter PROC_NUM = 7;
    parameter ST_IDLE = 3'b000;
    parameter ST_FILTER_FAKE = 3'b001;
    parameter ST_DL_DETECTED = 3'b010;
    parameter ST_DL_REPORT = 3'b100;
   

    reg [2:0] CS_fsm;
    reg [2:0] NS_fsm;
    reg [PROC_NUM - 1:0] dl_detect_reg;
    reg [PROC_NUM - 1:0] dl_done_reg;
    reg [PROC_NUM - 1:0] origin_reg;
    reg [PROC_NUM - 1:0] dl_in_vec_reg;
    reg [31:0] dl_keep_cnt;
    integer i;
    integer fp;

    // FSM State machine
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            CS_fsm <= ST_IDLE;
        end
        else begin
            CS_fsm <= NS_fsm;
        end
    end
    always @ (CS_fsm or dl_in_vec or dl_detect_reg or dl_done_reg or dl_in_vec or origin_reg or dl_keep_cnt) begin
        case (CS_fsm)
            ST_IDLE : begin
                if (|dl_in_vec) begin
                    NS_fsm = ST_FILTER_FAKE;
                end
                else begin
                    NS_fsm = ST_IDLE;
                end
            end
            ST_FILTER_FAKE: begin
                if (dl_keep_cnt >= 32'd1000) begin
                    NS_fsm = ST_DL_DETECTED;
                end
                else if (dl_detect_reg != (dl_detect_reg & dl_in_vec)) begin
                    NS_fsm = ST_IDLE;
                end
                else begin
                    NS_fsm = ST_FILTER_FAKE;
                end
            end
            ST_DL_DETECTED: begin
                // has unreported deadlock cycle
                if (dl_detect_reg != dl_done_reg) begin
                    NS_fsm = ST_DL_REPORT;
                end
                else begin
                    NS_fsm = ST_DL_DETECTED;
                end
            end
            ST_DL_REPORT: begin
                if (|(dl_in_vec & origin_reg)) begin
                    NS_fsm = ST_DL_DETECTED;
                end
                else begin
                    NS_fsm = ST_DL_REPORT;
                end
            end
            default: NS_fsm = ST_IDLE;
        endcase
    end

    // dl_detect_reg record the procs that first detect deadlock
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_detect_reg <= 'b0;
        end
        else begin
            if (CS_fsm == ST_IDLE) begin
                dl_detect_reg <= dl_in_vec;
            end
        end
    end

    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_keep_cnt <= 32'h0;
        end
        else begin
            if (CS_fsm == ST_FILTER_FAKE && (dl_detect_reg == (dl_detect_reg & dl_in_vec))) begin
                dl_keep_cnt <= dl_keep_cnt + 32'h1;
            end
            else if (CS_fsm == ST_FILTER_FAKE && (dl_detect_reg != (dl_detect_reg & dl_in_vec))) begin
                dl_keep_cnt <= 32'h0;
            end
        end
    end

    // dl_detect_out keeps in high after deadlock detected
    assign dl_detect_out = (|dl_detect_reg) && (CS_fsm == ST_DL_DETECTED || CS_fsm == ST_DL_REPORT);

    // dl_done_reg record the cycles has been reported
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_done_reg <= 'b0;
        end
        else begin
            if ((CS_fsm == ST_DL_REPORT) && (|(dl_in_vec & dl_detect_reg) == 'b1)) begin
                dl_done_reg <= dl_done_reg | dl_in_vec;
            end
        end
    end

    // clear token once a cycle is done
    assign token_clear = (CS_fsm == ST_DL_REPORT) ? ((|(dl_in_vec & origin_reg)) ? 'b1 : 'b0) : 'b0;

    // origin_reg record the current cycle start id
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            origin_reg <= 'b0;
        end
        else begin
            if (CS_fsm == ST_DL_DETECTED) begin
                origin_reg <= origin;
            end
        end
    end
   
    // origin will be valid for only one cycle
    wire [PROC_NUM*PROC_NUM - 1:0] origin_tmp;
    assign origin_tmp[PROC_NUM - 1:0] = (dl_detect_reg[0] & ~dl_done_reg[0]) ? 'b1 : 'b0;
    genvar j;
    generate
    for(j = 1;j < PROC_NUM;j = j + 1) begin: F1
        assign origin_tmp[j*PROC_NUM +: PROC_NUM] = (dl_detect_reg[j] & ~dl_done_reg[j]) ? ('b1 << j) : origin_tmp[(j - 1)*PROC_NUM +: PROC_NUM];
    end
    endgenerate
    always @ (CS_fsm or origin_tmp) begin
        if (CS_fsm == ST_DL_DETECTED) begin
            origin = origin_tmp[(PROC_NUM - 1)*PROC_NUM +: PROC_NUM];
        end
        else begin
            origin = 'b0;
        end
    end

    
    // dl_in_vec_reg record the current cycle dl_in_vec
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            dl_in_vec_reg <= 'b0;
        end
        else begin
            if (CS_fsm == ST_DL_DETECTED) begin
                dl_in_vec_reg <= origin;
            end
            else if (CS_fsm == ST_DL_REPORT) begin
                dl_in_vec_reg <= dl_in_vec;
            end
        end
    end
    
    // find_df_deadlock to report the deadlock
    always @ (negedge dl_reset or posedge dl_clock) begin
        if (~dl_reset) begin
            find_df_deadlock <= 1'b0;
        end
        else begin
            if (CS_fsm == ST_DL_DETECTED && dl_detect_reg == dl_done_reg) begin
                find_df_deadlock <= 1'b1;
            end
            else if (CS_fsm == ST_IDLE) begin
                find_df_deadlock <= 1'b0;
            end
        end
    end
    
    // get the first valid proc index in dl vector
    function integer proc_index(input [PROC_NUM - 1:0] dl_vec);
        begin
            proc_index = 0;
            for (i = 0; i < PROC_NUM; i = i + 1) begin
                if (dl_vec[i]) begin
                    proc_index = i;
                end
            end
        end
    endfunction

    // get the proc path based on dl vector
    function [480:0] proc_path(input [PROC_NUM - 1:0] dl_vec);
        integer index;
        begin
            index = proc_index(dl_vec);
            case (index)
                0 : begin
                    proc_path = "test_Hu_test_Hu.AXIvideo2xfMat_24_9_600_1024_1_2_U0";
                end
                1 : begin
                    proc_path = "test_Hu_test_Hu.rgb2gray_9_0_600_1024_1_2_2_U0";
                end
                2 : begin
                    proc_path = "test_Hu_test_Hu.Sobel_0_3_0_0_600_1024_1_false_2_2_2_U0";
                end
                3 : begin
                    proc_path = "test_Hu_test_Hu.addWeighted_0_0_600_1024_1_2_2_2_U0";
                end
                4 : begin
                    proc_path = "test_Hu_test_Hu.resize_2_0_600_1024_300_512_1_2_2_2_U0";
                end
                5 : begin
                    proc_path = "test_Hu_test_Hu.gray2rgb_0_9_300_512_1_2_2_U0";
                end
                6 : begin
                    proc_path = "test_Hu_test_Hu.xfMat2AXIvideo_24_9_300_512_1_2_U0";
                end
                default : begin
                    proc_path = "unknown";
                end
            endcase
        end
    endfunction

    // print the headlines of deadlock detection
    task print_dl_head;
        begin
            $display("\n//////////////////////////////////////////////////////////////////////////////");
            $display("// ERROR!!! DEADLOCK DETECTED at %0t ns! SIMULATION WILL BE STOPPED! //", $time);
            $display("//////////////////////////////////////////////////////////////////////////////");
            fp = $fopen("deadlock_db.dat", "w");
        end
    endtask

    // print the start of a cycle
    task print_cycle_start(input reg [480:0] proc_path, input integer cycle_id);
        begin
            $display("/////////////////////////");
            $display("// Dependence cycle %0d:", cycle_id);
            $display("// (1): Process: %0s", proc_path);
            $fdisplay(fp, "Dependence_Cycle_ID %0d", cycle_id);
            $fdisplay(fp, "Dependence_Process_ID 1");
            $fdisplay(fp, "Dependence_Process_path %0s", proc_path);
        end
    endtask

    // print the end of deadlock detection
    task print_dl_end(input integer num, input integer record_time);
        begin
            $display("////////////////////////////////////////////////////////////////////////");
            $display("// Totally %0d cycles detected!", num);
            $display("////////////////////////////////////////////////////////////////////////");
            $display("// ERROR!!! DEADLOCK DETECTED at %0t ns! SIMULATION WILL BE STOPPED! //", record_time);
            $display("//////////////////////////////////////////////////////////////////////////////");
            $fdisplay(fp, "Dependence_Cycle_Number %0d", num);
            $fclose(fp);
        end
    endtask

    // print one proc component in the cycle
    task print_cycle_proc_comp(input reg [480:0] proc_path, input integer cycle_comp_id);
        begin
            $display("// (%0d): Process: %0s", cycle_comp_id, proc_path);
            $fdisplay(fp, "Dependence_Process_ID %0d", cycle_comp_id);
            $fdisplay(fp, "Dependence_Process_path %0s", proc_path);
        end
    endtask

    // print one channel component in the cycle
    task print_cycle_chan_comp(input [PROC_NUM - 1:0] dl_vec1, input [PROC_NUM - 1:0] dl_vec2);
        reg [576:0] chan_path;
        integer index1;
        integer index2;
        begin
            index1 = proc_index(dl_vec1);
            index2 = proc_index(dl_vec2);
            case (index1)
                0 : begin
                    case(index2)
                    1: begin
                        if (~AXIvideo2xfMat_24_9_600_1024_1_2_U0.grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_168.img_0_data64_blk_n) begin
                            if (~img_0_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'test_Hu_test_Hu.img_0_data_U' written by process 'test_Hu_test_Hu.rgb2gray_9_0_600_1024_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_0_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_0_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'test_Hu_test_Hu.img_0_data_U' read by process 'test_Hu_test_Hu.rgb2gray_9_0_600_1024_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_0_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~AXIvideo2xfMat_24_9_600_1024_1_2_U0.img_0_rows_c_blk_n) begin
                            if (~img_0_rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'test_Hu_test_Hu.img_0_rows_c_U' written by process 'test_Hu_test_Hu.rgb2gray_9_0_600_1024_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_0_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_0_rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'test_Hu_test_Hu.img_0_rows_c_U' read by process 'test_Hu_test_Hu.rgb2gray_9_0_600_1024_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_0_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~AXIvideo2xfMat_24_9_600_1024_1_2_U0.img_0_cols_c_blk_n) begin
                            if (~img_0_cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'test_Hu_test_Hu.img_0_cols_c_U' written by process 'test_Hu_test_Hu.rgb2gray_9_0_600_1024_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_0_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_0_cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'test_Hu_test_Hu.img_0_cols_c_U' read by process 'test_Hu_test_Hu.rgb2gray_9_0_600_1024_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_0_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~start_for_rgb2gray_9_0_600_1024_1_2_2_U0_U.if_full_n & AXIvideo2xfMat_24_9_600_1024_1_2_U0.ap_start & ~AXIvideo2xfMat_24_9_600_1024_1_2_U0.real_start & (trans_in_cnt_0 == trans_out_cnt_0) & ~start_for_rgb2gray_9_0_600_1024_1_2_2_U0_U.if_read) begin
                            $display("//      Blocked by full output start propagation FIFO 'test_Hu_test_Hu.start_for_rgb2gray_9_0_600_1024_1_2_2_U0_U' read by process 'test_Hu_test_Hu.rgb2gray_9_0_600_1024_1_2_2_U0',");
                        end
                    end
                    endcase
                end
                1 : begin
                    case(index2)
                    0: begin
                        if (~rgb2gray_9_0_600_1024_1_2_2_U0.p_src_rows_blk_n) begin
                            if (~img_0_rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'test_Hu_test_Hu.img_0_rows_c_U' written by process 'test_Hu_test_Hu.AXIvideo2xfMat_24_9_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_0_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_0_rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'test_Hu_test_Hu.img_0_rows_c_U' read by process 'test_Hu_test_Hu.AXIvideo2xfMat_24_9_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_0_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~rgb2gray_9_0_600_1024_1_2_2_U0.p_src_cols_blk_n) begin
                            if (~img_0_cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'test_Hu_test_Hu.img_0_cols_c_U' written by process 'test_Hu_test_Hu.AXIvideo2xfMat_24_9_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_0_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_0_cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'test_Hu_test_Hu.img_0_cols_c_U' read by process 'test_Hu_test_Hu.AXIvideo2xfMat_24_9_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_0_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~rgb2gray_9_0_600_1024_1_2_2_U0.grp_rgb2gray_9_0_600_1024_1_2_2_Pipeline_columnloop_fu_66.img_0_data64_blk_n) begin
                            if (~img_0_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'test_Hu_test_Hu.img_0_data_U' written by process 'test_Hu_test_Hu.AXIvideo2xfMat_24_9_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_0_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_0_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'test_Hu_test_Hu.img_0_data_U' read by process 'test_Hu_test_Hu.AXIvideo2xfMat_24_9_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_0_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~start_for_rgb2gray_9_0_600_1024_1_2_2_U0_U.if_empty_n & rgb2gray_9_0_600_1024_1_2_2_U0.ap_idle & ~start_for_rgb2gray_9_0_600_1024_1_2_2_U0_U.if_write) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'test_Hu_test_Hu.start_for_rgb2gray_9_0_600_1024_1_2_2_U0_U' written by process 'test_Hu_test_Hu.AXIvideo2xfMat_24_9_600_1024_1_2_U0',");
                        end
                    end
                    2: begin
                        if (~rgb2gray_9_0_600_1024_1_2_2_U0.grp_rgb2gray_9_0_600_1024_1_2_2_Pipeline_columnloop_fu_66.img_1_data65_blk_n) begin
                            if (~img_1_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'test_Hu_test_Hu.img_1_data_U' written by process 'test_Hu_test_Hu.Sobel_0_3_0_0_600_1024_1_false_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_1_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'test_Hu_test_Hu.img_1_data_U' read by process 'test_Hu_test_Hu.Sobel_0_3_0_0_600_1024_1_false_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~start_for_Sobel_0_3_0_0_600_1024_1_false_2_2_2_U0_U.if_full_n & rgb2gray_9_0_600_1024_1_2_2_U0.ap_start & ~rgb2gray_9_0_600_1024_1_2_2_U0.real_start & (trans_in_cnt_1 == trans_out_cnt_1) & ~start_for_Sobel_0_3_0_0_600_1024_1_false_2_2_2_U0_U.if_read) begin
                            $display("//      Blocked by full output start propagation FIFO 'test_Hu_test_Hu.start_for_Sobel_0_3_0_0_600_1024_1_false_2_2_2_U0_U' read by process 'test_Hu_test_Hu.Sobel_0_3_0_0_600_1024_1_false_2_2_2_U0',");
                        end
                    end
                    endcase
                end
                2 : begin
                    case(index2)
                    1: begin
                        if (~Sobel_0_3_0_0_600_1024_1_false_2_2_2_U0.grp_xFSobelFilter3x3_0_0_600_1024_1_0_0_1_2_2_2_1_1_1024_false_s_fu_18.grp_xFSobelFilter3x3_Pipeline_Clear_Row_Loop_fu_136.img_1_data65_blk_n) begin
                            if (~img_1_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'test_Hu_test_Hu.img_1_data_U' written by process 'test_Hu_test_Hu.rgb2gray_9_0_600_1024_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_1_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'test_Hu_test_Hu.img_1_data_U' read by process 'test_Hu_test_Hu.rgb2gray_9_0_600_1024_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    3: begin
                        if (~Sobel_0_3_0_0_600_1024_1_false_2_2_2_U0.grp_xFSobelFilter3x3_0_0_600_1024_1_0_0_1_2_2_2_1_1_1024_false_s_fu_18.grp_xFSobelFilter3x3_Pipeline_Col_Loop_fu_146.img_2x_data66_blk_n) begin
                            if (~img_2x_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'test_Hu_test_Hu.img_2x_data_U' written by process 'test_Hu_test_Hu.addWeighted_0_0_600_1024_1_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_2x_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_2x_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'test_Hu_test_Hu.img_2x_data_U' read by process 'test_Hu_test_Hu.addWeighted_0_0_600_1024_1_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_2x_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~start_for_addWeighted_0_0_600_1024_1_2_2_2_U0_U.if_full_n & Sobel_0_3_0_0_600_1024_1_false_2_2_2_U0.ap_start & ~Sobel_0_3_0_0_600_1024_1_false_2_2_2_U0.real_start & (trans_in_cnt_2 == trans_out_cnt_2) & ~start_for_addWeighted_0_0_600_1024_1_2_2_2_U0_U.if_read) begin
                            $display("//      Blocked by full output start propagation FIFO 'test_Hu_test_Hu.img_2y_data_U' read by process 'test_Hu_test_Hu.addWeighted_0_0_600_1024_1_2_2_2_U0',");
                        end
                    end
                    endcase
                end
                3 : begin
                    case(index2)
                    2: begin
                        if (~addWeighted_0_0_600_1024_1_2_2_2_U0.grp_AddWeightedKernel_0_0_600_1024_1_2_2_2_1_0_0_1_1_1024_s_fu_18.grp_AddWeightedKernel_Pipeline_ColLoop_fu_40.img_2x_data66_blk_n) begin
                            if (~img_2x_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'test_Hu_test_Hu.img_2x_data_U' written by process 'test_Hu_test_Hu.Sobel_0_3_0_0_600_1024_1_false_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_2x_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_2x_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'test_Hu_test_Hu.img_2x_data_U' read by process 'test_Hu_test_Hu.Sobel_0_3_0_0_600_1024_1_false_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_2x_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~addWeighted_0_0_600_1024_1_2_2_2_U0.grp_AddWeightedKernel_0_0_600_1024_1_2_2_2_1_0_0_1_1_1024_s_fu_18.grp_AddWeightedKernel_Pipeline_ColLoop_fu_40.img_2y_data67_blk_n) begin
                            if (~img_2y_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'test_Hu_test_Hu.img_2y_data_U' written by process 'test_Hu_test_Hu.Sobel_0_3_0_0_600_1024_1_false_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_2y_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_2y_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'test_Hu_test_Hu.img_2y_data_U' read by process 'test_Hu_test_Hu.Sobel_0_3_0_0_600_1024_1_false_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_2y_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~start_for_addWeighted_0_0_600_1024_1_2_2_2_U0_U.if_empty_n & addWeighted_0_0_600_1024_1_2_2_2_U0.ap_idle & ~start_for_addWeighted_0_0_600_1024_1_2_2_2_U0_U.if_write) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'test_Hu_test_Hu.start_for_addWeighted_0_0_600_1024_1_2_2_2_U0_U' written by process 'test_Hu_test_Hu.Sobel_0_3_0_0_600_1024_1_false_2_2_2_U0',");
                        end
                    end
                    4: begin
                        if (~addWeighted_0_0_600_1024_1_2_2_2_U0.grp_AddWeightedKernel_0_0_600_1024_1_2_2_2_1_0_0_1_1_1024_s_fu_18.grp_AddWeightedKernel_Pipeline_ColLoop_fu_40.img_3_data68_blk_n) begin
                            if (~img_3_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'test_Hu_test_Hu.img_3_data_U' written by process 'test_Hu_test_Hu.resize_2_0_600_1024_300_512_1_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_3_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_3_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'test_Hu_test_Hu.img_3_data_U' read by process 'test_Hu_test_Hu.resize_2_0_600_1024_300_512_1_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_3_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~start_for_resize_2_0_600_1024_300_512_1_2_2_2_U0_U.if_full_n & addWeighted_0_0_600_1024_1_2_2_2_U0.ap_start & ~addWeighted_0_0_600_1024_1_2_2_2_U0.real_start & (trans_in_cnt_3 == trans_out_cnt_3) & ~start_for_resize_2_0_600_1024_300_512_1_2_2_2_U0_U.if_read) begin
                            $display("//      Blocked by full output start propagation FIFO 'test_Hu_test_Hu.start_for_resize_2_0_600_1024_300_512_1_2_2_2_U0_U' read by process 'test_Hu_test_Hu.resize_2_0_600_1024_300_512_1_2_2_2_U0',");
                        end
                    end
                    endcase
                end
                4 : begin
                    case(index2)
                    3: begin
                        if (~resize_2_0_600_1024_300_512_1_2_2_2_U0.grp_xFResizeAreaDownScale_600_1024_1_0_1_2_2_1_300_512_1024_512_s_fu_54.grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36.img_3_data68_blk_n) begin
                            if (~img_3_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'test_Hu_test_Hu.img_3_data_U' written by process 'test_Hu_test_Hu.addWeighted_0_0_600_1024_1_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_3_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_3_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'test_Hu_test_Hu.img_3_data_U' read by process 'test_Hu_test_Hu.addWeighted_0_0_600_1024_1_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_3_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~start_for_resize_2_0_600_1024_300_512_1_2_2_2_U0_U.if_empty_n & resize_2_0_600_1024_300_512_1_2_2_2_U0.ap_idle & ~start_for_resize_2_0_600_1024_300_512_1_2_2_2_U0_U.if_write) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'test_Hu_test_Hu.start_for_resize_2_0_600_1024_300_512_1_2_2_2_U0_U' written by process 'test_Hu_test_Hu.addWeighted_0_0_600_1024_1_2_2_2_U0',");
                        end
                    end
                    5: begin
                        if (~resize_2_0_600_1024_300_512_1_2_2_2_U0.grp_xFResizeAreaDownScale_600_1024_1_0_1_2_2_1_300_512_1024_512_s_fu_54.grp_xFResizeAreaDownScale_Pipeline_LOOP_ROW_LOOP_COL_fu_36.img_4_data69_blk_n) begin
                            if (~img_4_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'test_Hu_test_Hu.img_4_data_U' written by process 'test_Hu_test_Hu.gray2rgb_0_9_300_512_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_4_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_4_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'test_Hu_test_Hu.img_4_data_U' read by process 'test_Hu_test_Hu.gray2rgb_0_9_300_512_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_4_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~resize_2_0_600_1024_300_512_1_2_2_2_U0.img_4_rows_c_blk_n) begin
                            if (~img_4_rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'test_Hu_test_Hu.img_4_rows_c_U' written by process 'test_Hu_test_Hu.gray2rgb_0_9_300_512_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_4_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_4_rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'test_Hu_test_Hu.img_4_rows_c_U' read by process 'test_Hu_test_Hu.gray2rgb_0_9_300_512_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_4_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~resize_2_0_600_1024_300_512_1_2_2_2_U0.img_4_cols_c_blk_n) begin
                            if (~img_4_cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'test_Hu_test_Hu.img_4_cols_c_U' written by process 'test_Hu_test_Hu.gray2rgb_0_9_300_512_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_4_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_4_cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'test_Hu_test_Hu.img_4_cols_c_U' read by process 'test_Hu_test_Hu.gray2rgb_0_9_300_512_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_4_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~start_for_gray2rgb_0_9_300_512_1_2_2_U0_U.if_full_n & resize_2_0_600_1024_300_512_1_2_2_2_U0.ap_start & ~resize_2_0_600_1024_300_512_1_2_2_2_U0.real_start & (trans_in_cnt_4 == trans_out_cnt_4) & ~start_for_gray2rgb_0_9_300_512_1_2_2_U0_U.if_read) begin
                            $display("//      Blocked by full output start propagation FIFO 'test_Hu_test_Hu.start_for_gray2rgb_0_9_300_512_1_2_2_U0_U' read by process 'test_Hu_test_Hu.gray2rgb_0_9_300_512_1_2_2_U0',");
                        end
                    end
                    endcase
                end
                5 : begin
                    case(index2)
                    4: begin
                        if (~gray2rgb_0_9_300_512_1_2_2_U0.p_src_rows_blk_n) begin
                            if (~img_4_rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'test_Hu_test_Hu.img_4_rows_c_U' written by process 'test_Hu_test_Hu.resize_2_0_600_1024_300_512_1_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_4_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_4_rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'test_Hu_test_Hu.img_4_rows_c_U' read by process 'test_Hu_test_Hu.resize_2_0_600_1024_300_512_1_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_4_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~gray2rgb_0_9_300_512_1_2_2_U0.p_src_cols_blk_n) begin
                            if (~img_4_cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'test_Hu_test_Hu.img_4_cols_c_U' written by process 'test_Hu_test_Hu.resize_2_0_600_1024_300_512_1_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_4_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_4_cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'test_Hu_test_Hu.img_4_cols_c_U' read by process 'test_Hu_test_Hu.resize_2_0_600_1024_300_512_1_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_4_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~gray2rgb_0_9_300_512_1_2_2_U0.grp_gray2rgb_0_9_300_512_1_2_2_Pipeline_columnloop_fu_66.img_4_data69_blk_n) begin
                            if (~img_4_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'test_Hu_test_Hu.img_4_data_U' written by process 'test_Hu_test_Hu.resize_2_0_600_1024_300_512_1_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_4_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_4_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'test_Hu_test_Hu.img_4_data_U' read by process 'test_Hu_test_Hu.resize_2_0_600_1024_300_512_1_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_4_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~start_for_gray2rgb_0_9_300_512_1_2_2_U0_U.if_empty_n & gray2rgb_0_9_300_512_1_2_2_U0.ap_idle & ~start_for_gray2rgb_0_9_300_512_1_2_2_U0_U.if_write) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'test_Hu_test_Hu.start_for_gray2rgb_0_9_300_512_1_2_2_U0_U' written by process 'test_Hu_test_Hu.resize_2_0_600_1024_300_512_1_2_2_2_U0',");
                        end
                    end
                    6: begin
                        if (~gray2rgb_0_9_300_512_1_2_2_U0.grp_gray2rgb_0_9_300_512_1_2_2_Pipeline_columnloop_fu_66.img_5_data70_blk_n) begin
                            if (~img_5_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'test_Hu_test_Hu.img_5_data_U' written by process 'test_Hu_test_Hu.xfMat2AXIvideo_24_9_300_512_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_5_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_5_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'test_Hu_test_Hu.img_5_data_U' read by process 'test_Hu_test_Hu.xfMat2AXIvideo_24_9_300_512_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_5_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~start_for_xfMat2AXIvideo_24_9_300_512_1_2_U0_U.if_full_n & gray2rgb_0_9_300_512_1_2_2_U0.ap_start & ~gray2rgb_0_9_300_512_1_2_2_U0.real_start & (trans_in_cnt_5 == trans_out_cnt_5) & ~start_for_xfMat2AXIvideo_24_9_300_512_1_2_U0_U.if_read) begin
                            $display("//      Blocked by full output start propagation FIFO 'test_Hu_test_Hu.start_for_xfMat2AXIvideo_24_9_300_512_1_2_U0_U' read by process 'test_Hu_test_Hu.xfMat2AXIvideo_24_9_300_512_1_2_U0',");
                        end
                    end
                    endcase
                end
                6 : begin
                    case(index2)
                    5: begin
                        if (~xfMat2AXIvideo_24_9_300_512_1_2_U0.grp_xfMat2AXIvideo_24_9_300_512_1_2_Pipeline_loop_col_mat2axi_fu_76.img_5_data70_blk_n) begin
                            if (~img_5_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'test_Hu_test_Hu.img_5_data_U' written by process 'test_Hu_test_Hu.gray2rgb_0_9_300_512_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_5_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_5_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'test_Hu_test_Hu.img_5_data_U' read by process 'test_Hu_test_Hu.gray2rgb_0_9_300_512_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path test_Hu_test_Hu.img_5_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~start_for_xfMat2AXIvideo_24_9_300_512_1_2_U0_U.if_empty_n & xfMat2AXIvideo_24_9_300_512_1_2_U0.ap_idle & ~start_for_xfMat2AXIvideo_24_9_300_512_1_2_U0_U.if_write) begin
                            $display("//      Blocked by missing 'ap_start' from start propagation FIFO 'test_Hu_test_Hu.start_for_xfMat2AXIvideo_24_9_300_512_1_2_U0_U' written by process 'test_Hu_test_Hu.gray2rgb_0_9_300_512_1_2_2_U0',");
                        end
                    end
                    endcase
                end
            endcase
        end
    endtask

    // report
    initial begin : report_deadlock
        integer cycle_id;
        integer cycle_comp_id;
        integer record_time;
        wait (dl_reset == 1);
        cycle_id = 1;
        record_time = 0;
        while (1) begin
            @ (negedge dl_clock);
            case (CS_fsm)
                ST_DL_DETECTED: begin
                    cycle_comp_id = 2;
                    if (dl_detect_reg != dl_done_reg) begin
                        if (dl_done_reg == 'b0) begin
                            print_dl_head;
                            record_time = $time;
                        end
                        print_cycle_start(proc_path(origin), cycle_id);
                        cycle_id = cycle_id + 1;
                    end
                    else begin
                        print_dl_end((cycle_id - 1),record_time);
                        @(negedge dl_clock);
                        @(negedge dl_clock);
                        $finish;
                    end
                end
                ST_DL_REPORT: begin
                    if ((|(dl_in_vec)) & ~(|(dl_in_vec & origin_reg))) begin
                        print_cycle_chan_comp(dl_in_vec_reg, dl_in_vec);
                        print_cycle_proc_comp(proc_path(dl_in_vec), cycle_comp_id);
                        cycle_comp_id = cycle_comp_id + 1;
                    end
                    else begin
                        print_cycle_chan_comp(dl_in_vec_reg, dl_in_vec);
                    end
                end
            endcase
        end
    end
 
