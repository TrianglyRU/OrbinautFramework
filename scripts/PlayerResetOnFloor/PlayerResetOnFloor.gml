function PlayerResetOnFloor()
{	
	// If grounded flag has been set to true when we've been airborne, we have landed
	if Grounded
	{	
		/* Default events */
		/* ============== */
		
		// Reset gravity
		Grv	= 0.21875;
		
		// Reset flags
		Rolling	= Input.Down;
		Jumping	= false;
		Pushing	= false;
		
		// Reset hurt state
		if Hurt == true
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
			if DropdashDirection == FacingRight
			{
				var Dropspeed = Inertia / 4 + 8 * Facing;
			}
			else if DropdashDirection = FacingLeft
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
		}
		
		/* Collision */
		/* ========= */
		
		// Reset radiuses to default values if not rolling
		if Rolling == false and GlidingState == false
		{
			yRadius = yRadiusDefault; 
			xRadius	= xRadiusDefault;
			PosY   -= yRadiusDefault - yRadiusRoll;
		}
		else if GlidingState == 1
		{
			xRadius = 10;
			yRadius = 10;
		}
	}
}