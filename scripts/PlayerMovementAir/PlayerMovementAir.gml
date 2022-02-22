function PlayerMovementAir()
{	
	// Rotate angle back to 360 degrees
	if Angle < 180
	{
		Angle = max(Angle - 2.8125, 0);
	}
	else
	{
		Angle = min(Angle + 2.8125, 360);
	}
	
	// Limit vertical speed if not jumping
	if Ysp < -15.75 and !Jumping
	{
		Ysp = -15.75;
	}
	
	if !AirLock
	{
		if Input.Left
		{	
			// Decelerate
			if Xsp > 0 
			{
				Xsp -= AirAcc;
			} 
			
			// Accelerate
			else if !global.AirSpeedcap and Xsp > -TopAcc or global.AirSpeedcap
			{
				Xsp -= AirAcc;
				if Xsp <= -TopAcc
				{
					Xsp = -TopAcc;
				}
			}
			
			Facing = FlipLeft;
		}
		if Input.Right
		{	
			// Decelerate
			if Xsp < 0 
			{
				Xsp += AirAcc;
			} 
			
			// Accelerate
			else if (!global.AirSpeedcap and Xsp < TopAcc) or global.AirSpeedcap
			{
				Xsp += AirAcc;
				if Xsp >= TopAcc
				{
					Xsp = TopAcc;
				}
			}
			
			Facing = FlipRight;
		}	
	}
	
	// Apply air drag
	if Ysp < 0 and Ysp > -4 and !Hurt
	{
		Xsp -= floor(Xsp / 0.125) / 256;
	}
}