`timescale 1ns / 1ps

module getpixel_songsel(
    input clk,
    input valid,
    input [1:0] song,
    input [9:0] h_cnt,
    input [9:0] v_cnt,
    output reg[3:0] r,
    output reg[3:0] g,
    output reg[3:0] b
    );
    wire songsel_type;
    wire [9:0] h_cnt_in, v_cnt_in;
    assign h_cnt_in = h_cnt-32;
    assign v_cnt_in = v_cnt-16;

    // FIXME incompatible port width
    hint_songsel_reader hints1(
        .clk            (clk),
        .x              (h_cnt_in[8:0]),
        .y              (v_cnt_in[4:0]),
        .songsel_type   (songsel_type)
        );

    always @(*) begin
        if (~valid) begin
            r = 4'h0;
            g = 4'h0;
            b = 4'h0;
        end else begin
            if  ((h_cnt >= 10'd112 && h_cnt < 10'd592 && v_cnt >= 10'd88 && v_cnt < 10'd424) && !(h_cnt >= 10'd117
                && h_cnt < 10'd587 && v_cnt >= 10'd93 && v_cnt < 10'd155) && !(h_cnt >= 10'd117&& h_cnt < 10'd587 
                && v_cnt >= 10'd181 && v_cnt < 10'd243) && !(h_cnt >= 10'd117&& h_cnt < 10'd587&& v_cnt >= 10'd269 
                && v_cnt < 10'd331) && !(h_cnt >= 10'd117&& h_cnt < 10'd587&& v_cnt >= 10'd357&& v_cnt < 10'd419)
                && !(h_cnt >=10'd112 && h_cnt <10'd592 && v_cnt>=10'd160 && v_cnt<10'd176) && !(h_cnt >=10'd112 &&
                h_cnt <10'd592 && v_cnt>=10'd248 && v_cnt<10'd264) && !(h_cnt >=10'd112 && h_cnt <10'd592 && 
                v_cnt>=10'd336 && v_cnt<10'd352)) begin
                r = 4'hf;
                g = 4'hf;
                b = 4'hf;
            end else if (h_cnt >= 64 && h_cnt < 90 && v_cnt >= 116 && v_cnt < 132 && song == 2'd3) begin
                r = 4'hf;
                g = 4'h0;
                b = 4'h0;
            end else if (h_cnt >= 64 && h_cnt < 90 && v_cnt >= 204 && v_cnt < 220 && song == 2'd2) begin
                r = 4'hf;
                g = 4'h0;
                b = 4'h0;
            end else if (h_cnt >= 64 && h_cnt < 90 && v_cnt >= 292 && v_cnt < 308 && song == 2'd1) begin
                r = 4'hf;
                g = 4'h0;
                b = 4'h0;
            end else if (h_cnt >= 64 && h_cnt < 90 && v_cnt >= 380 && v_cnt < 396 && song == 2'd0) begin
                r = 4'hf;
                g = 4'h0;
                b = 4'h0;
            end else if (h_cnt >= 10'd32 && h_cnt < 10'd405 && v_cnt >= 10'd16 && v_cnt < 10'd39) begin
                if (songsel_type == 1'b0) begin
                    r = 4'h0;
                    g = 4'h0;
                    b = 4'h0;
                end else begin
                    r = 4'hf;
                    g = 4'hf;
                    b = 4'hf;
                end
            end else begin
                r = 4'h0;
                g = 4'h0;
                b = 4'h0;
            end
          end
      end
endmodule
