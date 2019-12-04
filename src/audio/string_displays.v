`timescale 1ps / 1ps

module string_display2(
    input [9:0] in,
    input clk2ms,
    output reg [2:0] pick,
    output reg [7:0] segs
    );

    reg [3:0] seg;
    wire [3:0] seg1, seg2, seg3;
    assign seg3 = in % 10;
    assign seg2 = in / 10 % 10;
    assign seg1 = in / 100;
    
    always @(posedge clk2ms) begin
        if (pick == 3'b001) begin
            pick <= 3'b010; seg <= seg2;
        end else if (pick == 3'b010) begin
            pick <= 3'b100; seg <= seg1;
        end else if (pick == 3'b100) begin
            pick <= 3'b001; seg <= seg3;
        end else begin
            pick <= 3'b001; seg <= seg3;
        end
    end
    always @(*) begin
        case (seg)
            4'h0:   segs = 8'b11111100;
            4'h1:   segs = 8'b01100000;
            4'h2:   segs = 8'b11011010;
            4'h3:   segs = 8'b11110010;
            4'h4:   segs = 8'b01100110;
            4'h5:   segs = 8'b10110110;
            4'h6:   segs = 8'b10111110;
            4'h7:   segs = 8'b11100000;
            4'h8:   segs = 8'b11111110;
            4'h9:   segs = 8'b11110110;
            4'hA:   segs = 8'b11101110;
            4'hB:   segs = 8'b00111110;
            4'hC:   segs = 8'b10011100;
            4'hD:   segs = 8'b01111010;
            4'hE:   segs = 8'b10011110;
            4'hF:   segs = 8'b10001110;
            default:segs = 8'b00000010;
        endcase
    end
endmodule

module string_display3(
    input [9:0] in,
    input clk2ms,
    output reg [2:0] pick,
    output reg [7:0] segs
    );

    reg [3:0] seg;
    wire [3:0] seg1, seg2, seg3;
    assign seg3 = in % 10;
    assign seg2 = in / 10 % 10;
    assign seg1 = in / 100;
    
    always @(posedge clk2ms) begin
        if (pick == 3'b001) begin
            pick <= 3'b010; seg <= seg2;
        end else if (pick == 3'b010) begin
            pick <= 3'b100; seg <= seg1;
        end else if (pick == 3'b100) begin
            pick <= 3'b001; seg <= seg3;
        end else begin
            pick <= 3'b001; seg <= seg3;
        end
    end
    always @(*) begin
        case (seg)
            4'h0:   segs[7:1] = 7'b1111110;
            4'h1:   segs[7:1] = 7'b0110000;
            4'h2:   segs[7:1] = 7'b1101101;
            4'h3:   segs[7:1] = 7'b1111001;
            4'h4:   segs[7:1] = 7'b0110011;
            4'h5:   segs[7:1] = 7'b1011011;
            4'h6:   segs[7:1] = 7'b1011111;
            4'h7:   segs[7:1] = 7'b1110000;
            4'h8:   segs[7:1] = 7'b1111111;
            4'h9:   segs[7:1] = 7'b1111011;
            4'hA:   segs[7:1] = 7'b1110111;
            4'hB:   segs[7:1] = 7'b0011111;
            4'hC:   segs[7:1] = 7'b1001110;
            4'hD:   segs[7:1] = 7'b0111101;
            4'hE:   segs[7:1] = 7'b1001111;
            4'hF:   segs[7:1] = 7'b1000111;
            default:segs[7:1] = 7'b0000001;
        endcase
        if (pick == 3'b001) begin
            segs[0] = 1'b0;
        end else if (pick == 3'b010) begin
            segs[0] = 1'b1;
        end else if (pick == 3'b100) begin
            segs[0] = 1'b0;
        end else begin
            segs[0] = 1'b0;
        end
    end
endmodule