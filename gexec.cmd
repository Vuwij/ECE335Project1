# project name
name Project1
# execution graph
job 97 -d "95"  -post { extract_vars "$wdir" n97_ins.out 97; waiting "$wdir" 97 ins }  -o n97_ins "inspect -f pp97_ins.cmd"
job 95 -d "98"  -post { extract_vars "$wdir" n95_des.out 95; waiting "$wdir" 95 des }  -o n95_des "sdevice pp95_des.cmd"
job 98   -post { extract_vars "$wdir" n98_dvs.out 98; waiting "$wdir" 98 dvs }  -o n98_dvs "sde -e -l n98_dvs.cmd"
check sde_dvs.cmd 1509336772
check sde_dvs.bnd 1509255844
check sdevice_des.cmd 1509429345
check sdevice.par 1509337692
check inspect_ins.cmd 1509420433
check global_tooldb 1454976766
check gtree.dat 1509429112
check gtooldb.tcl 1509205108
# included files
