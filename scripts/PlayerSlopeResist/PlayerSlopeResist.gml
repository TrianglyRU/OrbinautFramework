function PlayerSlopeResist()
{	
	// Non-rolling slope gravity
	if !Rolling
	{
		if !Game.StrongerSlopeGravity
		{			
			if Angle < 45 or Angle > 315 
			{	
				// Apply only when moving if angle is less than 45
				SlopeGravity = (Inertia != 0) * 0.125;			
			} 
			else 
			{	
				// Apply always if angle is greater than 45
				SlopeGravity = 0.125;
			}
		} 
		else 
		{											
			if Angle < 22.5 or Angle > 337.5 
			{	
				// Apply only when moving if angle is less than 22.5
				SlopeGravity = (Inertia != 0) * 0.125;
			} 
			else 
			{
				// Apply always if angle is greater than 22.5
				SlopeGravity = 0.125;
			}
		}
	}
	
	// Rolling slope gravity
	else
	{
		if sign(Inertia) = sign(dsin(Angle)) 
		{
			SlopeGravity = 0.078125;
		} 
		else 
		{
			SlopeGravity = 0.3125;
		}
	}

	// Update inertia
	Inertia -= SlopeGravity * dsin(Angle);
}