`timescale 1ns / 1ps

module oneShot(
    input clk,
    input signal_in,
    output signal_out
    );
    reg r1, r2, r3;
    always @(posedge clk) begin
        r1 <= signal_in;
        r2 <= r1;
        r3 <= r2;
    end
    assign signal_out = ~r3 & r2;
endmodule

module debounce(
    input clk,
    input in,
    output reg out
    );
    reg xnew;
    reg [17:0] count;
    always @(posedge clk) begin
        if (xnew != in) begin
            count <= 18'd0;
            xnew <= in;
        end else if (count < 18'd100000) begin
            count <= count + 18'd1;
        end else begin
            out <= xnew;
        end
    end
endmodule