#
#--------------------------------------------
#          Script / Workspace Setup
#--------------------------------------------
# important settings, deal carefully
set project_path  "../"
set prjVersion    "V0.0.0"
set author        "default"
#*******************************************
# SHOULD NOT change commands below
#*******************************************
set date          [clock format [clock seconds] -format "%m%d"]
set part          "xc7a35tcsg324-1"
set project_name  "DancingLine_$prjVersion\_$author\_$date"
set xdcName       "DancingLine"
set top_name      "top"

set origin_dir    "./src"
set topPath       "$origin_dir/$top_name.v"
set audioDir      "$origin_dir/audio"
set videoDir      "$origin_dir/video"
set miscDir       "$origin_dir/misc"
set ipDir         "$origin_dir/../ip"
set constrPath    "$origin_dir/xdc/$xdcName.xdc"

set jobs_number   8
set ip_synth      0

# Use origin directory path location variable, if specified in the tcl shell
if { [info exists ::origin_dir_loc] } {
  set origin_dir $::origin_dir_loc
}

# Use project name variable, if specified in the tcl shell
if { [info exists ::user_project_name] } {
  set project_name $::user_project_name
}

variable script_file
set script_file "DancingLine.tcl"

# Help information for this script
proc help {} {
  variable script_file
  puts "\nDescription:"
  puts "\tUsed for XXX One only. \n"
  puts "Syntax:"
  puts "$script_file"
  puts "$script_file -tclargs \[--origin_dir <path>\]"
  puts "$script_file -tclargs \[--prj_path <path>\]"
  puts "$script_file -tclargs \[--author\]\n"
  puts "$script_file -tclargs \[--version\]\n"
  puts "$script_file -tclargs \[--ip_synth\]\n"
  puts "$script_file -tclargs \[--help\]\n"
  puts "Usage:"
  puts "Name                   Description"
  puts "-------------------------------------------------------------------------"
  puts "\[--origin_dir <path>\]  Determine source file paths. Default"
  puts "                       value is \"./src\"\n"
  puts "\[--prj_path <path>\]  Determine where the project you want to place.\n"
  puts "\[--author\]            set project version. Whatever string you like."
  puts "\[--version\]            set project version. Whatever string you like."
  puts "                       Recommended something like \"Vx.x\"\n"
  puts "\[--ip_synth\]        If you'd like to generate ip within the commandline,\n"
  puts "                      set this option as 1.\n"
  puts "\[--help\]               Print this information😅"
  puts "-------------------------------------------------------------------------\n"
  exit 0
}

if { $::argc > 0 } {
  for {set i 0} {$i < [llength $::argc]} {incr i} {
    set option [string trim [lindex $::argv $i]]
    switch -regexp -- $option {
      "--origin_dir"   { incr i; set origin_dir [lindex $::argv $i] }
      "--version"   { incr i; set prjVersion [lindex $::argv $i] }
      "--author"    { incr i; set author [lindex $::argv $i] }
      "--prj_path"  { incr i; set project_path [lindex $::argv $i] }
      "--ip_synth"  { incr i; set ip_synth [lindex $::argv $i] }
      "--help"         { help }
      default {
        if { [regexp {^-} $option] } {
          puts "ERROR: Unknown option '$option' specified, please type '$script_file -tclargs --help' for usage info.\n"
          return 1
        }
      }
    }
  }
}


# Create project
create_project -force ${project_name} ${project_path}/${project_name} -part $part

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Reconstruct message rules
# None

# Set project properties
set obj [current_project]
set_property -name "default_lib" -value "xil_defaultlib" -objects $obj
set_property -name "dsa.num_compute_units" -value "60" -objects $obj
set_property -name "ip_cache_permissions" -value "read write" -objects $obj
set_property -name "ip_output_repo" -value "$proj_dir/${project_name}.cache/ip" -objects $obj
set_property -name "part" -value $part -objects $obj
set_property -name "sim.ip.auto_export_scripts" -value "1" -objects $obj
set_property -name "simulator_language" -value "Mixed" -objects $obj
set_property -name "xpm_libraries" -value "XPM_CDC" -objects $obj

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set IP repository paths
set obj [get_filesets sources_1]
set_property "ip_repo_paths" "[file normalize "$ipDir"]" $obj

# Rebuild user ip_repo's index before adding any source files
update_ip_catalog -rebuild

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
# Import local files from the specific dir
set files [list \
 "[file normalize "$topPath"]"\
 "[file normalize "$miscDir/PS2keyboard.v"]"\
 "[file normalize "$miscDir/misc.v"]"\
 "[file normalize "$miscDir/fre_div.v"]"\
 "[file normalize "$audioDir/string_displays.v"]"\
 "[file normalize "$videoDir/image_rom.v"]"\
 "[file normalize "$videoDir/dotper_rom.v"]"\
 "[file normalize "$videoDir/getpixel_songname.v"]"\
 "[file normalize "$videoDir/getpixel_songsel.v"]"\
 "[file normalize "$videoDir/getPixel.v"]"\
 "[file normalize "$videoDir/hint_font_rom.v"]"\
 "[file normalize "$videoDir/hint_songsel_rom.v"]"\
 "[file normalize "$videoDir/map_rom.v"]"\
 "[file normalize "$videoDir/number_rom.v"]"\
 "[file normalize "$videoDir/vgaChooseSong.v"]"\
 "[file normalize "$videoDir/vgaPlay.v"]"\
 "[file normalize "$videoDir/vga_timing.v"]"\
 "[file normalize "$videoDir/vgaMenu_deprecated.v"]"\
 "[file normalize "$videoDir/vga_menu_rom_deprecated.v"]"\
 "[file normalize "$videoDir/vgaAnimate.v"]"\
 "[file normalize "$videoDir/VideoPlayer.v"]"\
]
set imported_files [import_files -fileset sources_1 $files]

# Set 'sources_1' fileset properties
set obj [get_filesets sources_1]
set_property -name "top" -value $top_name -objects $obj

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Add/Import constrs file and set constrs file properties
set file "[file normalize $constrPath]"
set file_imported [import_files -fileset constrs_1 $file]
# set file $constrPath
# set file_obj [get_files -of_objects [get_filesets constrs_1] [list "*$file"]]
# set_property -name "file_type" -value "XDC" -objects $file_obj

# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Set 'sim_1' fileset object
set obj [get_filesets sim_1]
# Empty (no sources present)

# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property -name "top" -value $top_name -objects $obj

puts "INFO: Project created at ${proj_dir}/$project_name"
# report_property [current_project]

#--------------------------------------------
#          IP Setup
#--------------------------------------------
puts "INFO: Start to set up ips..."
set prj_prefix "${proj_dir}/${project_name}"

# # create 25MHz clk ip inst.
# create_ip -name clk_wiz -vendor xilinx.com -library ip -version 5.4 -module_name clk_25mhz
# set_property -dict [list CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {25.000} CONFIG.USE_LOCKED {false} CONFIG.MMCM_DIVCLK_DIVIDE {1} CONFIG.MMCM_CLKFBOUT_MULT_F {9.125} CONFIG.MMCM_CLKOUT0_DIVIDE_F {36.500} CONFIG.CLKOUT1_JITTER {181.828} CONFIG.CLKOUT1_PHASE_ERROR {104.359}] [get_ips clk_25mhz]
# generate_target {instantiation_template} [get_files  "${prj_prefix}.srcs/sources_1/ip/clk_25mhz/clk_25mhz.xci"]

# create MusicPlayer ip inst.
create_ip -name MusicPlayer_forDL -vendor szgGroup1 -library user -version 1.1 -module_name MusicPlayer_forDL_0;# -dir ${prj_prefix}.srcs/sources_1/ip
generate_target {instantiation_template} [get_files "${prj_prefix}.srcs/sources_1/ip/MusicPlayer_forDL_0/MusicPlayer_forDL_0.xci"]

puts "INFO: $project_name is generated with ip included."


# # run ip synths as set
# if {[string equal $ip_synth "1"]}{
#   puts "INFO: start generating IPs ..."
# generate_target all [get_files  "${prj_prefix}.srcs/sources_1/ip/clk_25mhz/clk_25mhz.xci"]
# catch { config_ip_cache -export [get_ips -all clk_25mhz] }
# export_ip_user_files -of_objects [get_files "${prj_prefix}.srcs/sources_1/ip/clk_25mhz/clk_25mhz.xci"] -no_script -sync -force -quiet
# create_ip_run [get_files -of_objects [get_fileset sources_1] "${prj_prefix}.srcs/sources_1/ip/clk_25mhz/clk_25mhz.xci"]
# export_simulation -of_objects [get_files "${prj_prefix}.srcs/sources_1/ip/clk_25mhz/clk_25mhz.xci"]\
#  -directory "${prj_prefix}.ip_user_files/sim_scripts" -ip_user_files_dir "${prj_prefix}.ip_user_files" \
#  -ipstatic_source_dir "${prj_prefix}.ip_user_files/ipstatic" \
#  -lib_map_path [list \
#   {modelsim="${prj_prefix}.cache/compile_simlib/modelsim"} \
#   {questa="${prj_prefix}.cache/compile_simlib/questa"}\
#   {riviera="${prj_prefix}.cache/compile_simlib/riviera"} \
#   {activehdl="${prj_prefix}.cache/compile_simlib/activehdl"}\
#   ] -use_ip_compiled_libs -force -quiet
# #################
# generate_target all [get_files  ${prj_prefix}.srcs/sources_1/ip/clk_25mhz/clk_25mhz.xci]
# catch { config_ip_cache -export [get_ips -all clk_25mhz] }
# export_ip_user_files -of_objects [get_files ${prj_prefix}.srcs/sources_1/ip/clk_25mhz/clk_25mhz.xci] -no_script -sync -force -quiet
# # create_ip_run [get_files -of_objects [get_fileset sources_1] ${prj_prefix}.srcs/sources_1/ip/clk_25mhz/clk_25mhz.xci]
# launch_runs -jobs $jobs_number clk_25mhz_synth_1
# export_simulation -of_objects [get_files ${prj_prefix}.srcs/sources_1/ip/clk_25mhz/clk_25mhz.xci] -directory ${prj_prefix}.cache/compile_simlib/activehdl}] -use_ip_compiled_libs -force -quiet
# }
