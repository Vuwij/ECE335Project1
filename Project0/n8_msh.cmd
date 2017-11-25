Title "Untitled"

Controls {
}

IOControls {
	EnableSections
}

Definitions {
	Constant "Const.Subs" {
		Species = "PhosphorusActiveConcentration"
		Value = 4.4e+15
	}
	AnalyticalProfile "doping.profile.nplusSi" {
		Species = "PhosphorusActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 4.4e+17, ValueAtDepth = 2e+17, Depth = 0.25)
		LateralFunction = Gauss(Factor = 1)
	}
	Multibox "refs.ncSi"
 {
		MaxElementSize = ( 1 1 0 )
		MinElementSize = ( 1 0.25 0 )
		Ratio = ( 1 1.1 0 )
	}
	Multibox "refs.nplus"
 {
		MaxElementSize = ( 1 1 0 )
		MinElementSize = ( 1 0.05 0 )
		Ratio = ( 1 1.2 0 )
	}
}

Placements {
	Constant "PlaceCD.Subs" {
		Reference = "Const.Subs"
		EvaluateWindow {
			Element = region ["Subs"]
		}
	}
	AnalyticalProfile "place.nplusSi" {
		Reference = "doping.profile.nplusSi"
		ReferenceElement {
			Element = Line [(0 0) (10 0)]
			Direction = positive
		}
	}
	Multibox "Place.ncSi" {
		Reference = "refs.ncSi"
		RefineWindow = Rectangle [(0 0) (10 5)]
	}
	Multibox "Place.nplus" {
		Reference = "refs.nplus"
		RefineWindow = Rectangle [(0 0) (10 1)]
	}
}

