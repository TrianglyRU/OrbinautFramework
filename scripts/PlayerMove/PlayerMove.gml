function PlayerMove()
{	
	// Accelerate and decelerate
	if MovementLock == false
	{
		if Input.Left == true
		{	
			// If moving right and left key is pressed, decelerate
			if Inertia > 0 
			{
				Inertia -= Dec;
				if (Inertia <= 0) Inertia = -0.5;	
			} 
			
			// If moving left and left key is pressed, accelerate
			else
			{
				if (Game.GroundSpeedcap == false and Inertia > -TopAcc) or Game.GroundSpeedcap == true
				{
					Inertia -= Acc;					
					if (Inertia <= -TopAcc) Inertia = -TopAcc;		
				} 
				Facing = FacingLeft;
			}
		}
		if Input.Right == true 
		{				
			// If moving left and right key is pressed, decelerate
			if Inertia < 0 
			{
				Inertia += Dec;
				if (Inertia >= 0) Inertia = 0.5;
			} 
			
			// If moving right and right key is pressed, accelerate
			else
			{
				if (Game.GroundSpeedcap == false and Inertia < TopAcc) or Game.GroundSpeedcap == true
				{
					Inertia += Acc;
					if (Inertia >= TopAcc) Inertia = TopAcc;
				} 
				Facing = FacingRight;
			}
		}
	}
	
	// Apply friction
	if (Input.Left == false and Input.Right == false and Inertia != 0) or MovementLock != false
	{
		if Inertia > 0
		{
			Inertia -= Acc;
			if (Inertia < 0) Inertia = 0;
		}
		else
		{
			Inertia += Acc;
			if (Inertia >= 0) Inertia = 0;
		}
	}
	
	// Check for skidding
	if Skidding == false and abs(Inertia) > 4 and round(Angle/90) % 4 == RangeFloor
	{
		if Inertia > 0 and Input.LeftPress == true
		{
			Skidding = FacingRight;
		}
		if Inertia < 0 and Input.RightPress == true
		{
			Skidding = FacingLeft;
		}
	}
	else
	{
		if (Inertia < 0 and Input.LeftPress == true) or (Inertia > 0 and Input.RightPress == true) or Inertia == 0 or sign(Skidding) != sign(Inertia)
		{
			Skidding = false;
		}
	}
		
	// Set animation
	if Inertia == 0
	{
		Animation = AnimIdle;
	}
	else if Skidding == false
	{
		if abs(Inertia) < 6
		{
			Animation = AnimWalk;
		}
		else
		{
			if abs(Inertia) < 10
			{
				Animation = AnimRun;
			}
			else
			{
				Animation = CharacterID == CharSonic ? AnimPeelout : AnimRun;
			}
		}
	}
	else
	{
		Animation = AnimSkid;
	}

	// Get our speed ratio
	AnimReservedSpeed = round(max(1, 8 - abs(Inertia)));

	// Convert inertia to normal axis speeds
	Xsp = Inertia *  dcos(Angle);
	Ysp = Inertia * -dsin(Angle);
}