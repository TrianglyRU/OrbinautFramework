function PlayerResetOnFloor()
{	
	// If grounded flag has been set to true when we've been airborne, we have landed
	if Grounded
	{	
		if Gliding = 3
		{
			Xsp		= 0;
			Inertia = 0;
			Gliding = false;
		}
		
		// Reset gravity
		Grv	= 0.21875;
		
		// Reset flags
		Rolling		= DropdashRev == 20;
		Gliding		= Gliding == 1;
		Jumping		= false;
		Pushing		= false;
		Flying	    = false;
		FlyingTimer = 0;
		DropdashRev = -2;
		
		// Reset hurt state
		if Hurt
		{
			Inertia		 = 0;
			isInvincible = 120;
			Hurt		 = false;			
		}
		
		// Reset radiuses to default values if not rolling
		if !Rolling
		{
			yRadius = yRadiusDefault; 
			xRadius	= xRadiusDefault;	
		}	
	}
}