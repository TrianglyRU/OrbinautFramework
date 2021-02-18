function PlayerResetOnFloor()
{	
	// If grounded flag has been set to true when we've been airborne, we have landed
	if Grounded
	{	
		// Reset flags
		if (DropdashRev != 20) Rolling = false;
		Jumping	= false;
		Pushing = false;
		
		// Reset radiuses to default values if not rolling
		if !Rolling
		{
			yRadius = yRadiusDefault; 
			xRadius	= xRadiusDefault;	
		}
		
		// Reset hurt state
		if Hurt
		{
			Grv			 = 0.21875;
			Inertia		 = 0;
			isInvincible = 120;
			Hurt		 = false;			
		}
	}
}