function PlayerResetOnFloor()
{	
	// If grounded flag has been set to true when we've been airborne, we have landed
	if Grounded
	{	
		// Reset radiuses
		yRadius = yRadiusDefault; 
		xRadius	= xRadiusDefault;
		
		// Reset flags
		Rolling	= false;
		Jumping	= false;
		Pushing = false;
		
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