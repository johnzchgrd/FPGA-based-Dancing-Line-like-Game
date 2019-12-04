`timescale 1ns / 1ps

module vgaAnimate(
    input clk,reset_out,
    input new_signal, // whether to start a new animation
    input [9:0] h_cnt,v_cnt,
    output in_animate_area, animate_finish
    );
    wire      clk_animate;
    reg [6:0] special_effect_frame, special_effect_frame_next;
    wire      animate_finish_raw;
    wire      new_signal_out;

    assign animate_finish_raw = (special_effect_frame == 7'd80);
    assign in_animate_area = (
        h_cnt%80 >=0 && h_cnt%80 < special_effect_frame && 
        v_cnt%80 >= 0 && v_cnt%80 < special_effect_frame
        );
    
    
    always @(posedge reset_out or posedge clk_animate) begin
        if (reset_out) begin
            special_effect_frame <= 0;
        end else begin
            special_effect_frame <= special_effect_frame_next;
        end
    end
    always@(*) begin
        if(new_signal_out) begin
            special_effect_frame_next = 0;
        end else begin
            if(animate_finish == 1'b0) begin
                special_effect_frame_next = special_effect_frame + 1;
            end else begin
                special_effect_frame_next = special_effect_frame;
            end
        end
    end 
    
    oneShot os8(
        .clk                    (clk_animate),
        .signal_in              (animate_finish_raw),
        .signal_out             (animate_finish)
    );          
    
    oneShot os9(
        .clk                    (clk_animate),
        .signal_in              (new_signal),
        .signal_out             (new_signal_out)
    );          
    
    fre_div#(2000000) cd50(
        .clk_in                (clk),
        .reset                 (reset_out),
        .clk_out               (clk_animate)
        );
        
endmodule
