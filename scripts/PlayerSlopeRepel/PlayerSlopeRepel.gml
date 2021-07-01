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
		if !Game.StrongerSlopeRepel
		{	
			// Check if we are on a steep slope and going slow
			if AngleQuadOdd != RangeFloor and abs(Inertia) < 2.5
			{	
				// Fall off the slope
				Grounded = false;
				Inertia  = 0;
					
				// Lock horizontal input controls for 30 frames
				MovementLock = 30;		
			}
		}
		else
		{
			// Check if we are on a steep slope and going slow
			if Angle >= 25 and Angle <= 335 and abs(Inertia) < 2.5
			{	
				// Slide down or fall off the slope
				if Angle < 90 or Angle > 270
				{   
					if abs(Inertia) - 0.5 >= 0
					{
						Inertia = Angle < 180 ? -0.5 : 0.5;		// TODO: This is not correct
					}
					else
					{
						Inertia = Angle < 180 ? Inertia - 0.5 : Inertia + 0.5;
					}
				}
				else
				{
					Grounded = false;
				}
				
				// Lock horizontal input controls for 30 frames
				MovementLock = 30;
			}
		}	
	}
}