@echo off
set project_path=.\test
set author_name=admin
set version=V2.3.4
vivado -mode batch -notrace -nolog -nojournal -source .\DancingLine.tcl -tclargs --prj_path %project_path% --author %author_name% --version %version%