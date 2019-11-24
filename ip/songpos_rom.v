`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/29 19:13:25
// Design Name: 
// Module Name: songpos_rom
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

parameter songwidth = 2;
parameter songcount = 4;
module pulse1_pos_rom(
    input clock,
    input [songwidth-1:0] song,
    output reg [15:0] songpos
    );
    wire [15:0] memory [songcount-1:0];
    
	always @(posedge clock)						
        songpos = memory[song];
    
    parameter ch1s1 = 526;
    parameter ch1s2 = 291;
    parameter ch1s3 = 81;
    
    assign memory[0] = 15'b0;
    assign memory[1] = ch1s1;
    assign memory[2] = ch1s1 + ch1s2;
    assign memory[3] = ch1s1 + ch1s2 + ch1s3;
endmodule

module pulse2_pos_rom(
    input clock,
    input [songwidth-1:0] song,
    output reg [15:0] songpos
    );
    wire [15:0] memory [songcount-1:0];
    
	always @(posedge clock)						
        songpos = memory[song];
    
    parameter ch2s1 = 526;
    parameter ch2s2 = 146;
    parameter ch2s3 = 128;
    
    assign memory[0] = 15'b0;
    assign memory[1] = ch2s1;
    assign memory[2] = ch2s1 + ch2s2;
    assign memory[3] = ch2s1 + ch2s2 + ch2s3;
endmodule

module pulse3_pos_rom(
    input clock,
    input [songwidth-1:0] song,
    output reg [15:0] songpos
    );
    wire [15:0] memory [songcount-1:0];
    
	always @(posedge clock)						
        songpos = memory[song];
    
    parameter ch3s1 = 526;
    parameter ch3s2 = 155;
    parameter ch3s3 = 195;
    
    assign memory[0] = 15'b0;
    assign memory[1] = ch3s1;
    assign memory[2] = ch3s1 + ch3s2;
    assign memory[3] = ch3s1 + ch3s2 + ch3s3;
endmodule

module pulse4_pos_rom(
    input clock,
    input [songwidth-1:0] song,
    output reg [15:0] songpos
    );
    wire [15:0] memory [songcount-1:0];
    
	always @(posedge clock)						
        songpos = memory[song];
    
    parameter ch4s1 = 402;
    parameter ch4s2 = 120;
    parameter ch4s3 = 125;
    
    assign memory[0] = 15'b0;
    assign memory[1] = ch4s1;
    assign memory[2] = ch4s1 + ch4s2;
    assign memory[3] = ch4s1 + ch4s2 + ch4s3;
endmodule

module pulse5_pos_rom(
    input clock,
    input [songwidth-1:0] song,
    output reg [15:0] songpos
    );
    wire [15:0] memory [songcount-1:0];
    
	always @(posedge clock)						
        songpos = memory[song];
    
    parameter ch5s1 = 656;
    parameter ch5s2 = 120;
    parameter ch5s3 = 125;
    
    assign memory[0] = 15'b0;
    assign memory[1] = ch5s1;
    assign memory[2] = ch5s1 + ch5s2;
    assign memory[3] = ch5s1 + ch5s2 + ch5s3;
endmodule

module tri1_pos_rom(
    input clock,
    input [songwidth-1:0] song,
    output reg [15:0] songpos
    );
    wire [15:0] memory [songcount-1:0];
    
	always @(posedge clock)						
        songpos = memory[song];
    
    parameter ch6s1 = 290;
    parameter ch6s2 = 120;
    parameter ch6s3 = 265;
    
    assign memory[0] = 15'b0;
    assign memory[1] = ch6s1;
    assign memory[2] = ch6s1 + ch6s2;
    assign memory[3] = ch6s1 + ch6s2 + ch6s3;
endmodule

module tri2_pos_rom(
    input clock,
    input [songwidth-1:0] song,
    output reg [15:0] songpos
    );
    wire [15:0] memory [songcount-1:0];
    
	always @(posedge clock)						
        songpos = memory[song];
    
    parameter ch7s1 = 273;
    parameter ch7s2 = 120;
    parameter ch7s3 = 81;
    
    assign memory[0] = 15'b0;
    assign memory[1] = ch7s1;
    assign memory[2] = ch7s1 + ch7s2;
    assign memory[3] = ch7s1 + ch7s2 + ch7s3;
endmodule

module tri3_pos_rom(
    input clock,
    input [songwidth-1:0] song,
    output reg [15:0] songpos
    );
    wire [15:0] memory [songcount-1:0];
    
	always @(posedge clock)						
        songpos = memory[song];
    
    parameter ch8s1 = 140;
    parameter ch8s2 = 120;
    parameter ch8s3 = 81;
    
    assign memory[0] = 15'b0;
    assign memory[1] = ch8s1;
    assign memory[2] = ch8s1 + ch8s2;
    assign memory[3] = ch8s1 + ch8s2 + ch8s3;
endmodule

module saw1_pos_rom(
    input clock,
    input [songwidth-1:0] song,
    output reg [15:0] songpos
    );
    wire [15:0] memory [songcount-1:0];
    
	always @(posedge clock)						
        songpos = memory[song];
    
    parameter ch9s1 = 679;
    parameter ch9s2 = 423;
    parameter ch9s3 = 156;
    
    assign memory[0] = 15'b0;
    assign memory[1] = ch9s1;
    assign memory[2] = ch9s1 + ch9s2;
    assign memory[3] = ch9s1 + ch9s2 + ch9s3;
endmodule

module drums_pos_rom(
    input clock,
    input [songwidth-1:0] song,
    output reg [15:0] songpos
    );
    wire [15:0] memory [songcount-1:0];
    
	always @(posedge clock)						
        songpos = memory[song];
    
    parameter ch10s1 = 538;
    parameter ch10s2 = 529;
    parameter ch10s3 = 411;
    
    assign memory[0] = 15'b0;
    assign memory[1] = ch10s1;
    assign memory[2] = ch10s1 + ch10s2;
    assign memory[3] = ch10s1 + ch10s2 + ch10s3;
endmodule

module saw2_pos_rom(
    input clock,
    input [songwidth-1:0] song,
    output reg [15:0] songpos
    );
    wire [15:0] memory [songcount-1:0];
    
	always @(posedge clock)						
        songpos = memory[song];
    
    parameter ch11s1 = 142;
    parameter ch11s2 = 140;
    parameter ch11s3 = 81;
    
    assign memory[0] = 15'b0;
    assign memory[1] = ch11s1;
    assign memory[2] = ch11s1 + ch11s2;
    assign memory[3] = ch11s1 + ch11s2 + ch11s3;
endmodule

module saw3_pos_rom(
    input clock,
    input [songwidth-1:0] song,
    output reg [15:0] songpos
    );
    wire [15:0] memory [songcount-1:0];
    
	always @(posedge clock)						
        songpos = memory[song];
    
    parameter ch12s1 = 142;
    parameter ch12s2 = 646;
    parameter ch12s3 = 81;
    
    assign memory[0] = 15'b0;
    assign memory[1] = ch12s1;
    assign memory[2] = ch12s1 + ch12s2;
    assign memory[3] = ch12s1 + ch12s2 + ch12s3;
endmodule

module lead1_pos_rom(
    input clock,
    input [songwidth-1:0] song,
    output reg [15:0] songpos
    );
    wire [15:0] memory [songcount-1:0];
    
	always @(posedge clock)						
        songpos = memory[song];
    
    parameter ch14s1 = 570;
    parameter ch14s2 = 432;
    parameter ch14s3 = 422;
    
    assign memory[0] = 15'b0;
    assign memory[1] = ch14s1;
    assign memory[2] = ch14s1 + ch14s2;
    assign memory[3] = ch14s1 + ch14s2 + ch14s3;
endmodule

module lead2_pos_rom(
    input clock,
    input [songwidth-1:0] song,
    output reg [15:0] songpos
    );
    wire [15:0] memory [songcount-1:0];
    
	always @(posedge clock)						
        songpos = memory[song];
    
    parameter ch15s1 = 325;
    parameter ch15s2 = 280;
    parameter ch15s3 = 163;
    
    assign memory[0] = 15'b0;
    assign memory[1] = ch15s1;
    assign memory[2] = ch15s1 + ch15s2;
    assign memory[3] = ch15s1 + ch15s2 + ch15s3;
endmodule