`timescale 1ns / 1ps

module VideoPlayer(
    input                   reset_out,
    input                   clk,
    input                   vk_check,
    input                   reset_restartable, 
    input                   debug_switch,
    input                   play_game_out,
    input                   new_signal, 
    input                   menu_enabled, animate_pixel_disabled,
    input [1:0]             song,
    input [2:0]             speed,
    input                   tips_display,
    output [2:0]            displaypick,
    output [7:0]            progressdisplay,
    output                  failed,
    output                  in_animate_area, animate_finish,
    output                  song_done,// isGameWon
    output                  hsync, vsync,
    output reg[3:0]         r, g, b,
    output [2:0]            debug
);

    wire [9:0]              progress;
    wire                    valid; // unused
    wire [3:0]              r_playing, g_playing, b_playing; 
    wire [3:0]              r_menu, g_menu, b_menu;
    wire [9:0]              h_cnt, v_cnt;
    wire                    clk2ms;
        
    vgaPlay vpy(
        .clk                (clk), 
        .reset_raw          (reset_restartable), 
        .play_signal        (play_game_out),
        .speed              (speed), 
        .song               (song), 
        .debug_switch       (debug_switch), 
        .press_raw          (vk_check),
        .tips_display       (tips_display),
        .hsync              (hsync), 
        .vsync              (vsync), 
        .valid              (valid), 
        .r                  (r_playing), 
        .g                  (g_playing), 
        .b                  (b_playing), 
        .failed             (failed), 
        .progress           (progress), 
        .debug              (debug),
        .h_cnt              (h_cnt), 
        .v_cnt              (v_cnt), 
        .song_done          (song_done)
        );
    
    vgaChooseSong vcs(
        .clk                (clk), 
        .menu_enabled       (menu_enabled),
        .song               (song), 
        .h_cnt              (h_cnt), 
        .v_cnt              (v_cnt), 
        .r                  (r_menu),
        .g                  (g_menu), 
        .b                  (b_menu)
        );

    vgaAnimate van(
        .clk                (clk),
        .reset_out          (reset_out),
        .new_signal         (new_signal),
        .h_cnt              (h_cnt),
        .v_cnt              (v_cnt),
        .in_animate_area    (in_animate_area), 
        .animate_finish     (animate_finish)
        );

    string_display3 sd3(
        .in                 (progress), 
        .clk2ms             (clk2ms), 
        .pick               (displaypick), 
        .segs               (progressdisplay)
        );
    
    fre_div#(200000) cd500(
        .clk_in             (clk), 
        .clk_out            (clk2ms), 
        .reset              (reset_out)
        );

    always@(posedge clk or posedge reset_out) begin
        if(reset_out) begin
            r <= 4'h0;
            g <= 4'h0;
            b <= 4'h0;
        end else begin
            if(animate_pixel_disabled == 1'b1) begin
                r <= 4'h0;
                g <= 4'h0;
                b <= 4'h0;
            end else begin
                if(menu_enabled == 1'b1) begin
                    r <= r_menu;
                    g <= g_menu;
                    b <= b_menu;
                end else begin
                    r <= r_playing;
                    g <= g_playing;
                    b <= b_playing;
                end
            end
        end
    end

endmodule