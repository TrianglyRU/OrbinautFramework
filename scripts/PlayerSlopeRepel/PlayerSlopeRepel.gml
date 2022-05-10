function PlayerSlopeRepel() 
{
	if StickToConvex
	{
		return;
	}
	
	// Decrease timer every frame when grounded if non-zero
	if GroundLock
	{
		GroundLock--;
	}
	
	// Check if we are on a steep slope and going slow
	else
	{
		if !global.S3SlopePhysics
		{	
			// Angle check here is different in comparison to collision mode checks
			if Angle >= 46.41 and Angle <= 315 and abs(Gsp) < 2.5
			{	
				Grounded   = false;
				GroundLock = 30;
				Gsp		   = 0;		
			} 
		}
		else
		{
			if Angle >= 35.16 and Angle <= 326.25 and abs(Gsp) < 2.5
			{
				if Angle >= 68.91 and Angle <= 292.5
				{
					Grounded = false;
				}
				else
				{
					Gsp += Angle > 180 ? 0.5 : -0.5;
				}
				GroundLock = 30;
			}
		}	
	}
}