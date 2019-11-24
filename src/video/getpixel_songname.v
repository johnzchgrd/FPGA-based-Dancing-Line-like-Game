`timescale 1ns / 1ps

module getpixel_songname(
    input clk,
    input valid,
    input [9:0] h_cnt,
    input [9:0] v_cnt,
    output reg[3:0] r,
    output reg[3:0] g,
    output reg[3:0] b
    );
    reg [1:0]color;//0 white;1 blue;2 green
    reg [4:0]character;
    wire font_type;
    reg [9:0]x;
    reg [4:0]y;
    
    wire [4:0] character1[34:0];
    assign character1[0]=5'd12;  assign character1[1]=5'd5;   assign character1[2]=5'd13;  assign character1[3]=5'd15;
    assign character1[4]=5'd14;  assign character1[5]=5'd0;   assign character1[6]=5'd0;   assign character1[7]=5'd0;
    assign character1[8]=5'd0;   assign character1[9]=5'd0;   assign character1[10]=5'd0;  assign character1[11]=5'd0;
    assign character1[12]=5'd0;  assign character1[13]=5'd0;  assign character1[14]=5'd0;  assign character1[15]=5'd0;
    assign character1[16]=5'd0;  assign character1[17]=5'd0;  assign character1[18]=5'd0;  assign character1[19]=5'd0;
    assign character1[20]=5'd0;  assign character1[21]=5'd0;  assign character1[22]=5'd0;  assign character1[23]=5'd0;
    assign character1[24]=5'd0;  assign character1[25]=5'd0;  assign character1[26]=5'd0;  assign character1[27]=5'd0;
    assign character1[28]=5'd0;  assign character1[29]=5'd0;  assign character1[30]=5'd0;  assign character1[31]=5'd0;
    assign character1[32]=5'd0;  assign character1[33]=5'd0;  assign character1[34]=5'd0;
    wire [4:0] character2[34:0];
    assign character2[0]=5'd13;  assign character2[1]=5'd1;   assign character2[2]=5'd14;  assign character2[3]=5'd7;
    assign character2[4]=5'd26;  assign character2[5]=5'd8;   assign character2[6]=5'd15;  assign character2[7]=5'd14;
    assign character2[8]=5'd7;   assign character2[9]=5'd0;   assign character2[10]=5'd0;  assign character2[11]=5'd0;
    assign character2[12]=5'd0;  assign character2[13]=5'd0;  assign character2[14]=5'd0;  assign character2[15]=5'd0;
    assign character2[16]=5'd0;  assign character2[17]=5'd0;  assign character2[18]=5'd0;  assign character2[19]=5'd0;
    assign character2[20]=5'd0;  assign character2[21]=5'd0;  assign character2[22]=5'd0;  assign character2[23]=5'd0;
    assign character2[24]=5'd0;  assign character2[25]=5'd0;  assign character2[26]=5'd0;  assign character2[27]=5'd0;
    assign character2[28]=5'd0;  assign character2[29]=5'd0;  assign character2[30]=5'd0;  assign character2[31]=5'd0;
    assign character2[32]=5'd0;  assign character2[33]=5'd0;  assign character2[34]=5'd0;
    wire [4:0] character3[34:0];
    assign character3[0]=5'd2;  assign character3[1]=5'd1;   assign character3[2]=5'd4;  assign character3[3]=5'd0;
    assign character3[4]=5'd1;  assign character3[5]=5'd16;   assign character3[6]=5'd16;   assign character3[7]=5'd12;
    assign character3[8]=5'd5;   assign character3[9]=5'd27;   assign character3[10]=5'd27;  assign character3[11]=5'd0;
    assign character3[12]=5'd0;  assign character3[13]=5'd0;  assign character3[14]=5'd0;  assign character3[15]=5'd0;
    assign character3[16]=5'd0;  assign character3[17]=5'd0;  assign character3[18]=5'd0;  assign character3[19]=5'd0;
    assign character3[20]=5'd0;  assign character3[21]=5'd0;  assign character3[22]=5'd0;  assign character3[23]=5'd0;
    assign character3[24]=5'd0;  assign character3[25]=5'd0;  assign character3[26]=5'd0;  assign character3[27]=5'd0;
    assign character3[28]=5'd0;  assign character3[29]=5'd0;  assign character3[30]=5'd0;  assign character3[31]=5'd0;
    assign character3[32]=5'd0;  assign character3[33]=5'd0;  assign character3[34]=5'd0;
    wire [4:0] character4[34:0];
    assign character4[0]=5'd9;  assign character4[1]=5'd23;   assign character4[2]=5'd1;  assign character4[3]=5'd19;
    assign character4[4]=5'd8;  assign character4[5]=5'd9;   assign character4[6]=5'd0;   assign character4[7]=5'd7;
    assign character4[8]=5'd1;   assign character4[9]=5'd0;   assign character4[10]=5'd20;  assign character4[11]=5'd19;
    assign character4[12]=5'd21;  assign character4[13]=5'd3;  assign character4[14]=5'd8;  assign character4[15]=5'd9;
    assign character4[16]=5'd0;  assign character4[17]=5'd11;  assign character4[18]=5'd1;  assign character4[19]=5'd18;
    assign character4[20]=5'd1;  assign character4[21]=5'd0;  assign character4[22]=5'd8;  assign character4[23]=5'd1;
    assign character4[24]=5'd5;  assign character4[25]=5'd20;  assign character4[26]=5'd5;  assign character4[27]=5'd11;
    assign character4[28]=5'd21;  assign character4[29]=5'd18;  assign character4[30]=5'd21;  assign character4[31]=5'd13;
    assign character4[32]=5'd0;  assign character4[33]=5'd4;  assign character4[34]=5'd1;
    wire [4:0] speed1[12:0];
    assign speed1[0]=5'd19;  assign speed1[1]=5'd16;   assign speed1[2]=5'd5;  assign speed1[3]=5'd5;
    assign speed1[4]=5'd4;  assign speed1[5]=5'd0;   assign speed1[6]=5'd0;   assign speed1[7]=5'd19;
    assign speed1[8]=5'd12;   assign speed1[9]=5'd15;   assign speed1[10]=5'd23;  assign speed1[11]=5'd0;
    assign speed1[12]=5'd0; 
    wire [4:0] speed2[12:0];
    assign speed2[0]=5'd19;  assign speed2[1]=5'd16;   assign speed2[2]=5'd5;  assign speed2[3]=5'd5;
    assign speed2[4]=5'd4;  assign speed2[5]=5'd0;   assign speed2[6]=5'd0;   assign speed2[7]=5'd14;
    assign speed2[8]=5'd15;   assign speed2[9]=5'd18;   assign speed2[10]=5'd13;  assign speed2[11]=5'd1;
    assign speed2[12]=5'd12; 
    wire [4:0] speed3[12:0];
    assign speed3[0]=5'd19;  assign speed3[1]=5'd16;   assign speed3[2]=5'd5;  assign speed3[3]=5'd5;
    assign speed3[4]=5'd4;  assign speed3[5]=5'd0;   assign speed3[6]=5'd0;   assign speed3[7]=5'd6;
    assign speed3[8]=5'd1;   assign speed3[9]=5'd19;   assign speed3[10]=5'd20;  assign speed3[11]=5'd0;
    assign speed3[12]=5'd0; 
    wire [4:0] speed4[12:0];
    assign speed4[0]=5'd19;  assign speed4[1]=5'd16;   assign speed4[2]=5'd5;  assign speed4[3]=5'd5;
    assign speed4[4]=5'd4;  assign speed4[5]=5'd0;   assign speed4[6]=5'd0;   assign speed4[7]=5'd6;
    assign speed4[8]=5'd1;   assign speed4[9]=5'd19;   assign speed4[10]=5'd20;  assign speed4[11]=5'd0;
    assign speed4[12]=5'd0; 
    wire [4:0] difficulty1[17:0];
    assign difficulty1[0]=5'd4;  assign difficulty1[1]=5'd9;   assign difficulty1[2]=5'd6;  assign difficulty1[3]=5'd6;
    assign difficulty1[4]=5'd9;  assign difficulty1[5]=5'd3;   assign difficulty1[6]=5'd21;   assign difficulty1[7]=5'd12;
    assign difficulty1[8]=5'd20;   assign difficulty1[9]=5'd25;   assign difficulty1[10]=5'd0;  assign difficulty1[11]=5'd0;
    assign difficulty1[12]=5'd14;  assign difficulty1[13]=5'd15;  assign difficulty1[14]=5'd18;  assign difficulty1[15]=5'd13;
    assign difficulty1[16]=5'd1;  assign difficulty1[17]=5'd12;
    wire [4:0] difficulty2[17:0];
    assign difficulty2[0]=5'd4;  assign difficulty2[1]=5'd9;   assign difficulty2[2]=5'd6;  assign difficulty2[3]=5'd6;
    assign difficulty2[4]=5'd9;  assign difficulty2[5]=5'd3;   assign difficulty2[6]=5'd21;   assign difficulty2[7]=5'd12;
    assign difficulty2[8]=5'd20;   assign difficulty2[9]=5'd25;   assign difficulty2[10]=5'd0;  assign difficulty2[11]=5'd0;
    assign difficulty2[12]=5'd5;  assign difficulty2[13]=5'd1;  assign difficulty2[14]=5'd19;  assign difficulty2[15]=5'd25;
    assign difficulty2[16]=5'd0;  assign difficulty2[17]=5'd0;
    wire [4:0] difficulty3[17:0];
    assign difficulty3[0]=5'd4;  assign difficulty3[1]=5'd9;   assign difficulty3[2]=5'd6;  assign difficulty3[3]=5'd6;
    assign difficulty3[4]=5'd9;  assign difficulty3[5]=5'd3;   assign difficulty3[6]=5'd21;   assign difficulty3[7]=5'd12;
    assign difficulty3[8]=5'd20;   assign difficulty3[9]=5'd25;   assign difficulty3[10]=5'd0;  assign difficulty3[11]=5'd0;
    assign difficulty3[12]=5'd8;  assign difficulty3[13]=5'd1;  assign difficulty3[14]=5'd18;  assign difficulty3[15]=5'd4;
    assign difficulty3[16]=5'd0;  assign difficulty3[17]=5'd0;
    wire [4:0] difficulty4[17:0];
    assign difficulty4[0]=5'd4;  assign difficulty4[1]=5'd9;   assign difficulty4[2]=5'd6;  assign difficulty4[3]=5'd6;
    assign difficulty4[4]=5'd9;  assign difficulty4[5]=5'd3;   assign difficulty4[6]=5'd21;   assign difficulty4[7]=5'd12;
    assign difficulty4[8]=5'd20;   assign difficulty4[9]=5'd25;   assign difficulty4[10]=5'd0;  assign difficulty4[11]=5'd0;
    assign difficulty4[12]=5'd8;  assign difficulty4[13]=5'd1;  assign difficulty4[14]=5'd18;  assign difficulty4[15]=5'd4;
    assign difficulty4[16]=5'd0;  assign difficulty4[17]=5'd0;
    
    always @(*) begin
        if (~valid) begin
            r = 4'h0;
            g = 4'h0;
            b = 4'h0;
        end else if (h_cnt >= 10'd128 && h_cnt < 10'd548 && v_cnt >= 10'd104 && v_cnt < 10'd122) begin
            character = character1[(h_cnt-128)/12];
            x = (h_cnt-128) % 12;
            y = v_cnt - 104;
            color = 2'd0;
        end else if(h_cnt >= 10'd128 && h_cnt < 10'd548 && v_cnt >= 10'd192 && v_cnt < 10'd210) begin
            character = character2[(h_cnt-128)/12];
            x = (h_cnt-128) % 12;
            y = v_cnt - 192;
            color = 2'd0;
        end else if(h_cnt >= 10'd128 && h_cnt < 10'd548 && v_cnt >= 10'd280 && v_cnt < 10'd298) begin
            character = character3[(h_cnt-128)/12];
            x = (h_cnt-128) % 12;
            y = v_cnt - 280;
            color = 2'd0;
        end else if(h_cnt >= 10'd128 && h_cnt < 10'd548 && v_cnt >= 10'd368 && v_cnt < 10'd386) begin
            character = character4[(h_cnt-128)/12];
            x = (h_cnt-128) % 12;
            y = v_cnt - 368;
            color = 2'd0;
        end else if(h_cnt >= 10'd128 && h_cnt < 10'd284 && v_cnt >= 10'd128 && v_cnt < 10'd146) begin
            character = speed1[(h_cnt-128)/12];
            x = (h_cnt-128) % 12;
            y = v_cnt - 128;
            color = 2'd1;
        end else if(h_cnt >= 10'd128 && h_cnt < 10'd284 && v_cnt >= 10'd216 && v_cnt < 10'd234) begin
            character = speed2[(h_cnt-128)/12];
            x = (h_cnt-128) % 12;
            y = v_cnt - 216;
            color = 2'd1;
        end else if(h_cnt >= 10'd128 && h_cnt < 10'd284 && v_cnt >= 10'd304 && v_cnt < 10'd322) begin
            character = speed3[(h_cnt-128)/12];
            x = (h_cnt-128) % 12;
            y = v_cnt - 304;
            color = 2'd1;
        end else if(h_cnt >= 10'd128 && h_cnt < 10'd284 && v_cnt >= 10'd392 && v_cnt < 10'd410) begin
            character = speed4[(h_cnt-128)/12];
            x = (h_cnt-128) % 12;
            y = v_cnt - 392;
            color = 2'd1;
        end else if(h_cnt >= 10'd360 && h_cnt < 10'd576 && v_cnt >= 10'd128 && v_cnt < 10'd146) begin
            character = difficulty1[(h_cnt-360)/12];
            x = (h_cnt-360) % 12;
            y = v_cnt - 128;
            color = 2'd2;
        end else if(h_cnt >= 10'd360 && h_cnt < 10'd576 && v_cnt >= 10'd216 && v_cnt < 10'd234) begin
            character = difficulty2[(h_cnt-360)/12];
            x = (h_cnt-360) % 12;
            y = v_cnt - 216;
            color = 2'd2;
        end else if(h_cnt >= 10'd360 && h_cnt < 10'd576 && v_cnt >= 10'd304 && v_cnt < 10'd322) begin
            character = difficulty3[(h_cnt-360)/12];
            x = (h_cnt-360) % 12;
            y = v_cnt - 304; 
            color = 2'd2;  
        end else if(h_cnt >= 10'd360 && h_cnt < 10'd576 && v_cnt >= 10'd392 && v_cnt < 10'd410) begin
            character = difficulty4[(h_cnt-360)/12];
            x = (h_cnt-360) % 12;
            y = v_cnt - 392;
            color = 2'd2;    
        end else begin
            character = 5'd0;
            x = 10'd0;
            y = 10'd0;
            color = 2'd0;
        end
          
        if(font_type == 1'b0)begin
            r = 4'h0;
            g = 4'h0;
            b = 4'h0;
        end else begin
            case(color)
                2'd0:begin 
                        r = 4'hf;
                        g = 4'hf;
                        b = 4'hf;
                     end
                2'd1:begin 
                        r = 4'h0;
                        g = 4'h7;
                        b = 4'hf;
                     end
                2'd2:begin 
                        r = 4'h0;
                        g = 4'hf;
                        b = 4'h0;
                     end
                default:begin
                        r = 4'h0;
                        g = 4'h0;
                        b = 4'h0;
                     end
             endcase
        end

    end
    
    hint_font_rom hf1(
        .valid          (valid), 
        .character      (character),
        .x              (x),
        .y              (y),
        .font_type      (font_type)
        );
        

endmodule

