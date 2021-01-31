function PlayerMovementRolling()
{
	// Perform only if directional input is allowed
	if !MovementLock
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
					Facing  = FacingLeft;
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
					Facing  = FacingRight;
				}
			}
		}
	}

	// Apply friction
	if Inertia > 0
	{
		Inertia -= RollDec / 2;
		if (Inertia < 0) Inertia = 0;
	}
	else if Inertia < 0
	{
		Inertia += RollDec / 2;
		if (Inertia >= 0) Inertia = 0;
	}
	
	// Update axis speeds
	Xsp  = Inertia * dcos(Angle);
	Ysp  = Inertia *-dsin(Angle);
	
	// Limit speed
	if (Xsp > 16)  Xsp = 16;
	if (Xsp < -16) Xsp = -16;
	
	// If inertia is 0
	if Inertia = 0 or Input.UpPress
	{
		// Reset radiuses and adjust position
		yRadius = yRadiusDefault;
		xRadius = xRadiusDefault;
		PosY   -= yRadiusDefault - yRadiusRoll;
		
		// Unroll
		Rolling = false;
		
		// Set animation
		Animation = AnimIdle;
	}
}