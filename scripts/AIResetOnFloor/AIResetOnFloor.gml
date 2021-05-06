function AIResetOnFloor()
{	
	// If grounded flag has been set to true when we've been airborne, we have landed
	if Grounded
	{	
		// Set 'idle' animation by default
		Animation = AnimIdle;
		
		// Set 'run' or 'walk' animation
		if abs(Inertia) > 6
		{
			Animation = AnimRun;
		}
		else if Inertia != 0
		{
			Animation = AnimWalk;
		}
		
		// Reset gravity
		Grv	= 0.21875;
		
		// Reset flags
		Jumping	= false;
		Pushing	= false;
		Rolling = false;

		// Set visual angle
		VisualAngle = Angle;
		
		// Reset hurt state
		if Hurt
		{
			isInvincible = 120;
			Inertia		 = 0;
			Hurt		 = false;			
		}
		
		// Tails' flying
		FlyingState	= false;
		FlyingTimer = 0;
		
		// Reset radiuses to default values if its not
		if xRadius != xRadiusDefault and yRadius != yRadiusDefault
		{
			if Rolling
			{
				xRadius = xRadiusRoll;
				yRadius = yRadiusRoll;
			}
			else
			{
				PosY   -= yRadiusDefault - yRadius;
				yRadius = yRadiusDefault; 
				xRadius	= xRadiusDefault;
			}
		}
	}
}