# project name
name Project0
# execution graph
job 8   -post { extract_vars "$wdir" n8_dvs.out 8; waiting "$wdir" 8 dvs }  -o n8_dvs "sde -e -l n8_dvs.cmd"
job 97 -d "95"  -post { extract_vars "$wdir" n97_ins.out 97; waiting "$wdir" 97 ins }  -o n97_ins "inspect -f pp97_ins.cmd"
job 95 -d "8"  -post { extract_vars "$wdir" n95_des.out 95; waiting "$wdir" 95 des }  -o n95_des "sdevice pp95_des.cmd"
check sde_dvs.cmd 1509337692
check sdevice_des.cmd 1509337692
check sdevice.par 1509337692
check inspect_ins.cmd 1509337692
check global_tooldb 1454976766
check gtree.dat 1509337692
check gtooldb.tcl 1509337692
# included files
