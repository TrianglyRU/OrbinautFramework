function PlayerSlopeRepel() 
{
	// Exit if we're stick to convex
	if StickToConvex
	{
		exit;
	}
	
	// Decrease timer every frame when grounded if non-zero
	if GroundLock
	{
		GroundLock--;
	}
	else
	{
		// Check if we are on a steep slope and going slow
		if !Game.S3SlopePhysics
		{	
			// Angle check here is different in comparison to collision mode checks
			if Angle >= 46.41 and Angle <= 315 and abs(Inertia) < 2.5
			{	
				Grounded   = false;
				Inertia    = 0;
				
				// Lock horizontal control for 30 frames
				GroundLock = 30;		
			} 
		}
		else
		{
			if Angle >= 35.16 and Angle <= 326.25 and abs(Inertia) < 2.5
			{
				// Fall off the slope
				if Angle >= 68.91 and Angle <= 292.5
				{
					Grounded = false;
				}
				
				// Slide down the slope
				else
				{
					Inertia += Angle > 180 ? 0.5 : -0.5;
				}
				
				// Lock horizontal input controls for 30 frames
				GroundLock = 30;
			}
		}	
	}
}