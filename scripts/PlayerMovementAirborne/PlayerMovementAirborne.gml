function PlayerMovementAirborne()
{	
	// Accelerate and decelerate
	if !(Jumping and Rolling) 
	{
		if Input.Left 
		{		
			if Xsp > 0 
			{
				Xsp -= Acc * 2;
			} 
			else if Xsp > -TopAcc 
			{
				Xsp -= Acc * 2;
				if (Xsp <= -TopAcc) Xsp = -TopAcc;
			}
			Facing = FacingLeft;
		}
		if Input.Right 
		{	
			if Xsp < 0 
			{
				Xsp += Acc * 2;
			} 
			else if Xsp < TopAcc 
			{
				Xsp += Acc * 2;
				if (Xsp >= TopAcc) Xsp = TopAcc;
			}
			Facing = FacingRight;
		}	
	}
	
	// Apply air drag
	if Ysp < 0 and Ysp > -4 
	{
		Xsp -= floor(Xsp/0.125) / 256;
	}	
}