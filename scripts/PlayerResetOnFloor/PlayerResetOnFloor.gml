function PlayerResetOnFloor()
{	
	// If grounded flag has been set to true when we've been airborne, we have landed
	if Grounded
	{	
		// Set 'walk' animation
		Animation = AnimWalk;
		
		// Reset gravity
		Grv	= 0.21875;
		
		// Reset flags
		Jumping	= false;
		Pushing	= false;
		Rolling = false;

		// Set visual angle
		if Angle >= 25.5 and Angle <= 334.5
		{
			VisualAngle = Angle;
		}
		
		// Reset hurt state
		if Hurt
		{
			isInvincible = 120;
			Inertia		 = 0;
			Hurt		 = false;			
		}
		
		// Sonic's dropdash
		if DropdashRev == 20
		{	
			// Go to rolling state
			Rolling = true;
		
			// Set dropspeed
			if DropdashDirection == DirRight
			{
				var Dropspeed = Inertia / 4 + 8 * Facing;
			}
			else if DropdashDirection = DirLeft
			{
				if Angle == 360
				{
					var Dropspeed = 8 * Facing;
				}
				else
				{
					var Dropspeed = Inertia / 2 + 8 * Facing;
				}
			}
			if (Dropspeed >  12) Dropspeed =  12;
			if (Dropspeed < -12) Dropspeed = -12;
		
			// Apply dropspeed to inertia and set camera lag
			Inertia			   = Dropspeed;
			DropdashRev		   = -1;
			Screen.ScrollDelay = 16;
			
			// Set 'roll' animation
			Animation = AnimRoll;
		}
		else
		{
			DropdashRev = -1;
		}
		
		// Tails' flying
		FlyingState	= false;
		FlyingTimer = 0;
		
		// Knuckles' climbing
		if ClimbingState
		{	
			ClimbingState = false;
			ClimbingValue = 0;			
		}

		// Reset radiuses to default values
		if !Rolling
		{
			PosY   -= yRadiusDefault - yRadius;
			yRadius = yRadiusDefault; 
			xRadius	= xRadiusDefault;
		}
	}
}