*------------------------------------------------------------
* Simulate dark/light J-V characteristics of  BACH solar cell
* ------------------------------------------------------------
* By default, dark J-V is simulated. 
* To simulate light J-V, set light = on


File{
*-Input
	Grid    = "n8_msh.tdr"
   	Parameter  = "pp95_des.par"
   	* Output Files
   	Current    = "n95_des.plt"
   	Plot       = "n95_des.tdr"
	Output     = "n95_des.log"
}

Electrode {
   { Name="electrode_1" Voltage=0.0 }
   { Name="electrode_2" Voltage=0.0 } 
}

Physics {
   Temperature=300
   EffectiveIntrinsicDensity( Slotboom )
   Mobility ( DopingDep eHighFieldSaturation hHighFieldSaturation )
   Recombination(SRH(DopingDep))
   AreaFactor = 1e3 * converting current to mA
}

Insert = "PlotSection_des.cmd"
Insert = "MathSection_des.cmd"

Solve{
  NewCurrentFile="init"
  Poisson

  NewCurrentFile=""
  Coupled (Iterations=100) { poisson electron hole  }

  Quasistationary ( 
      InitialStep=4e-2 Increment=1.1 Minstep=1e-3 MaxStep=1e-1
      Goal { Name="electrode_1" Voltage=5 }
    	) {Coupled (Iterations=100) {Poisson Electron Hole}}

	CurrentPlot ( Time = (Range = (0.0 0.2) Intervals=10; Range = (0.2 1.0) Intervals=20))

  	System("rm -f init*") *remove the plot we dont need anymore.  

}

