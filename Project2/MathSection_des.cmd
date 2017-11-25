Math {
	Extrapolate
	Notdamped= 50
	Iterations= 15
	ExitOnFailure
	eMobilityAveraging= ElementEdge
	* uses edge mobility instead of element one for electron mobility	
	hMobilityAveraging= ElementEdge   
	* uses edge mobility instead of element one for hole mobility
	GeometricDistances 		         
	* when needed, compute distance to the interface instead of closest point on the interface
	ParameterInheritance= Flatten 	  
	* regions inherit parameters from materials  
}
