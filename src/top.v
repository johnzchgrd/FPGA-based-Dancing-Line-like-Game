`timescale 1ns / 1ps

module top(
    // general
    input        clk,
    input        reset_raw,
    // for vga
    input        debug_switch,
	output       hsync,
    output       vsync,
    output [3:0] r,
    output [3:0] g,
    output [3:0] b,
    // ps2keyboard
    input        ps2_clk,
    input        ps2_data,
    // display
    output [1:0] song_LED,
    output [2:0] speed_LED,
    output [7:0] sample,
    output       ILE,
    // for debug usage
    output [2:0] displaypick,
    output [7:0] progressdisplay,
    output [7:0] debugdisplay,
    output [2:0] misc_debug
);

    // video
    reg menu_enabled;
    reg animate_pixel_disabled, animate_new_signal;
    wire in_animate_area, animate_finish;
    wire song_done;
    wire tips_display;
    // PS2 keyboard
    wire vk_left_raw, 
         vk_check_raw, 
         vk_right_raw, 
         vk_up_raw, 
         vk_down_raw;

    wire vk_left, 
         vk_right, 
         vk_up, 
         vk_down,
         vk_check;
    // music
    wire [2:0] mp_displaypick;
    wire [7:0] mp_addressdisplay;
    wire [2:0] music_mcu_state_display;
    wire music_song_done;
    // both
    wire reset;
    wire reset_out; // use this to enable keyboard controlled reset
    wire restart, reset_restartable; // restart instead of reset. But reset also works.
    reg  restart_raw;
    reg  [1:0] song;
    reg  play_game; // sync music and video.
    wire play_game_out;
    wire failed; // isGameOver.
    reg speed_change_enabled; // determine whether speed is changeable.
    reg  [2:0] speed_tmp, speed;
    reg  pause;
    // unused
    wire play_LED;
    wire [7:0] data;
       

    // main loop control parameters.
    parameter MAIN_STATE_START      = 0,
              MAIN_STATE_PLAYING    = 1,
              MAIN_STATE_GAMEOVER   = 2, 
              MAIN_STATE_GAMEWON    = 3, 
              MAIN_STATE_PAUSE      = 4,
              MAIN_STATE_WAIT       = 5,
              MAIN_STATE_ANIMATE    = 6;
    reg [2:0] main_state, main_state_next;

    assign reset_out = reset | vk_down;
    assign reset_restartable = reset_out | restart;
    assign ILE = 1'b1; // output signal ILE, which is ALWAYS HIGH.

    //
    // ─── MAIN FSM CONTROL SIGNAL PROCESSING ─────────────────────────────────────────
    //
    
    // whether to display playing tips
    assign tips_display = (main_state == MAIN_STATE_PAUSE) |
                          (main_state == MAIN_STATE_WAIT);

    always @(posedge clk or posedge reset_out) begin        
        if(reset_out)begin
            main_state <= MAIN_STATE_START;
            play_game <= 1'b0;
            restart_raw <= 1'b0;
            song <= 2'b11;
            animate_new_signal <= 1'b0;
            animate_pixel_disabled <= 1'b0;
            pause <= 1'b0;
        end else begin
            main_state <= main_state_next;
            if(main_state_next == MAIN_STATE_PLAYING || main_state_next == MAIN_STATE_PAUSE)
                 play_game <= 1'b1;
            else play_game <= 1'b0;
            if(main_state == MAIN_STATE_PAUSE) begin
                pause <= 1'b1;
            end else begin
                pause <= 1'b0;
            end
            
            if (main_state == MAIN_STATE_GAMEOVER && vk_up) begin
                restart_raw <= 1'b1;
            end else begin
                restart_raw <= 1'b0;
            end

            // special effect part.
            if(main_state == MAIN_STATE_ANIMATE) begin
                animate_new_signal <= 1'b1;
            end else begin
                animate_new_signal <= 1'b0;
            end

            if(main_state == MAIN_STATE_ANIMATE && in_animate_area == 1'b0) begin
                animate_pixel_disabled = 1'b1;
            end else begin
                animate_pixel_disabled = 1'b0;
                 if(main_state == MAIN_STATE_START) begin
                     menu_enabled = 1'b1;
                     speed_change_enabled = 1'b1;
                     if(vk_left) begin
                         song <= song + 2'b01;
                     end else if(vk_right) begin
                         song <= song - 2'b01;
                     end
                 end else begin
                     menu_enabled <= 1'b0;
                     speed_change_enabled = 1'b0;
                 end
            end            
        end
    end
    // speed control.
    always @(*) begin
        if (pause) begin
            speed <= 3'd0;
        end else begin
            speed <= speed_tmp;
        end
        if(speed_change_enabled) begin
            if (song == 2'b10) begin
                speed_tmp = 3'b100;     // Mangzhong: 120BPM.
            end else if (song == 2'b11) begin
                speed_tmp = 3'b010;     // Lemon: 90BPM.
            end else begin
                speed_tmp = 3'b101;     // default: 135BPM.
            end
        end
    end
    // ────────────────────────────────────────────────────────────────────────────────

    //
    // ─── MAIN FSM ───────────────────────────────────────────────────────────────────
    //

    // main FSM for game flow control.
    always @(*)begin
        case(main_state)
            MAIN_STATE_START:begin
                if(vk_check)begin
                    main_state_next = MAIN_STATE_ANIMATE;
                end else begin
                    main_state_next = MAIN_STATE_START;
                end
            end
            MAIN_STATE_ANIMATE:begin
                if(animate_finish)begin
                    main_state_next = MAIN_STATE_WAIT;
                end else begin
                    main_state_next = MAIN_STATE_ANIMATE;
                end
            end
            MAIN_STATE_WAIT:begin
                if(vk_check) begin 
                    main_state_next = MAIN_STATE_PLAYING;
                end else main_state_next = MAIN_STATE_WAIT;
            end 
            MAIN_STATE_PLAYING:begin
                if(failed)begin
                    main_state_next = MAIN_STATE_GAMEOVER;
                end else if(song_done)begin
                    main_state_next = MAIN_STATE_GAMEWON;
                end else if(vk_up) begin
                    main_state_next = MAIN_STATE_PAUSE;
                end else begin
                    main_state_next = MAIN_STATE_PLAYING;
                end
            end
            MAIN_STATE_PAUSE:begin
                if(vk_up || vk_check) main_state_next = MAIN_STATE_PLAYING;
                else main_state_next = MAIN_STATE_PAUSE;                    
            end
            MAIN_STATE_GAMEOVER:begin                    
                if(restart) main_state_next = MAIN_STATE_START;
                else main_state_next = MAIN_STATE_GAMEOVER;
            end
            MAIN_STATE_GAMEWON:begin
                if(restart) main_state_next = MAIN_STATE_START;
                else main_state_next = MAIN_STATE_GAMEWON;
            end
            default:begin
                main_state_next = MAIN_STATE_START;
            end
        endcase
    end
    // ────────────────────────────────────────────────────────────────────────────────

    //
    // ─── SUBMODULE INSTANTIATION ────────────────────────────────────────────────────
    //

    PS2keyboard pkb(
        reset,ps2_clk,ps2_data,clk,
        vk_left_raw, vk_check_raw, vk_right_raw, vk_up_raw, vk_down_raw, 
        data
        );
    
    VideoPlayer vpr(
        .reset_out                  (reset_out),
        .clk                        (clk),
        .vk_check                   (vk_check_raw),
        .reset_restartable          (reset_restartable),
        .debug_switch               (debug_switch),
        .play_game_out              (play_game_out),
        .menu_enabled               (menu_enabled),
        .animate_pixel_disabled     (animate_pixel_disabled),
        .new_signal                 (animate_new_signal),
        .tips_display               (tips_display),
        .song                       (song),
        .speed                      (speed),
        .failed                     (failed),
        .progressdisplay            (progressdisplay),
        .displaypick                (displaypick),
        .song_done                  (song_done),
        .in_animate_area            (in_animate_area),
        .animate_finish             (animate_finish),
        .hsync                      (hsync),
        .vsync                      (vsync),
        .r                          (r),
        .g                          (g),
        .b                          (b),
        .debug                      (misc_debug)
        );

    //default ip name.
    MusicPlayer_forDL_0 mp(
        clk, reset_restartable, pause, play_game_out, failed, 
        song, speed, play_LED, song_LED, speed_LED,
        sample, mp_displaypick, mp_addressdisplay, debugdisplay, 
        music_mcu_state_display, music_song_done
        );
    // ────────────────────────────────────────────────────────────────────────────────

    //
    // ─── GENERATE ONE SHOT SIGNAL ───────────────────────────────────────────────────
    //

    
    oneShot os0(
        .clk        (clk),
        .signal_in  (restart_raw),
        .signal_out (restart)
        );
    oneShot os1(
        .clk        (clk),
        .signal_in  (vk_left_raw),
        .signal_out (vk_left)
        );
    oneShot os2(
        .clk        (clk),
        .signal_in  (vk_right_raw),
        .signal_out (vk_right)
        );
    oneShot os3(
        .clk        (clk),
        .signal_in  (vk_up_raw),
        .signal_out (vk_up)
        );
    oneShot os4(
        .clk        (clk),
        .signal_in  (vk_down_raw),
        .signal_out (vk_down)
        );
    oneShot os5(
        .clk        (clk),
        .signal_in  (vk_check_raw),
        .signal_out (vk_check)
        );
    oneShot os6(
        .clk        (clk),
        .signal_in  (play_game),
        .signal_out (play_game_out)
        );
    debounce db0(
        .clk        (clk),
        .in         (reset_raw),
        .out        (reset)
        );
    // ────────────────────────────────────────────────────────────────────────────────
    
endmodule