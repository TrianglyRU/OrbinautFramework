function PlayerSlopeRepel() 
{
	// Decrease movement lock timer every frame when grounded
	if MovementLock > 0
	{
		--MovementLock;
	}	
	else
	{
		if !Game.StrongerSlopeDetach
		{
			// If we're on steep enough slope and going slowly
			if SlopeAngle >= 45 and SlopeAngle <= 315 and abs(Inertia) < 2.5
			{	
				// Lock controls for 30 frames
				MovementLock = 30;
			
				// If floor angle is not that steep then slide down, else fall off
				if SlopeAngle < 90 or SlopeAngle > 270
				{        
					if (SlopeAngle < 90)  Inertia -= 0.5;
					if (SlopeAngle > 270) Inertia += 0.5;
				}
				else
				{
					Grounded = false;
				}				
			}   
		}
		else
		{	
			// If we're on steep enough slope and going slowly
			if (round(SlopeAngle/90) % 4) != RangeFloor and abs(Inertia) < 2.5
			{	
				// Reset inertia, lock controls for 30 frames and go airborne
				Inertia      = 0;
				MovementLock = 30;
				Grounded     = false;
			}
		}
	}
}