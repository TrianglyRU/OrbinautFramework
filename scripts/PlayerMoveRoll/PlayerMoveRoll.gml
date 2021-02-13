function PlayerMoveRoll()
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
		Inertia -= Acc / 2;
		if (Inertia < 0) Inertia = 0;
	}
	else if Inertia < 0
	{
		Inertia += Acc / 2;
		if (Inertia >= 0) Inertia = 0;
	}
	
	// Convert inertia to normal axis speeds
	Xsp = Inertia *  dcos(Angle);
	Ysp = Inertia * -dsin(Angle);
	
	// Limit rolling speed. Original engine limits xsp instead of inertia, resulting
	// desync on high speeds
	if Game.OriginalRollLimit
	{
		if (Xsp > 16)  Xsp = 16;
		if (Xsp < -16) Xsp = -16;
	}
	
	// If our inertia is 0 or we pressed UP, unroll
	if Inertia = 0 or (Game.AllowUnroll and Input.UpPress and abs(Inertia) > 2.5)
	{
		// Reset radiuses (we do not adjust position, tile collision will do this automatically)
		yRadius = yRadiusDefault;
		xRadius = xRadiusDefault;
		
		// Unroll
		Rolling = false;
		
		// Set animation
		Animation = AnimIdle;
	}
}