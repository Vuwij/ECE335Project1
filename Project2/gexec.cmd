# project name
name Project2
# execution graph
job 3   -post { extract_vars "$wdir" n3_dvs.out 3; waiting "$wdir" 3 dvs }  -o n3_dvs "sde -e -l n3_dvs.cmd"
job 7 -d "3"  -post { extract_vars "$wdir" n7_des.out 7; waiting "$wdir" 7 des }  -o n7_des "sdevice pp7_des.cmd"
job 8 -d "7"  -post { extract_vars "$wdir" n8_vis.out 8; waiting "$wdir" 8 vis }  -o n8_vis "svisual n8_vis.tcl"
job 10 -d "3"  -post { extract_vars "$wdir" n10_des.out 10; waiting "$wdir" 10 des }  -o n10_des "sdevice pp10_des.cmd"
job 11 -d "10"  -post { extract_vars "$wdir" n11_vis.out 11; waiting "$wdir" 11 vis }  -o n11_vis "svisual n11_vis.tcl"
job 16 -d "3"  -post { extract_vars "$wdir" n16_des.out 16; waiting "$wdir" 16 des }  -o n16_des "sdevice pp16_des.cmd"
job 17 -d "16"  -post { extract_vars "$wdir" n17_vis.out 17; waiting "$wdir" 17 vis }  -o n17_vis "svisual n17_vis.tcl"
check sde_dvs.cmd 1509205108
check sde_dvs.bnd 1509257092
check IdVg_lin_des.cmd 1509205108
check sdevice.par 1509205108
check PlotIdVg_lin_vis.tcl 1509205108
check IdVg_sat_des.cmd 1509205108
check PlotIdVg_sat_vis.tcl 1509205108
check IdVd_des.cmd 1509205108
check PlotIdVd_vis.tcl 1509205108
check global_tooldb 1454976766
check gtree.dat 1509205108
check gtooldb.tcl 1509205108
check Si.par 1509205108
# included files
file sdevice.par included Si.par
