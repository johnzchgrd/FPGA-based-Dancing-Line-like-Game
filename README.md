### Structure  
.    
├── DancingLine.tcl    
├── README.md    
├── bit  // 可用的bitstream    
│   ├── test-use.bit    
│   └── turn_point_reconstructed.bit    
├── ip  // MusicPlayer模块使用自定义IP的模式进行独立的synthesis    
│   ├── MusicPlayer.v    
│   ├── component.xml      
│   ├── crash_rom.v        
│   ├── drums_rom.v        
│   ├── frequency_rom.v    
│   ├── hat_rom.v          
│   ├── kick_rom.v         
│   ├── lead1_rom.v        
│   ├── lead2_rom.v        
│   ├── lead_rom.v         
│   ├── pulse1_rom.v      
│   ├── pulse2_rom.v       
│   ├── pulse3_rom.v    
│   ├── pulse4_rom.v    
│   ├── pulse5_rom.v    
│   ├── saw1_rom.v    
│   ├── saw2_rom.v    
│   ├── saw3_rom.v    
│   ├── sine_rom.v    
│   ├── snare_rom.v    
│   ├── songpos_rom.v    
│   ├── triangle1_rom.v    
│   ├── triangle2_rom.v    
│   ├── triangle3_rom.v    
│   └── xgui    
│       ├── MusicPlayer_forDL_v1_1.tcl    
│       └── MusicPlayer_v1_0.tcl    
├── runme.bat  // 暂时传参有问题但能生成Vivado项目的脚本  
└── src  // 主要源代码部分  
    ├── audio  // 音频  
    │   └── string_displays.v    
    ├── misc  // 杂项  
    │   ├── PS2keyboard.v    
    │   ├── fre_div.v    
    │   └── misc.v    
    ├── top.v    
    ├── video  // 视频  
    │   ├── VideoPlayer.v    
    │   ├── dotper_rom.v    
    │   ├── getPixel.v    
    │   ├── getpixel_songname.v    
    │   ├── getpixel_songsel.v    
    │   ├── hint_font_rom.v    
    │   ├── hint_songsel_rom.v    
    │   ├── image_rom.v    
    │   ├── map_rom.v    
    │   ├── number_rom.v    
    │   ├── vgaAnimate.v    
    │   ├── vgaChooseSong.v    
    │   ├── vgaMenu_deprecated.v    
    │   ├── vgaPlay.v    
    │   ├── vga_menu_rom_deprecated.v    
    │   └── vga_timing.v    
    └── xdc  // 约束文件  
        └── DancingLine.xdc  
