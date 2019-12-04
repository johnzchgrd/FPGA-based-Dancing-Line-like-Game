`timescale 1ns / 1ps

module vgaChooseSong(
    input clk,
    input menu_enabled,
    input [1:0] song,
    input [9:0] h_cnt, v_cnt,
    output [3:0] r, g, b
    );
    
    wire [3:0] r_song, g_song, b_song;
    wire [3:0] r_fixed, g_fixed, b_fixed;

    getpixel_songsel ss(
        .clk                (clk), 
        .valid              (menu_enabled), 
        .song               (song), 
        .h_cnt              (h_cnt), 
        .v_cnt              (v_cnt), 
        .r                  (r_fixed), 
        .g                  (g_fixed), 
        .b                  (b_fixed)
        );

    getpixel_songname sn(
        .clk                (clk), 
        .valid              (menu_enabled), 
        .h_cnt              (h_cnt), 
        .v_cnt              (v_cnt), 
        .r                  (r_song), 
        .g                  (g_song), 
        .b                  (b_song)
        );
    
    assign r = r_fixed|r_song;
    assign g = g_fixed|g_song;
    assign b = b_fixed|b_song;
    
endmodule
