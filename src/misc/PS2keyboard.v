`timescale 1ns / 1ps

module PS2keyboard(
    input reset,ps2_clk,ps2_data,clk,
    output vk_left, vk_check, vk_right, vk_up, vk_down,
    output reg [7:0]data //for debug usage.
    );
    reg [7:0] key;
    reg [7:0] debug;
    reg [3:0] state;
    reg [2:0] t_state;
    reg newdata;
    reg newdata2a, newdata2b;
    reg newdata2;
    reg [7:0] temp_data;
    parameter s_start=0,s_0=1,s_1=2,s_2=3,s_3=4,s_4=5,s_5=6,s_6=7,s_7=8,s_parity=9,s_stop=10;
    parameter t_start=0,t_judge=1,t_release=2,t_press=3,t_code=4,t_debug = 5;

    always@(posedge clk or posedge reset)begin
            newdata2a <= newdata;
            newdata2b <= newdata2a;
            newdata2 = ~newdata2b & newdata2a;
            debug[2:0] <= t_state;
            if(reset)begin
            t_state=t_start;
            end else begin 
            case (t_state)
                t_start:begin if(newdata2) t_state <= t_judge;else t_state <= t_start; end
                t_judge:begin if(data==8'b11111000) t_state <= t_release; else t_state<=t_press; end
                t_release:begin if(newdata2) t_state<=t_code; else t_state<=t_release; end
                t_code:begin t_state<=t_start; debug[7:3] = 5'b00000;
                end
                t_press:begin t_state<=t_start;
                    case(data)
                        // 8'b00110101:begin debug[7:3] <= 5'b10000;end     //4 ��һ�׸�  
                        8'b00111010:begin debug[7:3] <= 5'b10000;end     //8
                        8'b00111001:begin debug[7:3] <= 5'b01000;end    //5 ת��
                        // 8'b10111010:begin debug[7:3] <= 5'b00100;end    //6 ��һ�׸�
                        8'b10111001:begin debug[7:3] <= 5'b00100;end    // 2
                        8'b00111110:begin debug[7:3] <= 5'b00010;end   // �� ��������
                        8'b10100111:begin debug[7:3] <= 5'b00001;end  //  �� ��������
                    endcase
                end
                //t_debug: begin if(newdata2) t_state <= t_code; else begin t_state <= t_debug; key <= key + 8'd1; end end
                default: t_state<=t_start;
            endcase
        end
    end


    always@(posedge ps2_clk or posedge reset )begin
        if(reset)begin
            temp_data<=8'b11111111;
            state=s_start;
        end else begin 
            case(state)
                s_start:begin state<=s_0;end
                s_0:begin temp_data[0]<=ps2_data;state<=s_1;end
                s_1:begin temp_data[1]<=ps2_data;state<=s_2;end
                s_2:begin temp_data[2]<=ps2_data;state<=s_3;end
                s_3:begin temp_data[3]<=ps2_data;state<=s_4;end
                s_4:begin temp_data[4]<=ps2_data;state<=s_5;end
                s_5:begin temp_data[5]<=ps2_data;state<=s_6;end
                s_6:begin temp_data[6]<=ps2_data;state<=s_7;end
                s_7:begin temp_data[7]<=ps2_data;state<=s_parity;end
                s_parity:begin state<=s_stop; data<=temp_data; newdata = 1;end
                s_stop:begin newdata=0; if (~ps2_data) begin state<=s_start;end else state <= s_stop; end
                default:begin state<=s_start;end
            endcase
        end
    end

    always@(*)begin
        key<=debug;
    end

    assign vk_left  = key[7];
    assign vk_check = key[6];
    assign vk_right = key[5];
    assign vk_up    = key[4];
    assign vk_down  = key[3];
    
endmodule