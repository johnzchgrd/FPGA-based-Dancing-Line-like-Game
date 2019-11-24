`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/09 16:22:18
// Design Name: 
// Module Name: MusicPlayer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
//basic modules
module register2(
    input [1:0] in,
    input load,
    input clock,
    input clear,
    output reg [1:0] out
    );
    always @(posedge clock or posedge clear) begin
        if (clear) begin
            out <= 2'b00;
        end else if (load) begin
            out <= in;
        end
    end
endmodule

////////

module MasterCtrlUnit(
    // this module is used to control the status of the song and whether it's playing,
    // played or paused. Its main structure is a dedicated microprocessor.
    input clock, input reset,
    input pause_signal,
    input play_signal,
    input stop_signal,
    input [1:0] song_signal, 
    input [2:0] song_speed,
    output reg on_playing,
    output reg reset_player,
    input song_done,
    output [1:0] song,
    output reg [2:0] state
    );
    reg [2:0] state_next;
    reg songLoad, songMux;
    //next state logic and output logic of control unit
    always @(*) begin
        case (state)
            3'b000: begin   //s_extra
                        state_next = 3'b101;
                    end
            3'b001: begin   //s_play
                        if (pause_signal) begin
                            state_next = 3'b010;
                        end else if (play_signal) begin
                            state_next = 3'b011;
                        end else if (song_done || stop_signal) begin
                            state_next = 3'b101;
                        end else begin
                            state_next = 3'b001;
                        end
                        songLoad = 0;
                        reset_player = 1'b0;
                        on_playing = 1'b1;
                    end
            3'b010: begin   //s_pause
                        if (~pause_signal) begin
                            state_next = 3'b001;
                        end else begin
                            state_next = 3'b010;
                        end
                        songLoad = 0;
                        reset_player = 1'b0;
                        on_playing = 1'b0;
                    end
            3'b011: begin   //s_newsong
                        state_next = 3'b100;
                        songLoad = 1;
                        reset_player = 1'b0;
                        on_playing = 1'b0;
                    end
            3'b100: begin   //s_resetplayer
                        state_next = 3'b001;
                        reset_player = 1'b1;
                        on_playing = 1'b0;
                    end
            3'b101: begin   //s_stop
                        if (play_signal) begin
                            state_next = 3'b100;
                        end else begin
                            state_next = 3'b101;
                        end
                        songLoad = 1'b1;
                        reset_player = 1'b0;
                        on_playing = 1'b0;
                    end
            default:state_next = 2'b00;
        endcase
    end
    //state register of control unit
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
        end else begin
            state <= state_next;
        end
    end
    //datapath
    wire [1:0] songincred, songdecred, songin;
    register2 regsong(song_signal, songLoad, clock, reset, song);
endmodule

module ChannelReader(
    // this module is used to read notes from song rom and pass the info of the notes
    // to the note player. Its main structure is a Moore FSM.
    input clock,
    input reset,
    input on_playing,
    input [1:0] song,
    input reset_player,
    output reg song_done,
    input [15:0] new_address,   // if new song is played, what address should be played first
    output [6:0] note_tune,
    output [7:0] note_duration,
    output [6:0] note_velocity,
    output [1:0] note_type,
    output [1:0] note_effect,
    output reg new_note,
    input note_done_raw,    //notice that the frequency is 48kHz
    input note_read,
    input [25:0] noteinfo,
    output reg [11:0] address,   
    output [7:0] debug
    );
    reg [2:0] state, state_next;
    reg nr_tmp1, nr_tmp2, nr_tmp3;
    wire note_done;
    //reg [6:0] address;
    //wire [25:0] noteinfo;
    //next state and output logic
    always @(*) begin
        case(state)
            3'b000: begin   //s_stop
                        new_note = 1'b0;
                        song_done = 1'b0;
                        if (on_playing) begin
                            state_next = 3'b001;
                        end else begin
                            state_next = 3'b000;
                        end
                    end
            3'b001: begin   //s_read
                        new_note = 1'b0;
                        state_next = 3'b010;
                    end
            3'b010: begin   //s_newnote
                        new_note = 1'b1;
                        if (note_read) begin
                            state_next = 3'b011;
                        end else begin
                            state_next = 3'b010;
                        end
                    end
            3'b011: begin   //s_wait
                        new_note = 1'b0;
                        if (!on_playing) begin
                            state_next = 3'b100;
                        end else if (note_done) begin
                            if (note_tune == 7'd127 && !reset_player) begin
                                state_next = 3'b101;
                            end else begin
                                state_next = 3'b001;
                            end
                        end else begin
                            state_next = 3'b011;
                        end
                    end
            3'b100: begin   //s_pause
                        new_note = 1'b0;
                        if (on_playing) begin
                            state_next = 3'b011;
                        end else begin
                            state_next = 3'b100;
                        end
                    end
            3'b101: begin   //s_songdone
                        song_done = 1'b1;
                        state_next = 3'b000;
                        new_note = 1'b0;
                    end
            default:begin
                        state_next = 3'b000;
                    end
        endcase
    end
    //state register
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            nr_tmp1 <= 0;
            nr_tmp2 <= 0;
            nr_tmp3 <= 0;
            address = 10'd0;
        end else begin
            if (reset_player) begin
                address =  new_address;
            end
            nr_tmp1 <= note_done_raw;
            nr_tmp2 <= nr_tmp1;
            nr_tmp3 <= nr_tmp2;
            state <= state_next;
            if (state_next == 3'b001) begin
                //debug = debug + 7'd1;
                address = address + 10'd1;
            end
        end
    end
    assign note_done = ~nr_tmp1 & note_done_raw;
    assign note_tune = noteinfo[25:19];
    assign note_duration = noteinfo[18:11];
    assign note_velocity = noteinfo[10:4];
    assign note_type = noteinfo[3:2];
    assign note_effect = noteinfo[1:0];
    assign debug = note_tune;
endmodule

//generate a 48kHz clock. well, not accurately...
module clock_divider_48kHz(
    input clk100Mhz,
    input reset,
    output reg clock
    );
    
    parameter [11:0] half = 12'd2083;
    reg [11:0] count;
    always @(posedge clk100Mhz or posedge reset) begin
        if (reset) begin
            clock <= 1'b0;
            count <= 12'd0;
        end else if (count == half) begin
            count <= 12'd0;
            clock <= ~clock;
        end else begin
            count <= count + 1;
        end
    end
endmodule

module PulseGenerator(
    input clk48kHz,
    input reset,
    input [6:0] velocity,
    input [1:0] type,
    input [1:0] effect,
    input [19:0] step_size,
    input generate_next,
    output reg [15:0] sample
    );
    reg [21:0] pulse_pointer;
    reg [15:0] sample_next;
    always @(posedge clk48kHz or posedge reset) begin
        if (reset) begin
            sample = 16'd0;
            pulse_pointer = 22'd0;
        end else begin
            if (generate_next) begin
                pulse_pointer = pulse_pointer + {2'b00, step_size};
                sample = sample_next;
            end else begin
                sample = 16'd0;
            end
        end
    end
    //output the pulse;
    reg [11:0] effectcounter;
    always @(*) begin
        case (type)
            2'b00:  if (pulse_pointer[21:19] < 3'b100) begin
                        sample_next = {1'b0, velocity, 8'd0};
                    end else begin
                        sample_next = 16'd0;
                    end
            2'b01:  if (pulse_pointer[21:19] < 3'b011) begin
                        sample_next = {1'b0, velocity, 8'd0};
                    end else begin
                        sample_next = 16'd0;
                    end
            2'b10:  if (pulse_pointer[21:19] < 3'b010) begin
                        sample_next = {1'b0, velocity, 8'd0};
                    end else begin
                        sample_next = 16'd0;
                    end  
            2'b11:  if (pulse_pointer[21:19] < 3'b001) begin
                        sample_next = {1'b0, velocity, 8'd0};
                    end else begin
                        sample_next = 16'd0;
                    end
            endcase
    end
    
    //sine_rom sinROM(clk48kHz, sample_next, pulse_pointer[21:10]);
endmodule

module TriangleGenerator(
    input clk48kHz,
    input reset,
    input [6:0] velocity,
    input [1:0] type,
    input [1:0] effect,
    input [19:0] step_size,
    input generate_next,
    output reg [15:0] sample
    );
    reg [21:0] tri_pointer;
    reg [15:0] sample_next;
    always @(posedge clk48kHz or posedge reset) begin
        if (reset) begin
            sample = 16'd0;
            tri_pointer = 22'd0;
        end else begin
            if (generate_next) begin
                tri_pointer = tri_pointer + {2'b00, step_size};
                sample = sample_next;
            end else begin
                sample = 16'd0;
            end
        end
    end
    //output the pulse;
    reg [9:0] effectcounter;
    always @(posedge clk48kHz) begin
        if (effect == 2'd3) begin
            effectcounter = effectcounter + 1;
        end
    end
    always @(*) begin
        if (tri_pointer[21] == 1'b0) begin
            sample_next = {1'b0, tri_pointer[20:6]};
        end else begin
            sample_next = {1'b0, 16'd32767 - tri_pointer[20:6]};
        end
    end
endmodule

module SawGenerator(
    input clk48kHz,
    input reset,
    input [6:0] velocity,
    input [1:0] type,
    input [1:0] effect,
    input [19:0] step_size,
    input generate_next,
    output reg [15:0] sample
    );
    reg [21:0] tri_pointer;
    reg [15:0] sample_next;
    always @(posedge clk48kHz or posedge reset) begin
        if (reset) begin
            sample = 16'd0;
            tri_pointer = 22'd0;
        end else begin
            if (generate_next) begin
                tri_pointer = tri_pointer + {2'b00, step_size};
                sample = sample_next;
            end else begin
                sample = 16'd0;
            end
        end
    end
    //output the pulse;
    reg [9:0] effectcounter;
    always @(posedge clk48kHz) begin
        if (effect == 2'd3) begin
            effectcounter = effectcounter + 1;
        end
    end
    always @(*) begin
        sample_next = {1'b0, tri_pointer[21:7]};
    end
endmodule

module DrumsGenerator(      //I think it is the hardest part :(
    input clk48kHz,
    input reset,
    input [6:0] tune,
    input [6:0] velocity,
    input [1:0] type,
    input [1:0] effect,
    input new_note,
    input generate_next,
    output reg [7:0] sample,
    output [7:0] debug
    );
    reg [11:0] kick_pointer;
    reg [11:0] snare_pointer;
    reg [11:0] hat_pointer;
    reg [12:0] crash_pointer;
    wire [5:0] kick_sample;
    wire [5:0] snare_sample;
    wire [5:0] hat_sample;
    wire [5:0] crash_sample;
    reg [7:0] sample_next;
    always @(posedge clk48kHz or posedge reset) begin
        if (reset) begin
            sample = 8'd0;
            kick_pointer <= 12'd0;
            snare_pointer <= 12'd0;
            hat_pointer <= 12'd0;
            crash_pointer <= 13'd0;
        end else begin
            if (new_note) begin
                if (tune[0] == 1'b1) begin
                    kick_pointer <= 12'd0;
                end
                if (tune[1] == 1'b1) begin
                    snare_pointer <= 12'd0;
                end
                if (tune[2] == 1'b1) begin
                    hat_pointer <= 12'd0;
                end
                if (tune[3] == 1'b1) begin
                    crash_pointer <= 13'd0;
                end
            end else if (generate_next) begin
                if (tune[0] == 1'b1 && kick_pointer < 12'd4095) begin
                    kick_pointer <= kick_pointer + 12'd1;
                end
                if (tune[1] == 1'b1 && snare_pointer < 12'd4095) begin
                    snare_pointer <= snare_pointer + 12'd1;
                end
                if (tune[2] == 1'b1 && hat_pointer < 12'd4095) begin
                    hat_pointer <= hat_pointer + 12'd1;
                end
                if (tune[3] == 1'b1 && crash_pointer < 13'd8191) begin
                    crash_pointer <= crash_pointer + 13'd1;
                end
                sample = sample_next;
            end else begin
                sample = 16'd0;
            end
        end
    end
    //output the sample;
    kick_rom kr(clk48kHz, kick_sample, kick_pointer);
    snare_rom sr(clk48kHz, snare_sample, snare_pointer);
    hat_rom hr(clk48kHz, hat_sample, hat_pointer);
    crash_rom cr(clk48kHz, crash_sample, crash_pointer);
    always @(*) begin
        sample_next = kick_sample + snare_sample[5:1] + hat_sample[5:1] + crash_sample;
    end
    assign debug = {kick_pointer[11:9], snare_pointer[11:10], hat_pointer[11:10], new_note};
endmodule

module Lead1Generator(
    input clk48kHz,
    input reset,
    input [6:0] velocity,
    input [1:0] type,
    input [1:0] effect,
    input [19:0] step_size,
    input generate_next,
    output reg [15:0] sample
    );
    reg [21:0] pulse_pointer;
    wire [15:0] sample_next;
    always @(posedge clk48kHz or posedge reset) begin
        if (reset) begin
            sample = 16'd0;
            pulse_pointer = 22'd0;
        end else begin
            if (generate_next) begin
                pulse_pointer = pulse_pointer + {2'b00, step_size};
                sample = sample_next;
            end else begin
                sample = 16'd0;
            end
        end
    end
    //output the sound;
    lead_rom sinROM(clk48kHz, sample_next, pulse_pointer[21:10]);
endmodule

module Lead2Generator(
    input clk48kHz,
    input reset,
    input [6:0] velocity,
    input [1:0] type,
    input [1:0] effect,
    input [19:0] step_size,
    input generate_next, 
    output reg [15:0] sample
    );
    reg [21:0] pulse_pointer;
    wire [15:0] sample_next;
    always @(posedge clk48kHz or posedge reset) begin
        if (reset) begin
            sample = 16'd0;
            pulse_pointer = 22'd0;
        end else begin
            if (generate_next) begin
                pulse_pointer = pulse_pointer + {2'b00, step_size};
                sample = sample_next;
            end else begin
                sample = 16'd0;
            end
        end
    end
    //output the pulse;
    sine_rom sinROM(clk48kHz, sample_next, pulse_pointer[21:10]);
endmodule

module NotePlayer(
    input clock,
    input clk48kHz,
    input reset,
    input play_enable,
    input [2:0] song_speed,
    input [6:0] next_note,
    input [7:0] next_duration,
    input [6:0] next_velocity,
    input [1:0] next_type,
    input [1:0] next_effect,
    input new_note,
    output reg note_done,
    output reg note_read,
    
    output reg [6:0] note_velocity,
    output reg [1:0] note_type,
    output reg [1:0] note_effect,
    output [19:0] step_size,
    output reg output_sample,
    input [15:0] sample_raw,
    
    output reg [7:0] sample_out,
    output [7:0] debug
    );
    //reg output_sample;  //set 1 to output sample
    //wire [15:0] sample_raw;
    reg [6:0] note_tune;
    reg [7:0] note_duration;
    //reg [6:0] note_velocity;
    //reg [1:0] note_type;
    //reg [1:0] note_effect;
    reg [2:0] state, state_next;
    reg [17:0] time_counter;
    reg [4:0] time_step;
    //next state and output logic
    always @(*) begin
        case(state)
            3'b000: begin   //s_extra
                        state_next = 3'b001;
                        note_read = 1'b0;
                        output_sample = 1'b0;
                    end
            3'b001: begin   //s_readnote
                        state_next = 3'b010;
                        note_read = 1'b0;
                        output_sample = 1'b0;
                        note_tune = next_note;
                        note_duration = next_duration;
                        note_velocity = next_velocity;
                        note_type = next_type;
                        note_effect = next_effect;
                    end
            3'b010: begin   //s_output
                        output_sample = 1'b1;
                        note_read = 1'b0;
                        if (!play_enable) begin
                            state_next = 3'b100;
                        end else if (new_note) begin
                            state_next = 3'b011;
                        end else begin
                            state_next = 3'b010;
                        end
                    end
            3'b011: begin   //s_nextnote
                        state_next = 3'b000;
                        note_read = 1'b1;
                        output_sample = 1'b0;
                    end
            3'b100: begin   //s_pause
                        output_sample = 1'b0;
                        note_read = 1'b0;
                        if (play_enable) begin 
                            state_next = 3'b010;
                        end else begin
                            state_next = 3'b100;
                        end
                    end
            default:begin
                        state_next = 3'b000;
                    end
        endcase
        case (song_speed)
            3'b000: time_step = 4'd0;
            3'b001: time_step = 4'd5;   //75BPM
            3'b010: time_step = 4'd6;   //90BPM
            3'b011: time_step = 4'd7;   //105BPM
            3'b100: time_step = 4'd8;   //120BPM
            3'b101: time_step = 4'd9;   //135BPM
            3'b110: time_step = 4'd10;  //150BPM
            3'b111: time_step = 4'd12;  //180BPM
        endcase
    end
    //state register and timing issues
    wire [17:0] durationcycle;  //how many cycles a duration is.
    assign durationcycle = 1000 * note_duration; 
    //assign durationcycle = 100 * duration;  //for simulate
    always @(posedge clk48kHz or posedge reset) begin
        if (reset) begin
            time_counter <= 15'd0;
            state <= 3'b000;
            note_done <= 1'b0;
        end else begin
        state <= state_next;
            if (state == 3'b010) begin
                if (time_counter >= durationcycle) begin
                    note_done <= 1'b1;
                    time_counter <= 15'd0;
                end else begin
                    note_done <= 1'b0;
                    time_counter <= time_counter + time_step;
                end
            end else if (state == 3'b100) begin
                note_done <= 1'b0;
            end else begin
                note_done <= 1'b0;
                time_counter <= 15'd0;
            end
        end
    end
    //submodule, which plays notes.
    //wire [19:0] step_size;
    frequency_rom freqROM(clock, step_size, note_tune);
    reg [1:0] volume;
    always @(*) begin
        case (note_effect)
            2'b00:  begin
                        sample_out = sample_raw[15:8];
                        volume = 2'b11;
                    end
            2'b01:  begin
                        if (time_counter <= 18'd4000) begin
                            volume = 2'b00;
                        end else if (time_counter <= 18'd8000) begin
                            volume = 2'b01;
                        end else if (time_counter <= 18'd12000) begin
                            volume = 2'b10;
                        end else begin
                            volume = 2'b11;
                        end
                        sample_out = sample_raw[15:10] * volume;
                    end
            2'b10:  begin
                        if (time_counter <= 18'd4000) begin
                            volume = 2'b00;
                        end else if (time_counter <= 18'd8000) begin
                            volume = 2'b01;
                        end else if (time_counter <= 18'd12000) begin
                            volume = 2'b10;
                        end else begin
                            volume = 2'b11;
                        end
                        sample_out = sample_raw[15:11] * volume + sample_raw[15:9];
                    end
            2'b11:  begin
                        if (time_counter % 18'd24000 >= 18'd22000) begin
                            sample_out = {2'b00, sample_raw[15:10]};
                            volume = 2'b00;
                        end else begin
                            sample_out = sample_raw[15:8];
                            volume = 2'b11;
                        end
                    end
        endcase 
    end
    assign debug = time_counter[14:7];
    //assign debug = {note_effect, volume, 4'b0000};
endmodule

module NotePlayer_Drums(
    input clock,
    input clk48kHz,
    input reset,
    input play_enable,
    input [2:0] song_speed,
    input [6:0] next_note,
    input [7:0] next_duration,
    input [6:0] next_velocity,
    input [1:0] next_type,
    input [1:0] next_effect,
    input new_note,
    output reg note_done,
    output reg note_read,
    
    output reg note_new,
    output reg [6:0] note_tune,
    output reg [6:0] note_velocity,
    output reg [1:0] note_type,
    output reg [1:0] note_effect,
    output reg output_sample,
    input [7:0] sample_raw,
    
    output reg [7:0] sample_out,
    output [7:0] debug
    );
    //reg output_sample;  //set 1 to output sample
    //wire [15:0] sample_raw;
    reg [7:0] note_duration;
    //reg [6:0] note_velocity;
    //reg [1:0] note_type;
    //reg [1:0] note_effect;
    reg [2:0] state, state_next;
    reg [17:0] time_counter;
    reg [4:0] time_step;
    //next state and output logic
    always @(*) begin
        case(state)
            3'b000: begin   //s_extra
                        state_next = 3'b001;
                        note_new = 1'b1;
                        note_read = 1'b0;
                        output_sample = 1'b0;
                    end
            3'b001: begin   //s_readnote
                        state_next = 3'b010;
                        note_new = 1'b1;
                        note_read = 1'b0;
                        output_sample = 1'b0;
                        note_tune = next_note;
                        note_duration = next_duration;
                        note_velocity = next_velocity;
                        note_type = next_type;
                        note_effect = next_effect;
                    end
            3'b010: begin   //s_output
                        output_sample = 1'b1;
                        note_read = 1'b0;
                        note_new = 1'b0;
                        if (!play_enable) begin
                            state_next = 3'b100;
                        end else if (new_note) begin
                            state_next = 3'b011;
                        end else begin
                            state_next = 3'b010;
                        end
                    end
            3'b011: begin   //s_nextnote
                        state_next = 3'b000;
                        note_read = 1'b1;
                        output_sample = 1'b0;
                        note_new = 1'b1;
                    end
            3'b100: begin   //s_pause
                        output_sample = 1'b0;
                        note_read = 1'b0;
                        note_new = 1'b0;
                        if (play_enable) begin 
                            state_next = 3'b010;
                        end else begin
                            state_next = 3'b100;
                        end
                    end
            default:begin
                        state_next = 3'b000;
                    end
        endcase
        case (song_speed)
            3'b000: time_step = 4'd0;
            3'b001: time_step = 4'd5;   //75BPM
            3'b010: time_step = 4'd6;   //90BPM
            3'b011: time_step = 4'd7;   //105BPM
            3'b100: time_step = 4'd8;   //120BPM
            3'b101: time_step = 4'd9;   //135BPM
            3'b110: time_step = 4'd10;  //150BPM
            3'b111: time_step = 4'd12;  //180BPM
        endcase
    end
    //state register and timing issues
    wire [17:0] durationcycle;  //how many cycles a duration is.
    assign durationcycle = 1000 * note_duration; 
    //assign durationcycle = 100 * duration;  //for simulate
    always @(posedge clk48kHz or posedge reset) begin
        if (reset) begin
            time_counter <= 15'd0;
            state <= 3'b000;
            note_done <= 1'b0;
        end else begin
        state <= state_next;
            if (state == 3'b010) begin
                if (time_counter >= durationcycle) begin
                    note_done <= 1'b1;
                    time_counter <= 15'd0;
                end else begin
                    note_done <= 1'b0;
                    time_counter <= time_counter + time_step;
                end
            end else if (state == 3'b100) begin
                note_done <= 1'b0;
            end else begin
                note_done <= 1'b0;
                time_counter <= 15'd0;
            end
        end
    end
    
    always @(*) begin
        sample_out = sample_raw;
    end
    assign debug = time_counter[14:7];
    //assign debug = {note_effect, volume, 4'b0000};
endmodule

module Adder(
    input [2:0] song,
    input [7:0] pulse1_sample,
    input [7:0] pulse2_sample,
    input [7:0] pulse3_sample,
    input [7:0] pulse4_sample,
    input [7:0] pulse5_sample,
    input [7:0] tri1_sample,
    input [7:0] tri2_sample,
    input [7:0] tri3_sample,
    input [7:0] saw1_sample,
    input [7:0] drums_sample,
    input [7:0] saw2_sample,
    input [7:0] saw3_sample,
    input [7:0] lead1_sample,
    input [7:0] lead2_sample,
    output reg [7:0] sample
    );
    wire [7:0] sample_raw;
    reg [7:0] sample_raw2;
    assign sample_raw = sample_raw2;
    always @(*) begin
        if (sample_raw[7] == 0) begin
            sample = sample_raw;
        end else begin
            sample = 8'b11111111 - {1'b0, sample_raw[6:0]};
        end
        case(song)
            2'b00:   sample_raw2 = pulse1_sample[7:5] + pulse2_sample[7:5] + pulse3_sample[7:5] + pulse4_sample[7:4]
                                 + pulse5_sample[7:4] + tri1_sample[7:4] + tri2_sample[7:4] + tri3_sample[7:4]
                                 + saw1_sample[7:4] + lead1_sample[7:4] + lead2_sample[7:4] + drums_sample[7:2];
            2'b01:   sample_raw2 = pulse1_sample[7:4] + pulse1_sample[7:5] + pulse3_sample[7:5] + pulse3_sample[7:4]
                                 + pulse2_sample[7:4] + saw1_sample[7:5] + saw2_sample[7:5] + saw3_sample[7:5] 
                                 + lead1_sample[7:4] + lead2_sample[7:4] + drums_sample[7:1];
            2'b10:   sample_raw2 = pulse2_sample[7:5] + pulse3_sample[7:4] + pulse4_sample[7:5] + pulse5_sample[7:5]
                                 + tri1_sample[7:4] + saw1_sample[7:6] + saw1_sample[7:5]
                                 + lead1_sample[7:4] + lead2_sample[7:4] + drums_sample[7:2];
            2'b11:   sample_raw2 = pulse1_sample[7:5] + pulse2_sample[7:5] + pulse3_sample[7:5] + pulse4_sample[7:5] + pulse5_sample[7:4]
                                 + tri1_sample[7:5] + tri2_sample[7:5] + tri3_sample[7:5] + saw1_sample[7:5]
                                 + lead1_sample[7:4] + lead2_sample[7:4] + drums_sample[7:2];
            default: sample_raw2 = 7'd0;
        endcase
    end
endmodule

//now, it's the FINAL MODULE :)
module MusicPlayer(
    input clock,
    input reset,
    input pause_signal,
    input play_signal,
    input stop_signal,
    input [1:0] song_signal,
    input [2:0] song_speed,
    output play_status,
    output [1:0] song_playing,
    output [1:0] speed_output,
    output [7:0] sample,
    output [2:0] displaypick,      //for debug usage
    output [7:0] addressdisplay,    //for debug usage
    output [7:0] debugdisplay, //useful
    output [2:0] debug2,  // for debug usage. Currently useless
    output song_done
    );
    wire on_playing, reset_player;
    wire [1:0] song;
    wire clk48kHz;
    wire [7:0] debug;
    MasterCtrlUnit mcu(clock, reset, pause_signal, play_signal, stop_signal, song_signal, song_speed,
                   on_playing, reset_player, song_done, song, debug2);
    clock_divider_48kHz cd(clock, reset, clk48kHz);
    //CHANNEL 1 - PULSE 1
    wire [6:0] pulse1_note_tune;
    wire [7:0] pulse1_note_duration;
    wire [6:0] pulse1_note_velocity;
    wire [1:0] pulse1_note_type;
    wire [25:0] pulse1_note_info;
    wire [15:0] pulse1_new_address;
    wire [11:0] pulse1_address;
    wire [1:0] pulse1_note_effect;
    wire pulse1_new_note, pulse1_note_done, pulse1_note_read;
    wire [6:0] pulse1_gnote_velocity;
    wire [1:0] pulse1_gnote_type;
    wire [1:0] pulse1_gnote_effect;
    wire [19:0] pulse1_step_size;
    wire pulse1_output_sample;
    wire [15:0] pulse1_sample_raw;
    wire pulse1_empty;
    wire [7:0] pulse1_sample;
    ChannelReader pulse1_cr(clock, reset, on_playing, song, reset_player, pulse1_empty, pulse1_new_address,
                            pulse1_note_tune, pulse1_note_duration, pulse1_note_velocity, pulse1_note_type, pulse1_note_effect,
                            pulse1_new_note, pulse1_note_done, pulse1_note_read, pulse1_note_info, pulse1_address);
    pulse1_rom pulse1_sr(clock, pulse1_note_info, pulse1_address);
    pulse1_pos_rom(clock, song, pulse1_new_address);
    NotePlayer pulse1_np(clock, clk48kHz, reset, on_playing, song_speed,
                         pulse1_note_tune, pulse1_note_duration, pulse1_note_velocity, pulse1_note_type, pulse1_note_effect,
                         pulse1_new_note, pulse1_note_done, pulse1_note_read,
                         pulse1_gnote_velocity, pulse1_gnote_type, pulse1_gnote_effect,
                         pulse1_step_size, pulse1_output_sample, pulse1_sample_raw, pulse1_sample);
    PulseGenerator pulse1_g(clk48kHz, reset, pulse1_gnote_velocity, pulse1_gnote_type, pulse1_gnote_effect,
                            pulse1_step_size, pulse1_output_sample, pulse1_sample_raw);
    //CHANNEL 2 - PULSE 2
    wire [6:0] pulse2_note_tune;
    wire [7:0] pulse2_note_duration;
    wire [6:0] pulse2_note_velocity;
    wire [1:0] pulse2_note_type;
    wire [25:0] pulse2_note_info;
    wire [15:0] pulse2_new_address;
    wire [11:0] pulse2_address;
    wire [1:0] pulse2_note_effect;
    wire pulse2_new_note, pulse2_note_done, pulse2_note_read;
    wire [6:0] pulse2_gnote_velocity;
    wire [1:0] pulse2_gnote_type;
    wire [1:0] pulse2_gnote_effect;
    wire [19:0] pulse2_step_size;
    wire pulse2_output_sample;
    wire [15:0] pulse2_sample_raw;
    wire pulse2_empty;
    wire [7:0] pulse2_sample;
    ChannelReader pulse2_cr(clock, reset, on_playing, song, reset_player, pulse2_empty, pulse2_new_address,
                            pulse2_note_tune, pulse2_note_duration, pulse2_note_velocity, pulse2_note_type, pulse2_note_effect,
                            pulse2_new_note, pulse2_note_done, pulse2_note_read, pulse2_note_info, pulse2_address);
    pulse2_rom pulse2_sr(clock, pulse2_note_info, pulse2_address);
    pulse2_pos_rom(clock, song, pulse2_new_address);
    NotePlayer pulse2_np(clock, clk48kHz, reset, on_playing, song_speed,
                         pulse2_note_tune, pulse2_note_duration, pulse2_note_velocity, pulse2_note_type, pulse2_note_effect,
                         pulse2_new_note, pulse2_note_done, pulse2_note_read,
                         pulse2_gnote_velocity, pulse2_gnote_type, pulse2_gnote_effect,
                         pulse2_step_size, pulse2_output_sample, pulse2_sample_raw, pulse2_sample);
    PulseGenerator pulse2_g(clk48kHz, reset, pulse2_gnote_velocity, pulse2_gnote_type, pulse2_gnote_effect,
                            pulse2_step_size, pulse2_output_sample, pulse2_sample_raw);
    //CHANNEL 3 - PULSE 3
    wire [6:0] pulse3_note_tune;
    wire [7:0] pulse3_note_duration;
    wire [6:0] pulse3_note_velocity;
    wire [1:0] pulse3_note_type;
    wire [25:0] pulse3_note_info;
    wire [15:0] pulse3_new_address;
    wire [11:0] pulse3_address;
    wire [1:0] pulse3_note_effect;
    wire pulse3_new_note, pulse3_note_done, pulse3_note_read;
    wire [6:0] pulse3_gnote_velocity;
    wire [1:0] pulse3_gnote_type;
    wire [1:0] pulse3_gnote_effect;
    wire [19:0] pulse3_step_size;
    wire pulse3_output_sample;
    wire [15:0] pulse3_sample_raw;
    wire pulse3_empty;
    wire [7:0] pulse3_sample;
    ChannelReader pulse3_cr(clock, reset, on_playing, song, reset_player, pulse3_empty, pulse3_new_address,
                            pulse3_note_tune, pulse3_note_duration, pulse3_note_velocity, pulse3_note_type, pulse3_note_effect,
                            pulse3_new_note, pulse3_note_done, pulse3_note_read, pulse3_note_info, pulse3_address);
    pulse3_rom pulse3_sr(clock, pulse3_note_info, pulse3_address);
    pulse3_pos_rom(clock, song, pulse3_new_address);
    NotePlayer pulse3_np(clock, clk48kHz, reset, on_playing, song_speed,
                         pulse3_note_tune, pulse3_note_duration, pulse3_note_velocity, pulse3_note_type, pulse3_note_effect,
                         pulse3_new_note, pulse3_note_done, pulse3_note_read,
                         pulse3_gnote_velocity, pulse3_gnote_type, pulse3_gnote_effect,
                         pulse3_step_size, pulse3_output_sample, pulse3_sample_raw, pulse3_sample);
    PulseGenerator pulse3_g(clk48kHz, reset, pulse3_gnote_velocity, pulse3_gnote_type, pulse3_gnote_effect,
                            pulse3_step_size, pulse3_output_sample, pulse3_sample_raw);
    //CHANNEL 4 - PULSE 4
    wire [6:0] pulse4_note_tune;
    wire [7:0] pulse4_note_duration;
    wire [6:0] pulse4_note_velocity;
    wire [1:0] pulse4_note_type;
    wire [25:0] pulse4_note_info;
    wire [15:0] pulse4_new_address;
    wire [11:0] pulse4_address;
    wire [1:0] pulse4_note_effect;
    wire pulse4_new_note, pulse4_note_done, pulse4_note_read;
    wire [6:0] pulse4_gnote_velocity;
    wire [1:0] pulse4_gnote_type;
    wire [1:0] pulse4_gnote_effect;
    wire [19:0] pulse4_step_size;
    wire pulse4_output_sample;
    wire [15:0] pulse4_sample_raw;
    wire pulse4_empty;
    wire [7:0] pulse4_sample;
    ChannelReader pulse4_cr(clock, reset, on_playing, song, reset_player, pulse4_empty, pulse4_new_address,
                            pulse4_note_tune, pulse4_note_duration, pulse4_note_velocity, pulse4_note_type, pulse4_note_effect,
                            pulse4_new_note, pulse4_note_done, pulse4_note_read, pulse4_note_info, pulse4_address);
    pulse4_rom pulse4_sr(clock, pulse4_note_info, pulse4_address);
    pulse4_pos_rom(clock, song, pulse4_new_address);
    NotePlayer pulse4_np(clock, clk48kHz, reset, on_playing, song_speed,
                         pulse4_note_tune, pulse4_note_duration, pulse4_note_velocity, pulse4_note_type, pulse4_note_effect,
                         pulse4_new_note, pulse4_note_done, pulse4_note_read,
                         pulse4_gnote_velocity, pulse4_gnote_type, pulse4_gnote_effect,
                         pulse4_step_size, pulse4_output_sample, pulse4_sample_raw, pulse4_sample);
    PulseGenerator pulse4_g(clk48kHz, reset, pulse4_gnote_velocity, pulse4_gnote_type, pulse4_gnote_effect,
                            pulse4_step_size, pulse4_output_sample, pulse4_sample_raw);
    //CHANNEL 5 - PULSE 5
    wire [6:0] pulse5_note_tune;
    wire [7:0] pulse5_note_duration;
    wire [6:0] pulse5_note_velocity;
    wire [1:0] pulse5_note_type;
    wire [25:0] pulse5_note_info;
    wire [15:0] pulse5_new_address;
    wire [11:0] pulse5_address;
    wire [1:0] pulse5_note_effect;
    wire pulse5_new_note, pulse5_note_done, pulse5_note_read;
    wire [6:0] pulse5_gnote_velocity;
    wire [1:0] pulse5_gnote_type;
    wire [1:0] pulse5_gnote_effect;
    wire [19:0] pulse5_step_size;
    wire pulse5_output_sample;
    wire [15:0] pulse5_sample_raw;
    wire pulse5_empty;
    wire [7:0] pulse5_sample;
    ChannelReader pulse5_cr(clock, reset, on_playing, song, reset_player, pulse5_empty, pulse5_new_address,
                            pulse5_note_tune, pulse5_note_duration, pulse5_note_velocity, pulse5_note_type, pulse5_note_effect,
                            pulse5_new_note, pulse5_note_done, pulse5_note_read, pulse5_note_info, pulse5_address);
    pulse5_rom pulse5_sr(clock, pulse5_note_info, pulse5_address);
    pulse5_pos_rom(clock, song, pulse5_new_address);
    NotePlayer pulse5_np(clock, clk48kHz, reset, on_playing, song_speed,
                         pulse5_note_tune, pulse5_note_duration, pulse5_note_velocity, pulse5_note_type, pulse5_note_effect,
                         pulse5_new_note, pulse5_note_done, pulse5_note_read,
                         pulse5_gnote_velocity, pulse5_gnote_type, pulse5_gnote_effect,
                         pulse5_step_size, pulse5_output_sample, pulse5_sample_raw, pulse5_sample);
    PulseGenerator pulse5_g(clk48kHz, reset, pulse5_gnote_velocity, pulse5_gnote_type, pulse5_gnote_effect,
                            pulse5_step_size, pulse5_output_sample, pulse5_sample_raw);
    //CHANNEL 6 - TRIANGLE 1
    wire [6:0] tri1_note_tune;
    wire [7:0] tri1_note_duration;
    wire [6:0] tri1_note_velocity;
    wire [1:0] tri1_note_type;
    wire [25:0] tri1_note_info;
    wire [15:0] tri1_new_address;
    wire [11:0] tri1_address;
    wire [1:0] tri1_note_effect;
    wire tri1_new_note, tri1_note_done, tri1_note_read;
    wire [6:0] tri1_gnote_velocity;
    wire [1:0] tri1_gnote_type;
    wire [1:0] tri1_gnote_effect;
    wire [19:0] tri1_step_size;
    wire tri1_output_sample;
    wire [15:0] tri1_sample_raw;
    wire tri1_empty;
    wire [7:0] tri1_sample;
    ChannelReader tri1_cr(clock, reset, on_playing, song, reset_player, tri1_empty, tri1_new_address,
                          tri1_note_tune, tri1_note_duration, tri1_note_velocity, tri1_note_type, tri1_note_effect,
                          tri1_new_note, tri1_note_done, tri1_note_read, tri1_note_info, tri1_address);
    tri1_rom tri1_sr(clock, tri1_note_info, tri1_address);
    tri1_pos_rom(clock, song, tri1_new_address);
    NotePlayer tri1_np(clock, clk48kHz, reset, on_playing, song_speed,
                       tri1_note_tune, tri1_note_duration, tri1_note_velocity, tri1_note_type, tri1_note_effect,
                       tri1_new_note, tri1_note_done, tri1_note_read,
                       tri1_gnote_velocity, tri1_gnote_type, tri1_gnote_effect,
                       tri1_step_size, tri1_output_sample, tri1_sample_raw, tri1_sample);
    TriangleGenerator tri1_g(clk48kHz, reset, tri1_gnote_velocity, tri1_gnote_type, tri1_gnote_effect,
                             tri1_step_size, tri1_output_sample, tri1_sample_raw);
    //CHANNEL 7 - TRIANGLE 2
    wire [6:0] tri2_note_tune;
    wire [7:0] tri2_note_duration;
    wire [6:0] tri2_note_velocity;
    wire [1:0] tri2_note_type;
    wire [25:0] tri2_note_info;
    wire [15:0] tri2_new_address;
    wire [11:0] tri2_address;
    wire [1:0] tri2_note_effect;
    wire tri2_new_note, tri2_note_done, tri2_note_read;
    wire [6:0] tri2_gnote_velocity;
    wire [1:0] tri2_gnote_type;
    wire [1:0] tri2_gnote_effect;
    wire [19:0] tri2_step_size;
    wire tri2_output_sample;
    wire [15:0] tri2_sample_raw;
    wire tri2_empty;
    wire [7:0] tri2_sample;
    ChannelReader tri2_cr(clock, reset, on_playing, song, reset_player, tri2_empty, tri2_new_address,
                          tri2_note_tune, tri2_note_duration, tri2_note_velocity, tri2_note_type, tri2_note_effect,
                          tri2_new_note, tri2_note_done, tri2_note_read, tri2_note_info, tri2_address);
    tri2_rom tri2_sr(clock, tri2_note_info, tri2_address);
    tri2_pos_rom(clock, song, tri2_new_address);
    NotePlayer tri2_np(clock, clk48kHz, reset, on_playing, song_speed,
                       tri2_note_tune, tri2_note_duration, tri2_note_velocity, tri2_note_type, tri2_note_effect,
                       tri2_new_note, tri2_note_done, tri2_note_read,
                       tri2_gnote_velocity, tri2_gnote_type, tri2_gnote_effect,
                       tri2_step_size, tri2_output_sample, tri2_sample_raw, tri2_sample);
    TriangleGenerator tri2_g(clk48kHz, reset, tri2_gnote_velocity, tri2_gnote_type, tri2_gnote_effect,
                             tri2_step_size, tri2_output_sample, tri2_sample_raw);
    //CHANNEL 8 - TRIANGLE 3
    wire [6:0] tri3_note_tune;
    wire [7:0] tri3_note_duration;
    wire [6:0] tri3_note_velocity;
    wire [1:0] tri3_note_type;
    wire [25:0] tri3_note_info;
    wire [11:0] tri3_address;
    wire [15:0] tri3_new_address;
    wire [1:0] tri3_note_effect;
    wire tri3_new_note, tri3_note_done, tri3_note_read;
    wire [6:0] tri3_gnote_velocity;
    wire [1:0] tri3_gnote_type;
    wire [1:0] tri3_gnote_effect;
    wire [19:0] tri3_step_size;
    wire tri3_output_sample;
    wire [15:0] tri3_sample_raw;
    wire tri3_empty;
    wire [7:0] tri3_sample;
    ChannelReader tri3_cr(clock, reset, on_playing, song, reset_player, tri3_empty, tri3_new_address,
                          tri3_note_tune, tri3_note_duration, tri3_note_velocity, tri3_note_type, tri3_note_effect,
                          tri3_new_note, tri3_note_done, tri3_note_read, tri3_note_info, tri3_address);
    tri3_rom tri3_sr(clock, tri3_note_info, tri3_address);
    tri3_pos_rom(clock, song, tri3_new_address);
    NotePlayer tri3_np(clock, clk48kHz, reset, on_playing, song_speed,
                       tri3_note_tune, tri3_note_duration, tri3_note_velocity, tri3_note_type, tri3_note_effect,
                       tri3_new_note, tri3_note_done, tri3_note_read,
                       tri3_gnote_velocity, tri3_gnote_type, tri3_gnote_effect,
                       tri3_step_size, tri3_output_sample, tri3_sample_raw, tri3_sample);
    TriangleGenerator tri3_g(clk48kHz, reset, tri3_gnote_velocity, tri3_gnote_type, tri3_gnote_effect,
                             tri3_step_size, tri3_output_sample, tri3_sample_raw);
    //CHANNEL 9 - SAW 1
    wire [6:0] saw1_note_tune;
    wire [7:0] saw1_note_duration;
    wire [6:0] saw1_note_velocity;
    wire [1:0] saw1_note_type;
    wire [25:0] saw1_note_info;
    wire [15:0] saw1_new_address;
    wire [11:0] saw1_address;
    wire [1:0] saw1_note_effect;
    wire saw1_new_note, saw1_note_done, saw1_note_read;
    wire [6:0] saw1_gnote_velocity;
    wire [1:0] saw1_gnote_type;
    wire [1:0] saw1_gnote_effect;
    wire [19:0] saw1_step_size;
    wire saw1_output_sample;
    wire [15:0] saw1_sample_raw;
    wire saw1_empty;
    wire [7:0] saw1_sample;
    ChannelReader saw1_cr(clock, reset, on_playing, song, reset_player, saw1_empty, saw1_new_address,
                          saw1_note_tune, saw1_note_duration, saw1_note_velocity, saw1_note_type, saw1_note_effect,
                          saw1_new_note, saw1_note_done, saw1_note_read, saw1_note_info, saw1_address);
    saw1_rom saw1_sr(clock, saw1_note_info, saw1_address);
    saw1_pos_rom(clock, song, saw1_new_address);
    NotePlayer saw1_np(clock, clk48kHz, reset, on_playing, song_speed,
                       saw1_note_tune, saw1_note_duration, saw1_note_velocity, saw1_note_type, saw1_note_effect,
                       saw1_new_note, saw1_note_done, saw1_note_read,
                       saw1_gnote_velocity, saw1_gnote_type, saw1_gnote_effect,
                       saw1_step_size, saw1_output_sample, saw1_sample_raw, saw1_sample);
    SawGenerator saw1_g(clk48kHz, reset, saw1_gnote_velocity, saw1_gnote_type, saw1_gnote_effect,
                        saw1_step_size, saw1_output_sample, saw1_sample_raw);
    //CHANNEL 10 - DRUMS
    wire [6:0] drums_note_tune;
    wire [7:0] drums_note_duration;
    wire [6:0] drums_note_velocity;
    wire [1:0] drums_note_type;
    wire [25:0] drums_note_info;
    wire [15:0] drums_new_address;
    wire [11:0] drums_address;
    wire [1:0] drums_note_effect;
    wire drums_new_note, drums_note_done, drums_note_read;
    wire drums_gnote_new;
    wire [6:0] drums_gnote_velocity;
    wire [1:0] drums_gnote_type;
    wire [1:0] drums_gnote_effect;
    wire [6:0] drums_gnote_tune;
    wire drums_output_sample;
    wire [7:0] drums_sample_raw;
    wire drums_empty;
    wire [7:0] drums_sample;
    ChannelReader drums_cr(clock, reset, on_playing, song, reset_player, drums_empty, drums_new_address,
                          drums_note_tune, drums_note_duration, drums_note_velocity, drums_note_type, drums_note_effect,
                          drums_new_note, drums_note_done, drums_note_read, drums_note_info, drums_address);
    drums_rom drums_sr(clock, drums_note_info, drums_address);
    drums_pos_rom(clock, song, drums_new_address);
    NotePlayer_Drums drums_np(clock, clk48kHz, reset, on_playing, song_speed,
                             drums_note_tune, drums_note_duration, drums_note_velocity, drums_note_type, drums_note_effect,
                             drums_new_note, drums_note_done, drums_note_read, drums_gnote_new,
                             drums_gnote_tune, drums_gnote_velocity, drums_gnote_type, drums_gnote_effect,
                             drums_output_sample, drums_sample_raw, drums_sample);
    DrumsGenerator drums_g(clk48kHz, reset, drums_gnote_tune, drums_gnote_velocity, drums_gnote_type, drums_gnote_effect,
                        drums_gnote_new, drums_output_sample, drums_sample_raw);
    //CHANNEL 11 - SAW 2
    wire [6:0] saw2_note_tune;
    wire [7:0] saw2_note_duration;
    wire [6:0] saw2_note_velocity;
    wire [1:0] saw2_note_type;
    wire [25:0] saw2_note_info;
    wire [15:0] saw2_new_address;
    wire [11:0] saw2_address;
    wire [1:0] saw2_note_effect;
    wire saw2_new_note, saw2_note_done, saw2_note_read;
    wire [6:0] saw2_gnote_velocity;
    wire [1:0] saw2_gnote_type;
    wire [1:0] saw2_gnote_effect;
    wire [19:0] saw2_step_size;
    wire saw2_output_sample;
    wire [15:0] saw2_sample_raw;
    wire saw2_empty;
    wire [7:0] saw2_sample;
    ChannelReader saw2_cr(clock, reset, on_playing, song, reset_player, saw2_empty, saw2_new_address,
                          saw2_note_tune, saw2_note_duration, saw2_note_velocity, saw2_note_type, saw2_note_effect,
                          saw2_new_note, saw2_note_done, saw2_note_read, saw2_note_info, saw2_address);
    saw2_rom saw2_sr(clock, saw2_note_info, saw2_address);
    saw2_pos_rom(clock, song, saw2_new_address);
    NotePlayer saw2_np(clock, clk48kHz, reset, on_playing, song_speed,
                       saw2_note_tune, saw2_note_duration, saw2_note_velocity, saw2_note_type, saw2_note_effect,
                       saw2_new_note, saw2_note_done, saw2_note_read,
                       saw2_gnote_velocity, saw2_gnote_type, saw2_gnote_effect,
                       saw2_step_size, saw2_output_sample, saw2_sample_raw, saw2_sample);
    SawGenerator saw2_g(clk48kHz, reset, saw2_gnote_velocity, saw2_gnote_type, saw2_gnote_effect,
                        saw2_step_size, saw2_output_sample, saw2_sample_raw);
    //CHANNEL 12 - SAW 3
    wire [6:0] saw3_note_tune;
    wire [7:0] saw3_note_duration;
    wire [6:0] saw3_note_velocity;
    wire [1:0] saw3_note_type;
    wire [25:0] saw3_note_info;
    wire [15:0] saw3_new_address;
    wire [11:0] saw3_address;
    wire [1:0] saw3_note_effect;
    wire saw3_new_note, saw3_note_done, saw3_note_read;
    wire [6:0] saw3_gnote_velocity;
    wire [1:0] saw3_gnote_type;
    wire [1:0] saw3_gnote_effect;
    wire [19:0] saw3_step_size;
    wire saw3_output_sample;
    wire [15:0] saw3_sample_raw;
    wire saw3_empty;
    wire [7:0] saw3_sample;
    ChannelReader saw3_cr(clock, reset, on_playing, song, reset_player, saw3_empty, saw3_new_address,
                          saw3_note_tune, saw3_note_duration, saw3_note_velocity, saw3_note_type, saw3_note_effect,
                          saw3_new_note, saw3_note_done, saw3_note_read, saw3_note_info, saw3_address);
    saw3_rom saw3_sr(clock, saw3_note_info, saw3_address);
    saw3_pos_rom(clock, song, saw3_new_address);
    NotePlayer saw3_np(clock, clk48kHz, reset, on_playing, song_speed,
                       saw3_note_tune, saw3_note_duration, saw3_note_velocity, saw3_note_type, saw3_note_effect,
                       saw3_new_note, saw3_note_done, saw3_note_read,
                       saw3_gnote_velocity, saw3_gnote_type, saw3_gnote_effect,
                       saw3_step_size, saw3_output_sample, saw3_sample_raw, saw3_sample);
    SawGenerator saw3_g(clk48kHz, reset, saw3_gnote_velocity, saw3_gnote_type, saw3_gnote_effect,
                        saw3_step_size, saw3_output_sample, saw3_sample_raw);
    //CHANNEL 14 - LEAD 1 (with LED display)
    wire [6:0] lead1_note_tune;
    wire [7:0] lead1_note_duration;
    wire [6:0] lead1_note_velocity;
    wire [1:0] lead1_note_type;
    wire [25:0] lead1_note_info;
    wire [15:0] lead1_new_address;
    wire [11:0] lead1_address;
    wire [1:0] lead1_note_effect;
    wire lead1_new_note, lead1_note_done, lead1_note_read;
    wire [6:0] lead1_gnote_velocity;
    wire [1:0] lead1_gnote_type;
    wire [1:0] lead1_gnote_effect;
    wire [19:0] lead1_step_size;
    wire lead1_output_sample;
    wire [15:0] lead1_sample_raw;
    wire lead1_empty;
    wire [7:0] lead1_sample;
    ChannelReader lead1_cr(clock, reset, on_playing, song, reset_player, song_done, lead1_new_address,
                          lead1_note_tune, lead1_note_duration, lead1_note_velocity, lead1_note_type, lead1_note_effect,
                          lead1_new_note, lead1_note_done, lead1_note_read, lead1_note_info, lead1_address, debug);
    lead1_rom lead1_sr(clock, lead1_note_info, lead1_address);
    lead1_pos_rom(clock, song, lead1_new_address);
    NotePlayer lead1_np(clock, clk48kHz, reset, on_playing, song_speed,
                       lead1_note_tune, lead1_note_duration, lead1_note_velocity, lead1_note_type, lead1_note_effect,
                       lead1_new_note, lead1_note_done, lead1_note_read,
                       lead1_gnote_velocity, lead1_gnote_type, lead1_gnote_effect,
                       lead1_step_size, lead1_output_sample, lead1_sample_raw, lead1_sample);
    Lead1Generator lead1_g(clk48kHz, reset, lead1_gnote_velocity, lead1_gnote_type, lead1_gnote_effect,
                           lead1_step_size, lead1_output_sample, lead1_sample_raw);
    //string_display2 display(lead1_address, clock, displaypick, addressdisplay);
    //CHANNEL 15 - LEAD 2
    wire [6:0] lead2_note_tune;
    wire [7:0] lead2_note_duration;
    wire [6:0] lead2_note_velocity;
    wire [1:0] lead2_note_type;
    wire [25:0] lead2_note_info;
    wire [15:0] lead2_new_address;
    wire [11:0] lead2_address;
    wire lead2_note_effect;
    wire lead2_new_note, lead2_note_done, lead2_note_read;
    wire [6:0] lead2_gnote_velocity;
    wire [1:0] lead2_gnote_type;
    wire [1:0] lead2_gnote_effect;
    wire [19:0] lead2_step_size;
    wire lead2_output_sample;
    wire [15:0] lead2_sample_raw;
    wire lead2_empty;
    wire [7:0] lead2_sample;
    ChannelReader lead2_cr(clock, reset, on_playing, song, reset_player, lead2_empty, lead2_new_address,
                          lead2_note_tune, lead2_note_duration, lead2_note_velocity, lead2_note_type, lead2_note_effect,
                          lead2_new_note, lead2_note_done, lead2_note_read, lead2_note_info, lead2_address);
    lead2_rom lead2_sr(clock, lead2_note_info, lead2_address);
    lead2_pos_rom(clock, song, lead2_new_address);
    NotePlayer lead2_np(clock, clk48kHz, reset, on_playing, song_speed,
                       lead2_note_tune, lead2_note_duration, lead2_note_velocity, lead2_note_type, lead2_note_effect,
                       lead2_new_note, lead2_note_done, lead2_note_read,
                       lead2_gnote_velocity, lead2_gnote_type, lead2_gnote_effect,
                       lead2_step_size, lead2_output_sample, lead2_sample_raw, lead2_sample);
    Lead2Generator lead2_g(clk48kHz, reset, lead2_gnote_velocity, lead2_gnote_type, lead2_gnote_effect,
                           lead2_step_size, lead2_output_sample, lead2_sample_raw);
    //ADDER
    Adder(song, pulse1_sample, pulse2_sample, pulse3_sample, pulse4_sample, pulse5_sample, tri1_sample, tri2_sample, tri3_sample, 
          saw1_sample, drums_sample, saw2_sample, saw3_sample, lead1_sample, lead2_sample, sample);
    assign song_playing = song;
    assign speed_output = song_speed[1:0];
    assign play_status = on_playing;
    assign debugdisplay = debug;
endmodule
