function PlayerMoveRoll()
{
	// Stop pushing
	Pushing = false;
	
	// Perform only if directional input is allowed
	if MovementLock == false
	{
		// If pressing left
		if Input.Left 
		{
			if Inertia > 0 
			{
				Inertia -= RollDec;
				if Inertia <= 0
				{
					Inertia = -0.5;
					Facing  = DirLeft;
				}
			}
		}
	
		// If pressing right
		if Input.Right 
		{
			if Inertia < 0
			{
				Inertia += RollDec;
				if Inertia >= 0
				{
					Inertia = 0.5;
					Facing  = DirRight;
				}
			}
		}
	}

	// Apply friction
	if Inertia > 0
	{
		Inertia = max(Inertia - RollFrc, 0);
	}
	else if Inertia < 0
	{
		Inertia = min(Inertia + RollFrc, 0);
	}
	
	// Convert inertia to normal axis speeds
	Xsp = Inertia *  dcos(Angle);
	Ysp = Inertia * -dsin(Angle);
	
	// Get our speed ratio
	AnimReservedSpeed = round(max(1, 4 - abs(Inertia)));
	
	// Limit rolling speed. Original engine limits xsp instead of inertia, resulting in desync on high speeds
	if Game.OriginalRollLimit
	{
		Xsp = clamp(Xsp, -16, 16);
	}

	// Unroll
	if !Game.LooseCrouch and Inertia == 0
	or  Game.LooseCrouch and abs(Inertia) < 0.5
	{
		// Reset radiuses
		yRadius = yRadiusDefault;
		xRadius = xRadiusDefault;
		PosY   -= yRadiusDefault - yRadiusRoll;
		
		// Unroll
		Rolling = false;
		
		// Set animation
		Animation = AnimIdle;
	}
}