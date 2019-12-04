`timescale 1ns / 1ps

module fre_div 
    #(
        parameter n=100000000
    )
    (
        input clk_in, reset,
        output reg clk_out
    );
    reg [30:0] cnt;
    always @(posedge clk_in or posedge reset) begin
        if(reset) begin
            cnt <= 0;
            clk_out <= 1'b1;
        end else if(cnt == n/2-1) begin
            cnt <= 0;
            clk_out <= ~clk_out;
        end else begin
            cnt <= cnt + 1;
        end
    end
endmodule
