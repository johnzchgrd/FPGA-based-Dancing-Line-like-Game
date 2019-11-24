`timescale 1ns / 1ps

module vga_menu_rom(
    input  clk,
    input enabled,
    input [2:0] menu,
    input [6:0] x,
    input [6:0] y,
    output reg block_type
    );
    
    always@(*)begin
        block_type = 1'b0;
    end
    
endmodule
