function PlayerSlopeRepel() 
{
	// Exit if we're stick to convex
	if StickToConvex
	{
		exit;
	}
	
	// Decrease timer every frame when grounded if non-zero
	if MovementLock > 0
	{
		MovementLock--;
	}
	
	// Decrease timer every frame if it's non-zero when grounded
	else
	{
		if !Game.StrongerSlopeGravity
		{	
			// Check if we are on a steep slope and going slow
			if Angle >= 46.41 and Angle <= 315 and abs(Inertia) < 2.5
			{	
				// Fall off the slope
				Grounded = false;
				
				// Reset inertia
				Inertia = 0;
					
				// Lock horizontal input controls for 30 frames
				MovementLock = 30;		
			} 
		}
		else
		{
			// Check if we are on a steep slope and going slow
			if Angle >= 35.16 and Angle <= 326.25 and abs(Inertia) < 2.5
			{
				// Fall off the slope
				if Angle >= 68.91 and Angle <= 292.50
				{
					Grounded = false;
				}
				
				// Slide down the slope
				else
				{
					Inertia += Angle > 180 ? 0.5 : -0.5;
				}
				
				// Lock horizontal input controls for 30 frames
				MovementLock = 30;
			}
		}	
	}
}