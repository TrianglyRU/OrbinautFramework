function PlayerMoveAirborne()
{	
	// Accelerate and decelerate
	if !(Jumping and Rolling) and !GlidingState and !Climbing and !Hurt and !Death 
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
			Facing = FacingLeft;
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
			Facing = FacingRight;
		}	
	}
	
	// Apply air drag
	if Ysp < 0 and Ysp > -4 and !Hurt and !GlidingState
	{
		Xsp -= floor(Xsp/0.125) / 256;
	}	
}