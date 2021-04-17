function PlayerMoveRoll()
{
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
		Inertia -= RollFrc;
		if (Inertia < 0) Inertia = 0;
	}
	else if Inertia < 0
	{
		Inertia += RollFrc;
		if (Inertia >= 0) Inertia = 0;
	}
	
	// Convert inertia to normal axis speeds
	Xsp = Inertia *  dcos(Angle);
	Ysp = Inertia * -dsin(Angle);
	
	// Get our speed ratio
	AnimReservedSpeed = round(max(1, 4 - abs(Inertia)));
	
	// Limit rolling speed. Original engine limits xsp instead of inertia, resulting
	// desync on high speeds
	if Game.OriginalRollLimit
	{
		if (Xsp > 16)  Xsp = 16;
		if (Xsp < -16) Xsp = -16;
	}
	else
	{
		if (Inertia > 32)  Inertia = 32;
		if (Inertia < -32) Inertia = -32;
	}
	
	// If our inertia is 0 or we pressed UP, unroll
	if Inertia == 0 or (Game.AllowUnroll and Input.UpPress and abs(Inertia) > 2.5)
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