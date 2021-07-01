function PlayerSlopeRepel() 
{
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
			if Angle >= 45 and Angle <= 315 and abs(Inertia) < 2.5
			{	
				// Fall off the slope
				Grounded = false;
					
				// Lock horizontal input controls for 30 frames
				MovementLock = 30;		
			} 
		}
		else
		{
			// Check if we are on a steep slope and going slow
			if Angle >= 33.75 and Angle <= 326.25 and abs(Inertia) < 2.5
			{
				// Fall off the slope
				if Angle >= 67.5 and Angle <= 292.5
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