   
    parameter PROC_NUM = 12;
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
    function [576:0] proc_path(input [PROC_NUM - 1:0] dl_vec);
        integer index;
        begin
            index = proc_index(dl_vec);
            case (index)
                0 : begin
                    proc_path = "color_analysis_color_analysis.entry_proc_U0";
                end
                1 : begin
                    proc_path = "color_analysis_color_analysis.Block_entry1_proc_U0";
                end
                2 : begin
                    proc_path = "color_analysis_color_analysis.AXIvideo2xfMat_24_9_600_1024_1_2_U0";
                end
                3 : begin
                    proc_path = "color_analysis_color_analysis.medianBlur_3_1_9_600_1024_1_2_2_U0";
                end
                4 : begin
                    proc_path = "color_analysis_color_analysis.ImgProcess_9_0_600_1024_1_2_U0";
                end
                5 : begin
                    proc_path = "color_analysis_color_analysis.erode_0_0_600_1024_0_3_3_1_1_2_2_U0";
                end
                6 : begin
                    proc_path = "color_analysis_color_analysis.dilate_0_0_600_1024_0_3_3_1_1_2_2_U0";
                end
                7 : begin
                    proc_path = "color_analysis_color_analysis.duplicateMat_0_600_1024_1_2_2_2_U0";
                end
                8 : begin
                    proc_path = "color_analysis_color_analysis.gray2rgb_0_9_600_1024_1_2_2_U0";
                end
                9 : begin
                    proc_path = "color_analysis_color_analysis.gray2rgb_0_9_600_1024_1_2_2_1_U0";
                end
                10 : begin
                    proc_path = "color_analysis_color_analysis.xfMat2AXIvideo_24_9_600_1024_1_2_U0";
                end
                11 : begin
                    proc_path = "color_analysis_color_analysis.xfMat2AXIvideo_24_9_600_1024_1_2_2_U0";
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
    task print_cycle_start(input reg [576:0] proc_path, input integer cycle_id);
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
    task print_cycle_proc_comp(input reg [576:0] proc_path, input integer cycle_comp_id);
        begin
            $display("// (%0d): Process: %0s", cycle_comp_id, proc_path);
            $fdisplay(fp, "Dependence_Process_ID %0d", cycle_comp_id);
            $fdisplay(fp, "Dependence_Process_path %0s", proc_path);
        end
    endtask

    // print one channel component in the cycle
    task print_cycle_chan_comp(input [PROC_NUM - 1:0] dl_vec1, input [PROC_NUM - 1:0] dl_vec2);
        reg [648:0] chan_path;
        integer index1;
        integer index2;
        begin
            index1 = proc_index(dl_vec1);
            index2 = proc_index(dl_vec2);
            case (index1)
                0 : begin
                    case(index2)
                    4: begin
                        if (~entry_proc_U0.cb_lower_c_blk_n) begin
                            if (~cb_lower_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.cb_lower_c_U' written by process 'color_analysis_color_analysis.ImgProcess_9_0_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.cb_lower_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cb_lower_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.cb_lower_c_U' read by process 'color_analysis_color_analysis.ImgProcess_9_0_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.cb_lower_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~entry_proc_U0.cb_upper_c_blk_n) begin
                            if (~cb_upper_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.cb_upper_c_U' written by process 'color_analysis_color_analysis.ImgProcess_9_0_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.cb_upper_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cb_upper_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.cb_upper_c_U' read by process 'color_analysis_color_analysis.ImgProcess_9_0_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.cb_upper_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~entry_proc_U0.cr_lower_c_blk_n) begin
                            if (~cr_lower_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.cr_lower_c_U' written by process 'color_analysis_color_analysis.ImgProcess_9_0_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.cr_lower_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cr_lower_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.cr_lower_c_U' read by process 'color_analysis_color_analysis.ImgProcess_9_0_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.cr_lower_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~entry_proc_U0.cr_upper_c_blk_n) begin
                            if (~cr_upper_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.cr_upper_c_U' written by process 'color_analysis_color_analysis.ImgProcess_9_0_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.cr_upper_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cr_upper_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.cr_upper_c_U' read by process 'color_analysis_color_analysis.ImgProcess_9_0_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.cr_upper_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    1: begin
                        if (ap_sync_entry_proc_U0_ap_ready & entry_proc_U0.ap_idle & ~ap_sync_Block_entry1_proc_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                        end
                    end
                    endcase
                end
                1 : begin
                    case(index2)
                    0: begin
                        if (ap_sync_Block_entry1_proc_U0_ap_ready & Block_entry1_proc_U0.ap_idle & ~ap_sync_entry_proc_U0_ap_ready) begin
                            $display("//      Blocked by input sync logic with process : 'color_analysis_color_analysis.entry_proc_U0'");
                        end
                    end
                    endcase
                end
                2 : begin
                    case(index2)
                    1: begin
                        if (~img_0_rows_c23_channel_U.if_empty_n & AXIvideo2xfMat_24_9_600_1024_1_2_U0.ap_idle & ~img_0_rows_c23_channel_U.if_write) begin
                            if (~img_0_rows_c23_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_0_rows_c23_channel_U' written by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_0_rows_c23_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_0_rows_c23_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_0_rows_c23_channel_U' read by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_0_rows_c23_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~img_0_cols_c24_channel_U.if_empty_n & AXIvideo2xfMat_24_9_600_1024_1_2_U0.ap_idle & ~img_0_cols_c24_channel_U.if_write) begin
                            if (~img_0_cols_c24_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_0_cols_c24_channel_U' written by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_0_cols_c24_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_0_cols_c24_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_0_cols_c24_channel_U' read by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_0_cols_c24_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    3: begin
                        if (~AXIvideo2xfMat_24_9_600_1024_1_2_U0.grp_AXIvideo2xfMat_24_9_600_1024_1_2_Pipeline_loop_col_zxi2mat_fu_205.img_0_data163_blk_n) begin
                            if (~img_0_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_0_data_U' written by process 'color_analysis_color_analysis.medianBlur_3_1_9_600_1024_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_0_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_0_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_0_data_U' read by process 'color_analysis_color_analysis.medianBlur_3_1_9_600_1024_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_0_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~AXIvideo2xfMat_24_9_600_1024_1_2_U0.img_0_rows_c_blk_n) begin
                            if (~img_0_rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_0_rows_c_U' written by process 'color_analysis_color_analysis.medianBlur_3_1_9_600_1024_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_0_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_0_rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_0_rows_c_U' read by process 'color_analysis_color_analysis.medianBlur_3_1_9_600_1024_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_0_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~AXIvideo2xfMat_24_9_600_1024_1_2_U0.img_0_cols_c_blk_n) begin
                            if (~img_0_cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_0_cols_c_U' written by process 'color_analysis_color_analysis.medianBlur_3_1_9_600_1024_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_0_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_0_cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_0_cols_c_U' read by process 'color_analysis_color_analysis.medianBlur_3_1_9_600_1024_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_0_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~start_for_medianBlur_3_1_9_600_1024_1_2_2_U0_U.if_full_n & AXIvideo2xfMat_24_9_600_1024_1_2_U0.ap_start & ~AXIvideo2xfMat_24_9_600_1024_1_2_U0.real_start & (trans_in_cnt_0 == trans_out_cnt_0) & ~start_for_medianBlur_3_1_9_600_1024_1_2_2_U0_U.if_read) begin
                            $display("//      Blocked by full output start propagation FIFO 'color_analysis_color_analysis.start_for_medianBlur_3_1_9_600_1024_1_2_2_U0_U' read by process 'color_analysis_color_analysis.medianBlur_3_1_9_600_1024_1_2_2_U0',");
                        end
                    end
                    endcase
                end
                3 : begin
                    case(index2)
                    2: begin
                        if (~medianBlur_3_1_9_600_1024_1_2_2_U0.p_src_rows_blk_n) begin
                            if (~img_0_rows_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_0_rows_c_U' written by process 'color_analysis_color_analysis.AXIvideo2xfMat_24_9_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_0_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_0_rows_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_0_rows_c_U' read by process 'color_analysis_color_analysis.AXIvideo2xfMat_24_9_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_0_rows_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~medianBlur_3_1_9_600_1024_1_2_2_U0.p_src_cols_blk_n) begin
                            if (~img_0_cols_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_0_cols_c_U' written by process 'color_analysis_color_analysis.AXIvideo2xfMat_24_9_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_0_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_0_cols_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_0_cols_c_U' read by process 'color_analysis_color_analysis.AXIvideo2xfMat_24_9_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_0_cols_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~medianBlur_3_1_9_600_1024_1_2_2_U0.grp_xFMedianNxN_600_1024_3_9_1_2_2_0_1025_3_9_s_fu_44.grp_xFMedianNxN_600_1024_3_9_1_2_2_0_1025_3_9_Pipeline_VITIS_LOOP_423_2_fu_141.img_0_data163_blk_n) begin
                            if (~img_0_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_0_data_U' written by process 'color_analysis_color_analysis.AXIvideo2xfMat_24_9_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_0_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_0_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_0_data_U' read by process 'color_analysis_color_analysis.AXIvideo2xfMat_24_9_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_0_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    4: begin
                        if (~medianBlur_3_1_9_600_1024_1_2_2_U0.grp_xFMedianNxN_600_1024_3_9_1_2_2_0_1025_3_9_s_fu_44.grp_xFMedianNxN_600_1024_3_9_1_2_2_0_1025_3_9_Pipeline_Col_Loop_fu_161.img_1_data164_blk_n) begin
                            if (~img_1_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_1_data_U' written by process 'color_analysis_color_analysis.ImgProcess_9_0_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_1_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_1_data_U' read by process 'color_analysis_color_analysis.ImgProcess_9_0_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                4 : begin
                    case(index2)
                    1: begin
                        if (~img_1_rows_channel_U.if_empty_n & ImgProcess_9_0_600_1024_1_2_U0.ap_idle & ~img_1_rows_channel_U.if_write) begin
                            if (~img_1_rows_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_1_rows_channel_U' written by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_1_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_1_rows_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_1_rows_channel_U' read by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_1_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~img_1_cols_channel_U.if_empty_n & ImgProcess_9_0_600_1024_1_2_U0.ap_idle & ~img_1_cols_channel_U.if_write) begin
                            if (~img_1_cols_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_1_cols_channel_U' written by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_1_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_1_cols_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_1_cols_channel_U' read by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_1_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    3: begin
                        if (~ImgProcess_9_0_600_1024_1_2_U0.grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80.img_1_data164_blk_n) begin
                            if (~img_1_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_1_data_U' written by process 'color_analysis_color_analysis.medianBlur_3_1_9_600_1024_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_1_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_1_data_U' read by process 'color_analysis_color_analysis.medianBlur_3_1_9_600_1024_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_1_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    5: begin
                        if (~ImgProcess_9_0_600_1024_1_2_U0.grp_ImgProcess_9_0_600_1024_1_2_Pipeline_loop_color_rows_loop_color_cols_fu_80.img_2_data165_blk_n) begin
                            if (~img_2_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_2_data_U' written by process 'color_analysis_color_analysis.erode_0_0_600_1024_0_3_3_1_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_2_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_2_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_2_data_U' read by process 'color_analysis_color_analysis.erode_0_0_600_1024_0_3_3_1_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_2_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    0: begin
                        if (~ImgProcess_9_0_600_1024_1_2_U0.cb_lower_blk_n) begin
                            if (~cb_lower_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.cb_lower_c_U' written by process 'color_analysis_color_analysis.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.cb_lower_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cb_lower_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.cb_lower_c_U' read by process 'color_analysis_color_analysis.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.cb_lower_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~ImgProcess_9_0_600_1024_1_2_U0.cb_upper_blk_n) begin
                            if (~cb_upper_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.cb_upper_c_U' written by process 'color_analysis_color_analysis.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.cb_upper_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cb_upper_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.cb_upper_c_U' read by process 'color_analysis_color_analysis.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.cb_upper_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~ImgProcess_9_0_600_1024_1_2_U0.cr_lower_blk_n) begin
                            if (~cr_lower_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.cr_lower_c_U' written by process 'color_analysis_color_analysis.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.cr_lower_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cr_lower_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.cr_lower_c_U' read by process 'color_analysis_color_analysis.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.cr_lower_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~ImgProcess_9_0_600_1024_1_2_U0.cr_upper_blk_n) begin
                            if (~cr_upper_c_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.cr_upper_c_U' written by process 'color_analysis_color_analysis.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.cr_upper_c_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~cr_upper_c_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.cr_upper_c_U' read by process 'color_analysis_color_analysis.entry_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.cr_upper_c_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                5 : begin
                    case(index2)
                    1: begin
                        if (~img_2_rows_channel_U.if_empty_n & erode_0_0_600_1024_0_3_3_1_1_2_2_U0.ap_idle & ~img_2_rows_channel_U.if_write) begin
                            if (~img_2_rows_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_2_rows_channel_U' written by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_2_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_2_rows_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_2_rows_channel_U' read by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_2_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~img_2_cols_channel_U.if_empty_n & erode_0_0_600_1024_0_3_3_1_1_2_2_U0.ap_idle & ~img_2_cols_channel_U.if_write) begin
                            if (~img_2_cols_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_2_cols_channel_U' written by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_2_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_2_cols_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_2_cols_channel_U' read by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_2_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    4: begin
                        if (~erode_0_0_600_1024_0_3_3_1_1_2_2_U0.grp_xferode_600_1024_1_0_1_2_2_0_1025_3_3_s_fu_34.grp_xferode_600_1024_1_0_1_2_2_0_1025_3_3_Pipeline_Col_Loop_fu_155.img_2_data165_blk_n) begin
                            if (~img_2_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_2_data_U' written by process 'color_analysis_color_analysis.ImgProcess_9_0_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_2_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_2_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_2_data_U' read by process 'color_analysis_color_analysis.ImgProcess_9_0_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_2_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    6: begin
                        if (~erode_0_0_600_1024_0_3_3_1_1_2_2_U0.grp_xferode_600_1024_1_0_1_2_2_0_1025_3_3_s_fu_34.grp_xferode_600_1024_1_0_1_2_2_0_1025_3_3_Pipeline_Col_Loop_fu_155.img_3_data166_blk_n) begin
                            if (~img_3_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_3_data_U' written by process 'color_analysis_color_analysis.dilate_0_0_600_1024_0_3_3_1_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_3_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_3_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_3_data_U' read by process 'color_analysis_color_analysis.dilate_0_0_600_1024_0_3_3_1_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_3_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                6 : begin
                    case(index2)
                    1: begin
                        if (~img_3_rows_channel_U.if_empty_n & dilate_0_0_600_1024_0_3_3_1_1_2_2_U0.ap_idle & ~img_3_rows_channel_U.if_write) begin
                            if (~img_3_rows_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_3_rows_channel_U' written by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_3_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_3_rows_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_3_rows_channel_U' read by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_3_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~img_3_cols_channel_U.if_empty_n & dilate_0_0_600_1024_0_3_3_1_1_2_2_U0.ap_idle & ~img_3_cols_channel_U.if_write) begin
                            if (~img_3_cols_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_3_cols_channel_U' written by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_3_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_3_cols_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_3_cols_channel_U' read by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_3_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    5: begin
                        if (~dilate_0_0_600_1024_0_3_3_1_1_2_2_U0.grp_xfdilate_600_1024_1_0_1_2_2_0_1025_3_3_s_fu_34.grp_xfdilate_600_1024_1_0_1_2_2_0_1025_3_3_Pipeline_VITIS_LOOP_294_2_fu_146.img_3_data166_blk_n) begin
                            if (~img_3_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_3_data_U' written by process 'color_analysis_color_analysis.erode_0_0_600_1024_0_3_3_1_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_3_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_3_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_3_data_U' read by process 'color_analysis_color_analysis.erode_0_0_600_1024_0_3_3_1_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_3_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    7: begin
                        if (~dilate_0_0_600_1024_0_3_3_1_1_2_2_U0.grp_xfdilate_600_1024_1_0_1_2_2_0_1025_3_3_s_fu_34.grp_xfdilate_600_1024_1_0_1_2_2_0_1025_3_3_Pipeline_Col_Loop_fu_155.img_4_data167_blk_n) begin
                            if (~img_4_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_4_data_U' written by process 'color_analysis_color_analysis.duplicateMat_0_600_1024_1_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_4_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_4_data_U' read by process 'color_analysis_color_analysis.duplicateMat_0_600_1024_1_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                7 : begin
                    case(index2)
                    1: begin
                        if (~img_4_rows_channel_U.if_empty_n & duplicateMat_0_600_1024_1_2_2_2_U0.ap_idle & ~img_4_rows_channel_U.if_write) begin
                            if (~img_4_rows_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_4_rows_channel_U' written by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_4_rows_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_4_rows_channel_U' read by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~img_4_cols_channel_U.if_empty_n & duplicateMat_0_600_1024_1_2_2_2_U0.ap_idle & ~img_4_cols_channel_U.if_write) begin
                            if (~img_4_cols_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_4_cols_channel_U' written by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_4_cols_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_4_cols_channel_U' read by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    6: begin
                        if (~duplicateMat_0_600_1024_1_2_2_2_U0.grp_duplicateMat_0_600_1024_1_2_2_2_Pipeline_Col_Loop_fu_56.img_4_data167_blk_n) begin
                            if (~img_4_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_4_data_U' written by process 'color_analysis_color_analysis.dilate_0_0_600_1024_0_3_3_1_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_4_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_4_data_U' read by process 'color_analysis_color_analysis.dilate_0_0_600_1024_0_3_3_1_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    8: begin
                        if (~duplicateMat_0_600_1024_1_2_2_2_U0.grp_duplicateMat_0_600_1024_1_2_2_2_Pipeline_Col_Loop_fu_56.img_4a_data168_blk_n) begin
                            if (~img_4a_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_4a_data_U' written by process 'color_analysis_color_analysis.gray2rgb_0_9_600_1024_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4a_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_4a_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_4a_data_U' read by process 'color_analysis_color_analysis.gray2rgb_0_9_600_1024_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4a_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    9: begin
                        if (~duplicateMat_0_600_1024_1_2_2_2_U0.grp_duplicateMat_0_600_1024_1_2_2_2_Pipeline_Col_Loop_fu_56.img_4b_data169_blk_n) begin
                            if (~img_4b_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_4b_data_U' written by process 'color_analysis_color_analysis.gray2rgb_0_9_600_1024_1_2_2_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4b_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_4b_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_4b_data_U' read by process 'color_analysis_color_analysis.gray2rgb_0_9_600_1024_1_2_2_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4b_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                8 : begin
                    case(index2)
                    1: begin
                        if (~img_4a_rows_channel_U.if_empty_n & gray2rgb_0_9_600_1024_1_2_2_U0.ap_idle & ~img_4a_rows_channel_U.if_write) begin
                            if (~img_4a_rows_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_4a_rows_channel_U' written by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4a_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_4a_rows_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_4a_rows_channel_U' read by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4a_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~img_4a_cols_channel_U.if_empty_n & gray2rgb_0_9_600_1024_1_2_2_U0.ap_idle & ~img_4a_cols_channel_U.if_write) begin
                            if (~img_4a_cols_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_4a_cols_channel_U' written by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4a_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_4a_cols_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_4a_cols_channel_U' read by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4a_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    7: begin
                        if (~gray2rgb_0_9_600_1024_1_2_2_U0.grp_gray2rgb_0_9_600_1024_1_2_2_Pipeline_columnloop_fu_54.img_4a_data168_blk_n) begin
                            if (~img_4a_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_4a_data_U' written by process 'color_analysis_color_analysis.duplicateMat_0_600_1024_1_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4a_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_4a_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_4a_data_U' read by process 'color_analysis_color_analysis.duplicateMat_0_600_1024_1_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4a_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    10: begin
                        if (~gray2rgb_0_9_600_1024_1_2_2_U0.grp_gray2rgb_0_9_600_1024_1_2_2_Pipeline_columnloop_fu_54.img_5_data170_blk_n) begin
                            if (~img_5_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_5_data_U' written by process 'color_analysis_color_analysis.xfMat2AXIvideo_24_9_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_5_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_5_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_5_data_U' read by process 'color_analysis_color_analysis.xfMat2AXIvideo_24_9_600_1024_1_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_5_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                9 : begin
                    case(index2)
                    1: begin
                        if (~img_4b_rows_channel_U.if_empty_n & gray2rgb_0_9_600_1024_1_2_2_1_U0.ap_idle & ~img_4b_rows_channel_U.if_write) begin
                            if (~img_4b_rows_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_4b_rows_channel_U' written by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4b_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_4b_rows_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_4b_rows_channel_U' read by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4b_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~img_4b_cols_channel_U.if_empty_n & gray2rgb_0_9_600_1024_1_2_2_1_U0.ap_idle & ~img_4b_cols_channel_U.if_write) begin
                            if (~img_4b_cols_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_4b_cols_channel_U' written by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4b_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_4b_cols_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_4b_cols_channel_U' read by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4b_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    7: begin
                        if (~gray2rgb_0_9_600_1024_1_2_2_1_U0.grp_gray2rgb_0_9_600_1024_1_2_2_1_Pipeline_columnloop_fu_54.img_4b_data169_blk_n) begin
                            if (~img_4b_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_4b_data_U' written by process 'color_analysis_color_analysis.duplicateMat_0_600_1024_1_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4b_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_4b_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_4b_data_U' read by process 'color_analysis_color_analysis.duplicateMat_0_600_1024_1_2_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_4b_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    11: begin
                        if (~gray2rgb_0_9_600_1024_1_2_2_1_U0.grp_gray2rgb_0_9_600_1024_1_2_2_1_Pipeline_columnloop_fu_54.img_6_data171_blk_n) begin
                            if (~img_6_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_6_data_U' written by process 'color_analysis_color_analysis.xfMat2AXIvideo_24_9_600_1024_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_6_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_6_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_6_data_U' read by process 'color_analysis_color_analysis.xfMat2AXIvideo_24_9_600_1024_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_6_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    endcase
                end
                10 : begin
                    case(index2)
                    1: begin
                        if (~img_5_rows_channel_U.if_empty_n & xfMat2AXIvideo_24_9_600_1024_1_2_U0.ap_idle & ~img_5_rows_channel_U.if_write) begin
                            if (~img_5_rows_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_5_rows_channel_U' written by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_5_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_5_rows_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_5_rows_channel_U' read by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_5_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~img_5_cols_channel_U.if_empty_n & xfMat2AXIvideo_24_9_600_1024_1_2_U0.ap_idle & ~img_5_cols_channel_U.if_write) begin
                            if (~img_5_cols_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_5_cols_channel_U' written by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_5_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_5_cols_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_5_cols_channel_U' read by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_5_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    8: begin
                        if (~xfMat2AXIvideo_24_9_600_1024_1_2_U0.grp_xfMat2AXIvideo_24_9_600_1024_1_2_Pipeline_loop_col_mat2axi_fu_86.img_5_data170_blk_n) begin
                            if (~img_5_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_5_data_U' written by process 'color_analysis_color_analysis.gray2rgb_0_9_600_1024_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_5_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_5_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_5_data_U' read by process 'color_analysis_color_analysis.gray2rgb_0_9_600_1024_1_2_2_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_5_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    11: begin
                        if (ap_done_reg_7 & xfMat2AXIvideo_24_9_600_1024_1_2_U0.ap_done & ~xfMat2AXIvideo_24_9_600_1024_1_2_2_U0.ap_done) begin
                            $display("//      Blocked by output sync logic with process : 'color_analysis_color_analysis.xfMat2AXIvideo_24_9_600_1024_1_2_2_U0'");
                        end
                    end
                    endcase
                end
                11 : begin
                    case(index2)
                    1: begin
                        if (~img_6_rows_channel_U.if_empty_n & xfMat2AXIvideo_24_9_600_1024_1_2_2_U0.ap_idle & ~img_6_rows_channel_U.if_write) begin
                            if (~img_6_rows_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_6_rows_channel_U' written by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_6_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_6_rows_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_6_rows_channel_U' read by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_6_rows_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                        if (~img_6_cols_channel_U.if_empty_n & xfMat2AXIvideo_24_9_600_1024_1_2_2_U0.ap_idle & ~img_6_cols_channel_U.if_write) begin
                            if (~img_6_cols_channel_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_6_cols_channel_U' written by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_6_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_6_cols_channel_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_6_cols_channel_U' read by process 'color_analysis_color_analysis.Block_entry1_proc_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_6_cols_channel_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    9: begin
                        if (~xfMat2AXIvideo_24_9_600_1024_1_2_2_U0.grp_xfMat2AXIvideo_24_9_600_1024_1_2_2_Pipeline_loop_col_mat2axi_fu_86.img_6_data171_blk_n) begin
                            if (~img_6_data_U.if_empty_n) begin
                                $display("//      Blocked by empty input FIFO 'color_analysis_color_analysis.img_6_data_U' written by process 'color_analysis_color_analysis.gray2rgb_0_9_600_1024_1_2_2_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_6_data_U");
                                $fdisplay(fp, "Dependence_Channel_status EMPTY");
                            end
                            else if (~img_6_data_U.if_full_n) begin
                                $display("//      Blocked by full output FIFO 'color_analysis_color_analysis.img_6_data_U' read by process 'color_analysis_color_analysis.gray2rgb_0_9_600_1024_1_2_2_1_U0'");
                                $fdisplay(fp, "Dependence_Channel_path color_analysis_color_analysis.img_6_data_U");
                                $fdisplay(fp, "Dependence_Channel_status FULL");
                            end
                        end
                    end
                    10: begin
                        if (ap_done_reg_8 & xfMat2AXIvideo_24_9_600_1024_1_2_2_U0.ap_done & ~xfMat2AXIvideo_24_9_600_1024_1_2_U0.ap_done) begin
                            $display("//      Blocked by output sync logic with process : 'color_analysis_color_analysis.xfMat2AXIvideo_24_9_600_1024_1_2_U0'");
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
 
