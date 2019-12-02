# Structure Overview 
```
.    
├── DancingLine.tcl  // TCL脚本  
├── README.md  //本文件  
├── bit  // 可用的bitstream    
│   ├── test-use.bit // debug使用   
│   └── turn_point_reconstructed.bit // 展示使用    
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
├── runme.bat  // 生成Vivado项目的脚本，可自定义贡献者、版本号等  
└── src  // 主要源代码部分  
    ├── audio  // 音频  
    │   └── string_displays.v    
    ├── misc  // 杂项  
    │   ├── PS2keyboard.v    
    │   ├── fre_div.v    
    │   └── misc.v    
    ├── top.v  // 主模块  
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
    │   ├── vgaPlay.v       
    │   └── vga_timing.v    
    └── xdc  // 约束文件  
        └── DancingLine.xdc  
```
# How to set-up using Vivado TCL
## 1. Clone the project
>You may download zip or clone like this:
```
git clone https://github.com/johnzchgrd/FPGA-based-Dancing-Line-like-Game.git
```
## 2. Create Vivado Project (Project Mode)

>modify [runme.bat]([./runme.bat](https://github.com/johnzchgrd/FPGA-based-Dancing-Line-like-Game/blob/master/runme.bat)) with your own name and other stuffs.
Then run:
```
.\runme.bat
```
>This will create a Vivado project in the project dir (which is, by default, ".\test"). Then you could open .xpr or using command line as you like.

>Note that if the path characters __exceed__ 260(according to different OS version), vivado cannot create the project correctly.

# How to contribute
### 1. Create the porject and debug...
>You are welcomed to pull any request reasonable or any problem encountered while doing this project.
### 2. Commit using git (please do not upload your project)
>Because in the tcl file, we have set that vivado will ___not___ import files into the project source directory, so and changes you applied in the text editor of Vivado [or your own] will directly change the file in the root directory.
```
git add . 
git commit . -m "put some comment here"
git push github_upload master[or other branch that exists]
```

# Special Thanks
>NOTE: This part will update when the competition is finished.
## Fellows
>_We kept in good communication while doing this project.I still remember those days we debug together till midnight. We will both cherish this period of fighting as a team._
---
### xxx
>who designed and implemented music player part.
### yyy
>who provided good-looking fonts, implemented progress display part and other tools.
### zzz
>who designed and implemented video player part.
## Academic Advisor
### __AAA__