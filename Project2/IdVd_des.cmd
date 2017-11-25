#if @IdVd@ == 0
#noexec
#endif

!( 
if { "@Type@"  == "nMOS" } {
  set SIGN   1.0  
  set DG     "eQuantumPotential"
  set cTemp  "eTemperature"
  set EQN0   "Poisson eQuantumPotential Electron Hole"
  set EQNS   "Poisson eQuantumPotential Electron Hole Temperature eTemperature"
} else {
  set SIGN   -1.0
  set DG     "hQuantumPotential"
  set cTemp  "hTemperature"
  set EQN0   "Poisson hQuantumPotential Electron Hole"
  set EQNS   "Poisson hQuantumPotential Electron Hole Temperature hTemperature"
}
)!

File {
   * input files:
   Grid=   "@tdr@"
   Parameter="@parameter@"
   * output files:
   Plot=   "@tdrdat@"
   Current="@plot@"
   Output= "@log@"
}

Electrode {
   { Name="source"    Voltage= 0.0 Resistor= 40 }
   { Name="drain"     Voltage= 0.0 Resistor= 40 }
   { Name="gate"      Voltage= 0.0 }
   { Name="substrate" Voltage= 0.0 }
}

Thermode{
   { Name="substrate" Temperature= 300 } 
}

Physics{
   Hydrodynamic(!(puts $cTemp)! )
   EffectiveIntrinsicDensity(BandGapNarrowing ( OldSlotboom ))      
}

Physics(Material="Silicon"){
   !(puts $DG)!
   Mobility(
      PhuMob
	  HighFieldSaturation
      Enormal
   )
   Recombination(
      SRH( DopingDependence )
      Band2Band
   )
}

Insert= "PlotSection_des.cmd"
Insert= "MathSection_des.cmd"

Solve {
*- Creating initial guess:
   Coupled(Iterations= 100 LineSearchDamping= 1e-4){ Poisson !(puts $DG)! } 
   Coupled { !(puts $EQN0)! }
   Coupled { !(puts $EQNS)! }

*- Ramp to gate to Vgmax
   Quasistationary( 
      InitialStep= 1e-5 Increment= 2 
      MinStep= 1e-6 MaxStep= 0.5 
      Goal { Name="gate" Voltage=!(puts [expr $SIGN*@Vgmax@])!} 
   ){ Coupled { !(puts $EQNS)! }  
      Save( FilePrefix="IdVd_n@node@" NoOverWrite
!( 
  set TIMES "Time=("
  for { set i 1 } { $i < @NVg@ } { incr i } {
    set dV [expr (@Vgmax@-@Vgmin@)/(@NVg@-1.0)]
    set Time [expr (@Vgmin@ + ($i-1)*$dV)/@Vgmax@]
    append TIMES "[format %.2f ${Time}];"
  }
  set Time 1.0
  append TIMES "[format %.2f ${Time}]) )"
  puts $TIMES
)!
   }

*- Vd sweeps 
!(
  for { set i 0 } { $i < @NVg@ } { incr i } {
  set Number [format "%04d" $i]
  puts "
    NewCurrentFile=\"IdVd_${i}_\" 
    Load(FilePrefix=\"IdVd_n@node@_$Number\")
    Quasistationary( 
      DoZero 
      InitialStep=1e-3 Increment=1.5 
      MinStep=1e-5 MaxStep=0.05 
      Goal \{ Name=\"drain\" Voltage=[expr $SIGN*@Vdd@] \}
    )\{ Coupled \{ $EQNS \}
      CurrentPlot( Time=(Range=(0 1) Intervals=20) )
   \}"
  }
)!

}


