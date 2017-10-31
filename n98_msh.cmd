Title "Untitled"

Controls {
}

IOControls {
	EnableSections
}

Definitions {
	Constant "Const.Subs" {
		Species = "BoronActiveConcentration"
		Value = 8e+15
	}
	Constant "doping.profile.nplusSi" {
		Species = "PhosphorusActiveConcentration"
		Value = 2e+18
	}
	Multibox "refs.ncSi"
 {
		MaxElementSize = ( 1 2 0 )
		MinElementSize = ( 1 0.5 0 )
		Ratio = ( 1 1.1 0 )
	}
	Multibox "refs.nplus"
 {
		MaxElementSize = ( 1 2 0 )
		MinElementSize = ( 1 0.1 0 )
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
	Constant "place.nplusSi" {
		Reference = "doping.profile.nplusSi"
		EvaluateWindow {
			Element = Rectangle [(0 0) (2 1)]
		}
	}
	Multibox "Place.ncSi" {
		Reference = "refs.ncSi"
		RefineWindow = Rectangle [(0 0) (2 10)]
	}
	Multibox "Place.nplus" {
		Reference = "refs.nplus"
		RefineWindow = Rectangle [(0 0) (2 1)]
	}
}

