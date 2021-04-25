function PlayerMoveAirborne()
{	
	// Reset flags
	Skidding   = false;
	Balancing  = false;
	Pushing	   = false;
	
	// Accelerate and decelerate
	if !(Jumping and Rolling) and !GlidingState and !ClimbingState and !Hurt and !Death
	{
		if Input.Left 
		{		
			if Xsp > 0 
			{
				Xsp -= AirAcc;
			} 
			else if (!Game.AirSpeedcap and Xsp > -TopAcc) or Game.AirSpeedcap
			{
				Xsp -= AirAcc;
				if (Xsp <= -TopAcc) Xsp = -TopAcc;
			}
			Facing = DirLeft;
		}
		if Input.Right 
		{	
			if Xsp < 0 
			{
				Xsp += AirAcc;
			} 
			else if (!Game.AirSpeedcap and Xsp < TopAcc) or Game.AirSpeedcap
			{
				Xsp += AirAcc;
				if (Xsp >= TopAcc) Xsp = TopAcc;
			}
			Facing = DirRight;
		}	
	}
	
	// Apply air drag
	if Ysp < 0 and Ysp > -4 and !Hurt and !GlidingState
	{
		Xsp -= floor(Xsp/0.125) / 256;
	}
	
	if Animation == AnimSpringUp and Ysp > 0
	{
		Animation = AnimAirFall;
	}
}