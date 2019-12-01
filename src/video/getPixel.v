`timescale 1ns / 1ps

module getPixel(
    input clk,
    input hclk,
    input reset,
    input valid,
    input [1:0] song,
    input type,
    input press,
    input [9:0] progress,
    input [4:0] x, y,
    input [9:0] h_cnt, v_cnt,
    input [15:0] head_x, head_y,
    input [15:0] scroll_x_in, scroll_y_in,
    input tips_display,
    input tips_display_over,
    output reg[3:0] r,
    output reg[3:0] g,
    output reg[3:0] b
    );

    wire [11:0]imgout;
    
    wire [4:0] prog_y;
    wire [4:0] progdot_x;
    wire [4:0] prog1_x, prog2_x, prog3_x, progper_x;
    wire [1:0] prog1_type, prog2_type, progdot_type, prog3_type, progper_type;
    
    assign prog_y = (v_cnt>=16 && v_cnt<40) ? v_cnt-16 : 0;
    assign prog1_x = (h_cnt>=538 && h_cnt<556) ? h_cnt-538 : 0;
    assign prog2_x = (h_cnt>=556 && h_cnt<574) ? h_cnt-556 : 0;
    assign progdot_x = (h_cnt>=574 && h_cnt<582) ? h_cnt-574 : 0;
    assign prog3_x = (h_cnt>=582 && h_cnt<600) ? h_cnt-582 : 0;
    assign progper_x = (h_cnt>=600 && h_cnt<624) ? h_cnt-600 : 0;
    
    wire validdot, validnum;
    assign validnum = ((h_cnt>=538 && h_cnt<574) || (h_cnt>=582 && h_cnt<600)) && (v_cnt >= 10'd16 && v_cnt < 10'd40) && valid;
    assign validdot = ((h_cnt>=574 && h_cnt<582) || (h_cnt>=600 && h_cnt<624)) && (v_cnt >= 10'd16 && v_cnt < 10'd40) && valid;
    
    image_reader imager(
        .clk(clk), .valid(valid), .type(type), .song(song), .x(x), .y(y), .dout(imgout)
        );
    number_rom numr(
        .valid(validnum), .progress(progress), 
        .x1(prog1_x), .x2(prog2_x), .x3(prog3_x), .y(prog_y), 
        .ui_pixel_type1(prog1_type), .ui_pixel_type2(prog2_type), .ui_pixel_type3(prog3_type)
        );
    dotper_rom dotr(
        .valid(validdot), .x1(progdot_x), .x2(progper_x), .y(prog_y),
        .ui_pixel_type1(progdot_type), .ui_pixel_type2(progper_type)
        );
    
    //line body implementation start
    reg [15:0] x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15;
    reg [15:0] y0, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15;
    wire isbody;
    parameter BodyWidth = 7;
    parameter BodyHeight = 7;
    parameter start_x = 336;
    parameter start_y = 240;
    wire [15:0] scroll_x,scroll_y;
    assign scroll_x = scroll_x_in - 1;
    assign scroll_y = scroll_y_in - 1;
   //* ***********************************************************************************************************/
    reg [4:0]character;
    reg [9:0]x_tips;
    reg [4:0]y_tips;
    wire [4:0] tips[31:0];
    wire [4:0] tips_over[31:0];
    wire font_type_tips;
    assign tips[0]=5'd28;  assign tips[1]=5'd0;   assign tips[2]=5'd20;  assign tips[3]=5'd15;
    assign tips[4]=5'd0;  assign tips[5]=5'd20;   assign tips[6]=5'd21;   assign tips[7]=5'd18;
    assign tips[8]=5'd14;   assign tips[9]=5'd0;   assign tips[10]=5'd1;  assign tips[11]=5'd0;
    assign tips[12]=5'd3;  assign tips[13]=5'd15;  assign tips[14]=5'd18;  assign tips[15]=5'd14;
    assign tips[16]=5'd5;  assign tips[17]=5'd18;  assign tips[18]=5'd0;  assign tips[19]=5'd0;
    assign tips[20]=5'd29;  assign tips[21]=5'd0;  assign tips[22]=5'd20;  assign tips[23]=5'd15;
    assign tips[24]=5'd0;  assign tips[25]=5'd18;  assign tips[26]=5'd5;  assign tips[27]=5'd19;
    assign tips[28]=5'd20;  assign tips[29]=5'd1;  assign tips[30]=5'd18;  assign tips[31]=5'd20;
   
    assign tips_over[0]=5'd7;  assign tips_over[1]=5'd1;   assign tips_over[2]=5'd13;  assign tips_over[3]=5'd5;
    assign tips_over[4]=5'd0;  assign tips_over[5]=5'd15;   assign tips_over[6]=5'd22;   assign tips_over[7]=5'd5;
    assign tips_over[8]=5'd18;   assign tips_over[9]=5'd27;   assign tips_over[10]=5'd0;  assign tips_over[11]=5'd0;
    assign tips_over[12]=5'd29;  assign tips_over[13]=5'd0;  assign tips_over[14]=5'd20;  assign tips_over[15]=5'd15;
    assign tips_over[16]=5'd0;  assign tips_over[17]=5'd18;  assign tips_over[18]=5'd5;  assign tips_over[19]=5'd19;
    assign tips_over[20]=5'd1;  assign tips_over[21]=5'd18;  assign tips_over[22]=5'd20;  assign tips_over[23]=5'd0;
    assign tips_over[24]=5'd0;  assign tips_over[25]=5'd0;  assign tips_over[26]=5'd0;  assign tips_over[27]=5'd0;
    assign tips_over[28]=5'd0;  assign tips_over[29]=5'd0;  assign tips_over[30]=5'd0;  assign tips_over[31]=5'd0;

    //*********************************************************************************************************
    
    // judge body
    assign isbody = 
    ((h_cnt+scroll_x)>=(x0-BodyWidth)&&(h_cnt+scroll_x)<=(head_x+BodyWidth)&&(v_cnt+scroll_y)>=(y0-BodyWidth)&&(v_cnt+scroll_y)<=(head_y+BodyWidth))||
    ((h_cnt+scroll_x)>=(x1-BodyWidth)&&(h_cnt+scroll_x)<=(x0+BodyWidth)&&(v_cnt+scroll_y)>=(y1-BodyHeight)&&(v_cnt+scroll_y)<=(y0+BodyHeight))||
    ((h_cnt+scroll_x)>=(x2-BodyWidth)&&(h_cnt+scroll_x)<=(x1+BodyWidth)&&(v_cnt+scroll_y)>=(y2-BodyHeight)&&(v_cnt+scroll_y)<=(y1+BodyHeight))||
    ((h_cnt+scroll_x)>=(x3-BodyWidth)&&(h_cnt+scroll_x)<=(x2+BodyWidth)&&(v_cnt+scroll_y)>=(y3-BodyHeight)&&(v_cnt+scroll_y)<=(y2+BodyHeight))||
    ((h_cnt+scroll_x)>=(x4-BodyWidth)&&(h_cnt+scroll_x)<=(x3+BodyWidth)&&(v_cnt+scroll_y)>=(y4-BodyHeight)&&(v_cnt+scroll_y)<=(y3+BodyHeight))||
    ((h_cnt+scroll_x)>=(x5-BodyWidth)&&(h_cnt+scroll_x)<=(x4+BodyWidth)&&(v_cnt+scroll_y)>=(y5-BodyHeight)&&(v_cnt+scroll_y)<=(y4+BodyHeight))||
    ((h_cnt+scroll_x)>=(x6-BodyWidth)&&(h_cnt+scroll_x)<=(x5+BodyWidth)&&(v_cnt+scroll_y)>=(y6-BodyHeight)&&(v_cnt+scroll_y)<=(y5+BodyHeight))||
    ((h_cnt+scroll_x)>=(x7-BodyWidth)&&(h_cnt+scroll_x)<=(x6+BodyWidth)&&(v_cnt+scroll_y)>=(y7-BodyHeight)&&(v_cnt+scroll_y)<=(y6+BodyHeight))||
    ((h_cnt+scroll_x)>=(x8-BodyWidth)&&(h_cnt+scroll_x)<=(x7+BodyWidth)&&(v_cnt+scroll_y)>=(y8-BodyHeight)&&(v_cnt+scroll_y)<=(y7+BodyHeight))||
    ((h_cnt+scroll_x)>=(x9-BodyWidth)&&(h_cnt+scroll_x)<=(x8+BodyWidth)&&(v_cnt+scroll_y)>=(y9-BodyHeight)&&(v_cnt+scroll_y)<=(y8+BodyHeight))||
    ((h_cnt+scroll_x)>=(x10-BodyWidth)&&(h_cnt+scroll_x)<=(x9+BodyWidth)&&(v_cnt+scroll_y)>=(y10-BodyHeight)&&(v_cnt+scroll_y)<=(y9+BodyHeight))||
    ((h_cnt+scroll_x)>=(x11-BodyWidth)&&(h_cnt+scroll_x)<=(x10+BodyWidth)&&(v_cnt+scroll_y)>=(y11-BodyHeight)&&(v_cnt+scroll_y)<=(y10+BodyHeight))||
    ((h_cnt+scroll_x)>=(x12-BodyWidth)&&(h_cnt+scroll_x)<=(x11+BodyWidth)&&(v_cnt+scroll_y)>=(y12-BodyHeight)&&(v_cnt+scroll_y)<=(y11+BodyHeight))||
    ((h_cnt+scroll_x)>=(x13-BodyWidth)&&(h_cnt+scroll_x)<=(x12+BodyWidth)&&(v_cnt+scroll_y)>=(y13-BodyHeight)&&(v_cnt+scroll_y)<=(y12+BodyHeight))||
    ((h_cnt+scroll_x)>=(x14-BodyWidth)&&(h_cnt+scroll_x)<=(x13+BodyWidth)&&(v_cnt+scroll_y)>=(y14-BodyHeight)&&(v_cnt+scroll_y)<=(y13+BodyHeight))||
    ((h_cnt+scroll_x)>=(x15-BodyWidth)&&(h_cnt+scroll_x)<=(x14+BodyWidth)&&(v_cnt+scroll_y)>=(y15-BodyHeight)&&(v_cnt+scroll_y)<=(y14+BodyHeight));
    
    always@(posedge hclk or posedge reset)begin
        if(reset)begin
            x0 <= start_x;x1 <= start_x;x2 <= start_x;x3 <= start_x;x4 <= start_x;
            x5 <= start_x;x6 <= start_x;x7 <= start_x;x8 <= start_x;x9 <= start_x;
            x10 <= start_x;x11 <= start_x;x12 <= start_x;x13 <= start_x;x14 <= start_x;
            x15 <= start_x;
            y0 <= start_y;y1 <= start_y;y2 <= start_y;y3 <= start_y;y4 <= start_y;
            y5 <= start_y;y6 <= start_y;y7 <= start_y;y8 <= start_y;y9 <= start_y;
            y10 <= start_y;y11 <= start_y;y12 <= start_y;y13 <= start_y;y14 <= start_y;
            y15 <= start_y;
        end else if (press) begin
            x0 <= head_x;y0 <= head_y;
            x1 <= x0;y1 <= y0;x2 <= x1;y2 <= y1;x3 <= x2;y3 <= y2;x4 <= x3;y4 <= y3;
            x5 <= x4;y5 <= y4;x6 <= x5;y6 <= y5;x7 <= x6;y7 <= y6;x8 <= x7;y8 <= y7;
            x9 <= x8;y9 <= y8;x10 <= x9;y10 <= y9;x11 <= x10;y11 <= y10;x12 <= x11;y12 <= y11;
            x13 <= x12;y13 <= y12;x14 <= x13;y14 <= y13;x15 <= x14;y15 <= y14;
        end
    end
    //line body implementation end
    
    always @(*) begin
        if (~valid) begin
            r = 4'h0;
            g = 4'h0;
            b = 4'h0;
        end else begin
            if (h_cnt >= 10'd313 && h_cnt <= 10'd327 && v_cnt >= 10'd233 && v_cnt <= 10'd247) begin
                // line head
                r = 4'hf;
                g = 4'h0;
                b = 4'h0;
            end else if(isbody) begin
                // line body
                r = 4'hf;
                g = 4'h0;
                b = 4'h0; 
            end else if (h_cnt >= 10'd538 && h_cnt < 10'd556 && v_cnt >= 10'd16 && v_cnt < 10'd40) begin
                if (prog1_type == 2'b00) begin
                    r = imgout[11:8];
                    g = imgout[7:4];
                    b = imgout[3:0];
                end else if (prog1_type[1] == 1'b0) begin
                    r = 4'h0;
                    g = 4'h0;
                    b = 4'h0;
                end else begin
                    r = 4'hf;
                    g = 4'hf;
                    b = 4'hf;
                end
            end else if(h_cnt >= 10'd556 && h_cnt < 10'd574 && v_cnt >= 10'd16 && v_cnt < 10'd40) begin
                if (prog2_type == 2'b00) begin
                    r = imgout[11:8];
                    g = imgout[7:4];
                    b = imgout[3:0];
                end else if (prog2_type[1] == 1'b0) begin
                    r = 4'h0;
                    g = 4'h0;
                    b = 4'h0;
                end else begin
                    r = 4'hf;
                    g = 4'hf;
                    b = 4'hf;
                end
            end else if(h_cnt >= 10'd574 && h_cnt < 10'd582 && v_cnt >= 10'd16 && v_cnt < 10'd40) begin
                if (progdot_type == 2'b00) begin
                    r = imgout[11:8];
                    g = imgout[7:4];
                    b = imgout[3:0];
                end else if (progdot_type[1] == 1'b0) begin
                    r = 4'h0;
                    g = 4'h0;
                    b = 4'h0;
                end else begin
                    r = 4'hf;
                    g = 4'hf;
                    b = 4'hf;
                end
            end else if(h_cnt >= 10'd582 && h_cnt < 10'd600 && v_cnt >= 10'd16 && v_cnt < 10'd40) begin   
                if (prog3_type == 2'b00) begin   
                    r = imgout[11:8];
                    g = imgout[7:4];
                    b = imgout[3:0];
                end else if (prog3_type[1] == 1'b0) begin
                    r = 4'h0;
                    g = 4'h0;
                    b = 4'h0;
                end else begin
                    r = 4'hf;
                    g = 4'hf;
                    b = 4'hf;
                end   
            end else if(h_cnt >= 10'd600 && h_cnt < 10'd624 && v_cnt >= 10'd16 && v_cnt < 10'd40) begin
                if (progper_type == 2'b00) begin   
                     r = imgout[11:8];
                     g = imgout[7:4];
                     b = imgout[3:0];
                end else if (progper_type[1] == 1'b0) begin
                    r = 4'h0;
                    g = 4'h0;
                    b = 4'h0;
                end else begin
                    r = 4'hf;
                    g = 4'hf;
                    b = 4'hf;
                end 
//*******************************************************************************************************************************
            end else if(h_cnt >= 10'd48 && h_cnt < 10'd432 && v_cnt >= 10'd448 && v_cnt < 10'd466)begin
                character = (tips_display_over==1)?tips_over[(h_cnt-48)/12]:tips[(h_cnt-48)/12];
                x_tips = (h_cnt-48) % 12; 
                y_tips = v_cnt - 448;                
                if(font_type_tips && (tips_display | tips_display_over))begin
                    r = 4'hf;
                    g = 4'hf;
                    b = 4'hf;
                end else begin
                    r = imgout[11:8];
                    g = imgout[7:4];
                    b = imgout[3:0];
                end
            end else begin
                r = imgout[11:8];
                g = imgout[7:4];
                b = imgout[3:0];
            end 
        end
    end
    hint_font_reader hf2(
        .clk            (clk),
        .character      (character),
        .x              (x_tips),
        .y              (y_tips),
        .font_type      (font_type_tips)
        );      
//************************************************************************************************************************
endmodule
