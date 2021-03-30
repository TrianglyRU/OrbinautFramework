function PlayerMoveAirborne()
{	
	// Accelerate and decelerate
	if (Jumping and Rolling) == false and GlidingState == false and ClimbingState == false and Hurt == false and Death == false
	{
		if Input.Left 
		{		
			if Xsp > 0 
			{
				Xsp -= AirAcc;
			} 
			else if (Game.AirSpeedcap == false and Xsp > -TopAcc) or Game.AirSpeedcap == true
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
			else if (Game.AirSpeedcap == false and Xsp < TopAcc) or Game.AirSpeedcap == true
			{
				Xsp += AirAcc;
				if (Xsp >= TopAcc) Xsp = TopAcc;
			}
			Facing = FacingRight;
		}	
	}
	
	// Apply air drag
	if Ysp < 0 and Ysp > -4 and Hurt == false and GlidingState == false
	{
		Xsp -= floor(Xsp/0.125) / 256;
	}	
}