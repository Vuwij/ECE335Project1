Title ""

Controls {
}

IOControls {
	EnableSections
}

Definitions {
	Constant "Const.Substrate" {
		Species = "BoronActiveConcentration"
		Value = 1e+17
	}
	Constant "Const.Gate" {
		Species = "ArsenicActiveConcentration"
		Value = 1e+20
	}
	AnalyticalProfile "Impl.Haloprof" {
		Species = "BoronActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 1.5e+18, ValueAtDepth = 1.5e+17, Depth = 0.07)
		LateralFunction = Gauss(Factor = 1)
	}
	AnalyticalProfile "Impl.Extprof" {
		Species = "ArsenicActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 1e+19, ValueAtDepth = 1e+17, Depth = 0.026)
		LateralFunction = Gauss(Factor = 0.8)
	}
	AnalyticalProfile "Impl.SDprof" {
		Species = "ArsenicActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 1e+20, ValueAtDepth = 1e+17, Depth = 0.12)
		LateralFunction = Gauss(Factor = 0.8)
	}
	Refinement "Ref.Substrate" {
		MaxElementSize = ( 0.130625 0.125 )
		MinElementSize = ( 0.002 0.002 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1)
	}
	Refinement "Ref.SiAct" {
		MaxElementSize = ( 0.1 0.02 )
		MinElementSize = ( 0.002 0.002 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1)
	}
	Refinement "Ref.GOX" {
		MaxElementSize = ( 0.26125 0.00035 )
		MinElementSize = ( 0.002 0.000175 )
	}
	Refinement "Ref.J" {
		MaxElementSize = ( 0.00325 0.00325 )
		MinElementSize = ( 0.0026 0.0026 )
	}
	Multibox "MBSize.Gate"
 {
		MaxElementSize = ( 0.005625 0.05 )
		MinElementSize = ( 0.0045 0.0002 )
		Ratio = ( 1 -1.35 )
	}
	Multibox "MBSize.GateOx"
 {
		MaxElementSize = ( 0.005625 0.00035 )
		MinElementSize = ( 0.0045 0.0001 )
		Ratio = ( 1 -1.35 )
	}
	Multibox "MBSize.Channel"
 {
		MaxElementSize = ( 0.005625 0.015 )
		MinElementSize = ( 0.0045 0.0001 )
		Ratio = ( 1 1.35 )
	}
}

Placements {
	Constant "PlaceCD.Substrate" {
		Reference = "Const.Substrate"
		EvaluateWindow {
			Element = region ["R.Substrate"]
		}
	}
	Constant "PlaceCD.Gate" {
		Reference = "Const.Gate"
		EvaluateWindow {
			Element = region ["R.Polygate"]
		}
	}
	AnalyticalProfile "Impl.Halo" {
		Reference = "Impl.Haloprof"
		ReferenceElement {
			Element = Line [(0.0225 0) (1.045 0)]
			Direction = positive
		}
	}
	AnalyticalProfile "Impl.Ext" {
		Reference = "Impl.Extprof"
		ReferenceElement {
			Element = Line [(0.0295 0) (1.045 0)]
			Direction = positive
		}
	}
	AnalyticalProfile "Impl.SD" {
		Reference = "Impl.SDprof"
		ReferenceElement {
			Element = Line [(0.1225 0) (1.045 0)]
			Direction = positive
		}
	}
	Refinement "RefPlace.Substrate" {
		Reference = "Ref.Substrate"
		RefineWindow = region ["R.Substrate"]
	}
	Refinement "RefPlace.SiAct" {
		Reference = "Ref.SiAct"
		RefineWindow = Rectangle [(0 0) (0.5225 0.18)]
	}
	Refinement "RefPlace.GOX" {
		Reference = "Ref.GOX"
		RefineWindow = region ["R.Gateox"]
	}
	Refinement "RefPlace.GJ" {
		Reference = "Ref.J"
		RefineWindow = Rectangle [(0.0087 0) (0.0269 0.013)]
	}
	Multibox "MBPlace.Gate" {
		Reference = "MBSize.Gate"
		RefineWindow = Rectangle [(0 -0.2014) (0.0225 -0.0014)]
	}
	Multibox "MBPlace.GateOx" {
		Reference = "MBSize.GateOx"
		RefineWindow = Rectangle [(0 -0.0014) (0.027 0)]
	}
	Multibox "MBPlace.Channel" {
		Reference = "MBSize.Channel"
		RefineWindow = Rectangle [(0 0) (0.027 0.052)]
	}
}

