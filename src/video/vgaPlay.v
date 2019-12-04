`timescale 1ns / 1ps

module vgaPlay(
    input        	 clk,
    input        	 reset_raw,
    input            play_signal,
    input [2:0]      speed,
    input [1:0]      song,
    input            debug_switch,
    input            press_raw,
    input            tips_display,
	output       	 hsync,
    output       	 vsync,
    output           valid,
    output [3:0]     r,
    output [3:0]     g,
    output [3:0]     b,
    output           failed,
    output reg [9:0] progress,
    output [2:0]     debug,
    output [9:0]     h_cnt, v_cnt,
	output reg       song_done
    );	
		   
	wire 		 	clk_25MHz;
	wire            hclk;
    reg             reset;
    always@(posedge clk) begin
        reset <= reset_raw;
    end
	
	reg  [ 9:0]   	map_addr;
	reg  [39:0]   	map_data;
	wire [39:0]   	dout;
					
	reg 			block_cnt_h;
	reg [16:0]      head_x_raw,head_y_raw;
	reg [15:0]      head_x, head_y;
	reg             direction;
    wire            tips_over;
	
	fre_div#(4) cd25M (
        .clk_in 	(clk),
        .clk_out	(clk_25MHz), 
        .reset   	(reset)
		);
    
	fre_div#(1562500) cd128(
        .clk_in     (clk), 
        .reset      (reset), 
        .clk_out    (hclk)
        );
	// generate hsync & vsync
	vga_640x480 syncGEN (
		.pclk 		(clk_25MHz), 
		.reset		(reset), 
		.hsync		(hsync), 
		.vsync		(vsync), 
		.valid		(valid), 
		.h_cnt		(h_cnt), 
		.v_cnt		(v_cnt)
		);
	
	wire [15:0] scroll_x, scroll_y;
	wire [9:0] scroll_block_x, scroll_block_y;
    wire [10:0] refer_x, refer_y;
	wire [4:0] block_pixel_x, block_pixel_y;
	reg  [9:0] map_height;

	assign scroll_x = head_x - 319;
	assign scroll_y = head_y - 239;
	
	always @(*) begin
	   case (song)
	       2'b00: map_height = 10'd743;
	       2'b01: map_height = 10'd625;
	       2'b10: map_height = 10'd404;
	       2'b11: map_height = 10'd383;
	       default: map_height = 10'd233;
	   endcase
	end
	
	wire vclk;
	assign vclk = ~vsync;
	always@(posedge vclk) begin
        head_x = head_x_raw[16:1];
        head_y = head_y_raw[16:1];
	end
	
	wire press;
	wire playing;
	reg [1:0] play_state, play_state_next;
	parameter PLAY_STATE_NOTPLAYING = 0, 
              PLAY_STATE_PLAYING    = 1, 
              PLAY_STATE_PAUSED     = 2, 
              PLAY_STATE_STOPPED    = 3;
    //
    // â”?â”?â”? PLAY FSM â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?
    //
    
	always @(posedge clk or posedge reset) begin	   
        if(reset)
            play_state <= PLAY_STATE_NOTPLAYING;
        else
            play_state <= play_state_next;
	end 
	
    assign playing = play_state == PLAY_STATE_PLAYING;
    assign tips_over = play_state == PLAY_STATE_STOPPED;
	always@(*)begin
	   case(play_state)
	       PLAY_STATE_NOTPLAYING:begin
	           if(~playing && play_signal) play_state_next = PLAY_STATE_PLAYING;
	           else play_state_next = PLAY_STATE_NOTPLAYING;
	       end
	       PLAY_STATE_PLAYING:begin
               if(failed || song_done) play_state_next = PLAY_STATE_STOPPED;
               else if(speed == 3'b000) play_state_next = PLAY_STATE_PAUSED;
               else play_state_next = PLAY_STATE_PLAYING;
	       end
	       PLAY_STATE_PAUSED:begin
	           if(speed > 3'b000) play_state_next = PLAY_STATE_PLAYING;
	           else play_state_next = PLAY_STATE_PAUSED;
	       end
	       PLAY_STATE_STOPPED:begin 
	           play_state_next = PLAY_STATE_STOPPED;
	       end
	       default:begin
	           play_state_next = PLAY_STATE_NOTPLAYING;
	       end
	   endcase
	end
    // â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?â”?

    wire block_type;
    wire [9:0] x1, y1, x2, y2;
        
    reg [9:0] reg_block_x, reg_block_y;
    reg [9:0] reg_x1, reg_x2, reg_y1, reg_y2;
    
	// set game speed
	always@(posedge hclk or posedge reset) begin
        if (reset) begin  // reset head position
            head_x_raw <= 17'd672;
            head_y_raw <= 17'd480;
            direction <= 1'b0;
        end else begin
            if (play_state == PLAY_STATE_PLAYING) begin
                if (press && head_x_raw>=17'd697) begin
                    direction = ~direction;
                end
                case(speed) // move according to direction & speed        
                    3'b001:  begin
                                if (direction) begin
                                    head_y_raw <= head_y_raw + 5;
                                end else begin
                                    head_x_raw <= head_x_raw + 5;
                                end
                            end
                    3'b010:  begin
                                if (direction) begin
                                    head_y_raw <= head_y_raw + 6;
                                end else begin
                                    head_x_raw <= head_x_raw + 6;
                                end
                            end
                    3'b011:  begin
                                if (direction) begin
                                    head_y_raw <= head_y_raw + 7;
                                end else begin
                                    head_x_raw <= head_x_raw + 7;
                                end
                            end
                    3'b100:  begin
                                if (direction) begin
                                    head_y_raw <= head_y_raw + 8;
                                end else begin
                                    head_x_raw <= head_x_raw + 8;
                                end
                            end
                    3'b101:  begin
                                if (direction) begin
                                    head_y_raw <= head_y_raw + 9;
                                end else begin
                                    head_x_raw <= head_x_raw + 9;
                                end
                            end
                    3'b110:  begin
                                if (direction) begin
                                    head_y_raw <= head_y_raw + 10;
                                end else begin
                                    head_x_raw <= head_x_raw + 10;
                                end
                            end
                    3'b111:  begin
                                if (direction) begin
                                    head_y_raw <= head_y_raw + 12;
                                end else begin
                                    head_x_raw <= head_x_raw + 12;
                                end
                            end
                endcase
            end
            reg_x1 <= x1;
            reg_y1 <= y1;
            reg_x2 <= x2;
            reg_y2 <= y2;
        end
    end

    
    wire clk48kHz;
    reg [25:0] progress_raw;
    fre_div#(4166) cd48k(
        .clk_in(clk), 
        .reset(reset), 
        .clk_out(clk48kHz)
        );
    always @(posedge clk48kHz or posedge reset) begin
        if (reset) begin
            progress_raw <= 10'd0;
        end else begin
            if (playing && song == 2'b00 && progress_raw <= 26'd35376000) begin
                if (speed == 3'b001) begin progress_raw <= progress_raw + 26'd5; end
                else if (speed == 3'b010) begin progress_raw <= progress_raw + 26'd6; end
                else if (speed == 3'b011) begin progress_raw <= progress_raw + 26'd7; end
                else if (speed == 3'b100) begin progress_raw <= progress_raw + 26'd8; end
                else if (speed == 3'b101) begin progress_raw <= progress_raw + 26'd9; end
                else if (speed == 3'b110) begin progress_raw <= progress_raw + 26'd10; end
                else if (speed == 3'b111) begin progress_raw <= progress_raw + 26'd12; end
                progress = progress_raw / 35376;
            end else if (playing && song == 2'b01 && progress_raw <= 26'd29370000) begin
                if (speed == 3'b001) begin progress_raw <= progress_raw + 26'd5; end
                else if (speed == 3'b010) begin progress_raw <= progress_raw + 26'd6; end
                else if (speed == 3'b011) begin progress_raw <= progress_raw + 26'd7; end
                else if (speed == 3'b100) begin progress_raw <= progress_raw + 26'd8; end
                else if (speed == 3'b101) begin progress_raw <= progress_raw + 26'd9; end
                else if (speed == 3'b110) begin progress_raw <= progress_raw + 26'd10; end
                else if (speed == 3'b111) begin progress_raw <= progress_raw + 26'd12; end
                progress = progress_raw / 29370;
            end else if (playing && song == 2'b10 && progress_raw <= 26'd19393000) begin
                if (speed == 3'b001) begin progress_raw <= progress_raw + 26'd5; end
                else if (speed == 3'b010) begin progress_raw <= progress_raw + 26'd6; end
                else if (speed == 3'b011) begin progress_raw <= progress_raw + 26'd7; end
                else if (speed == 3'b100) begin progress_raw <= progress_raw + 26'd8; end
                else if (speed == 3'b101) begin progress_raw <= progress_raw + 26'd9; end
                else if (speed == 3'b110) begin progress_raw <= progress_raw + 26'd10; end
                else if (speed == 3'b111) begin progress_raw <= progress_raw + 26'd12; end
                progress = progress_raw / 19393;
            end else if (playing && song == 2'b11 && progress_raw <= 26'd18338000) begin
                if (speed == 3'b001) begin progress_raw <= progress_raw + 26'd5; end
                else if (speed == 3'b010) begin progress_raw <= progress_raw + 26'd6; end
                else if (speed == 3'b011) begin progress_raw <= progress_raw + 26'd7; end
                else if (speed == 3'b100) begin progress_raw <= progress_raw + 26'd8; end
                else if (speed == 3'b101) begin progress_raw <= progress_raw + 26'd9; end
                else if (speed == 3'b110) begin progress_raw <= progress_raw + 26'd10; end
                else if (speed == 3'b111) begin progress_raw <= progress_raw + 26'd12; end
                progress = progress_raw / 18338;
            end
        end
    end
    
    always@(*)begin
        case(song)
            2'b00:begin
				if(progress_raw > 26'd35376000) song_done = 1'b1;
				else song_done = 1'b0;
            end
			2'b01:begin
				if(progress_raw > 26'd29370000) song_done = 1'b1;
				else song_done = 1'b0;
            end
			2'b10:begin
				if(progress_raw > 26'd19393000) song_done = 1'b1;
				else song_done = 1'b0;
            end
			2'b11:begin
				if(progress_raw > 26'd18338000) song_done = 1'b1;
				else song_done = 1'b0;
            end
        endcase
    end

	assign scroll_block_x = valid ? (scroll_x + h_cnt) / 32 : 10'd0;
	assign scroll_block_y = valid ? (scroll_y + v_cnt) / 32 : 10'd0;
	assign block_pixel_x = valid ? (scroll_x + h_cnt) % 32 : 10'd0;
	assign block_pixel_y = valid ? (scroll_y + v_cnt) % 32 : 10'd0;
	
	assign x1 = (head_x - 7) / 32;
	assign y1 = (head_y - 7) / 32;
	assign x2 = (head_x + 7) / 32;
    assign y2 = (head_y + 7) / 32;
	
	always@(posedge clk_25MHz) begin
        if (scroll_block_y >= 7 && scroll_block_y <= map_height && scroll_block_x
            >= scroll_block_y - 7 && scroll_block_x <= scroll_block_y + 42) begin
            reg_block_x <= scroll_block_x - scroll_block_y + 7;
            reg_block_y <= scroll_block_y - 7;
        end else begin
            reg_block_x <= 0;
            reg_block_y <= 0;
        end
    end
    
    wire failed_raw;
    assign failed = failed_raw & ~debug_switch;

    assign refer_x = scroll_x[15:5];
    assign refer_y = scroll_y[15:5];
    wire load_signal;
    assign load_signal = play_state == PLAY_STATE_NOTPLAYING;
    turn_points_rom tpr_beta(
        .clk                        (clk_25MHz), 
        .reset                      (reset),
        .load_raw                   (load_signal),
        .song                       (song), 
        .refer_x                    (refer_x), 
        .refer_y                    (refer_y),
        .current_block_x            (scroll_block_x), 
        .current_block_y            (scroll_block_y), 
        .x1                         (reg_x2), 
        .y1                         (reg_y1), 
        .x2                         (reg_x1), 
        .y2                         (reg_y2),
        .is_road                    (block_type),
        .fail                       (failed_raw),
        .debug                      (debug)
    );

    getPixel gpl(       
        .clk                        (clk_25MHz), 
        .hclk                       (hclk), 
        .reset                      (reset), 
        .valid                      (valid), 
        .song                       (song), 
        .type                       (block_type),
        .press                      (press), 
        .progress                   (progress), 
        .x                          (block_pixel_x), 
        .y                          (block_pixel_y),
        .h_cnt                      (h_cnt), 
        .v_cnt                      (v_cnt), 
        .head_x                     (head_x), 
        .head_y                     (head_y),
        .scroll_x_in                (scroll_x), 
        .scroll_y_in                (scroll_y),
        .tips_display               (tips_display),
        .tips_display_over          (tips_over),
        .r                          (r), 
        .g                          (g), 
        .b                          (b)
        );      

    oneShot os7(        
        .clk                        (hclk),
        .signal_in                  (press_raw),
        .signal_out                 (press)
    );

endmodule
