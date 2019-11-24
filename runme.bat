::NOTE this batch nay not work correctly
@echo off
set project_path=.\test
set author_name=admin
set if_generate_ip=0
vivado -mode batch -notrace -nolog -nojournal -source .\DancingLine.tcl -tclargs --prj_path %project_path% --author %author_name% --version V2.3.0 --ip_synth %if_generate_ip%