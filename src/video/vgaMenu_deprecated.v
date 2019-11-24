`timescale 1ns / 1ps

module vgaMenu(
    input clk,
    input enabled,
    input reset,
    input [2:0] main_state,
    input [1:0] times,
    input [9:0] h_cnt,v_cnt,
    output reg [3:0] r, g, b
);
    wire isFont;
    wire [6:0] x, y;
    assign x = h_cnt / 8;
    assign y = v_cnt / 24;
    
    vga_menu_rom vmr(clk, enabled, main_state, x, y, isFont);
    
    always@(posedge clk or posedge reset)begin
        if(reset || enabled)begin
            r <= 4'b0000;
            g <= 4'b0000;
            b <= 4'b0000;
        end else begin
            case(times)
                0:begin
                    if(isFont)begin
                        r <= 4'b0000;
                        g <= 4'b1111;
                        b <= 4'b1111;
                    end else begin
                        r <= 4'b1111;
                        g <= 4'b1111;
                        b <= 4'b0000;
                    end
                end
                1:begin
                    if(isFont)begin
                        r <= 4'b0000;
                        g <= 4'b1111;
                        b <= 4'b0000;
                    end else begin
                        r <= 4'b0000;
                        g <= 4'b0000;
                        b <= 4'b1111;
                    end
                end
                2:begin
                    if(isFont)begin
                        r <= 4'b1111;
                        g <= 4'b0000;
                        b <= 4'b0000;
                    end else begin
                        r <= 4'b1111;
                        g <= 4'b0000;
                        b <= 4'b1111;
                    end
                end
                3:begin
                    if(isFont)begin
                        r <= 4'b0000;
                        g <= 4'b0000;
                        b <= 4'b1111;
                    end else begin
                        r <= 4'b0000;
                        g <= 4'b1111;
                        b <= 4'b1111;
                    end
                end
            endcase
        end
    end
    
endmodule