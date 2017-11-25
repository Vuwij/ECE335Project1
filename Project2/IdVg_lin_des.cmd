#if @IdVg_lin@ == 0
#noexec
#endif

!( 
if { "@Type@"  == "nMOS" } {
  set SIGN   1.0  
  set DG     "eQuantumPotential"
  set cTemp  "eTemperature"
  set EQN0   "Poisson eQuantumPotential Electron Hole"
  set EQNS   "Poisson eQuantumPotential Electron Hole eTemperature"
} else {
  set SIGN   -1.0
  set DG     "hQuantumPotential"
  set cTemp  "hTemperature"
  set EQN0   "Poisson hQuantumPotential Electron Hole"
  set EQNS   "Poisson hQuantumPotential Electron Hole hTemperature"
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

Physics{
   Hydrodynamic( !(puts $cTemp)! )
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

*- Ramp to drain to Vd
   Quasistationary( 
      InitialStep= 1e-2 Increment= 1.35 
      MinStep= 1e-5 MaxStep= 0.2 
      Goal { Name="drain" Voltage=!(puts [expr $SIGN*@Vdlin@])! } 
   ){ Coupled { !(puts $EQNS)! } } 

*- Vg sweep 
   NewCurrentFile="IdVg_" 
   Quasistationary( 
      DoZero 
      InitialStep= 1e-3 Increment= 1.5 
      MinStep= 1e-5 MaxStep= 0.04
      Goal { Name="gate" Voltage=!(puts [expr $SIGN*@Vdd@])! } 
   ){ Coupled { !(puts $EQNS)! } 
      CurrentPlot( Time=(Range=(0 1) Intervals= 30)  )
   }
}

