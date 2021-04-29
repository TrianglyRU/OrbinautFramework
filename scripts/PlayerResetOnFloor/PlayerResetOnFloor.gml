function PlayerResetOnFloor()
{	
	// If grounded flag has been set to true when we've been airborne, we have landed
	if Grounded
	{	
		/* Default events */
		/* ============== */
		
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
		
		/* Special abilities */
		/* ================= */
		
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
			DropdashRev		   = -2;
			Screen.ScrollDelay = 16;
			
			// Set 'roll' animation
			Animation = AnimRoll;
		}
		else
		{
			DropdashRev = -2;
		}
		
		// Tails' flying
		FlyingState	= false;
		FlyingTimer = 0;
		
		// Knuckles' gliding
		switch GlidingState
		{
			// Continue gliding
			case 1:
			case 2:
			{
				Frc			 =  0.125;
				GlidingValue =  0;
				GlidingState =  1
				MovementLock = -1;				
			}
			break;
			
			// Stop movement if we glidedropped
			case 3:
			{
				Xsp			 = 0;
				Inertia		 = 0;
				GlidingValue = 0;
				GlidingState = false;	
			}
			break;
		}
		
		// Knuckles' climbing
		if ClimbingState
		{	
			ClimbingState  = false;
			ClimbingValue  = 0;			
		}

		/* Collision */
		/* ========= */
		
		// Reset radiuses to default values if its not
		if xRadius != xRadiusDefault and yRadius != yRadiusDefault
		{
			if GlidingState == 1
			{
				xRadius = 10;
				yRadius = 10;
			}
			else if Rolling
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