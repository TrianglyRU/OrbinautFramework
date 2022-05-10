function PlayerMovementRoll()
{
	// Decelerate
	if !GroundLock
	{
		if Input.Left
		{
			if Gsp > 0
			{
				Gsp -= RollDec;
				if Gsp < 0
				{
					Gsp = -0.5;
				}
			}
			else
			{
				Pushing = false;
				Facing  = FlipLeft;
			}
		}
		if Input.Right
		{
			if Gsp < 0
			{
				Gsp += RollDec;
				if Gsp >= 0
				{
					Gsp = 0.5;
				}
			}
			else
			{
				Pushing = false;
				Facing  = FlipRight;
			}
		}
	}

	// Apply friction
	if Gsp > 0
	{
		Gsp = max(Gsp - RollFrc, 0);
	}
	else if Gsp < 0
	{
		Gsp = min(Gsp + RollFrc, 0);
	}
	
	// Convert ground inertia to speeds
	Xsp = Gsp *  dcos(Angle);
	Ysp = Gsp * -dsin(Angle);
	
	// Limit rolling speed
	if !global.NoRollSpeedLimit
	{
		Xsp = clamp(Xsp, -16, 16);
	}

	// Unroll
	if !ForcedRoll
	{
		if !global.SKCrouch and Gsp == 0 
		or  global.SKCrouch and abs(Gsp) < 0.5
		{
			PosY     -= DefaultRadiusY - SmallRadiusY;
			RadiusX   = DefaultRadiusX;
			RadiusY   = DefaultRadiusY;		
			Spinning  = false;
			Animation = AnimIdle;
		}
	}
	
	// If forced to roll, continue rolling
	else if Gsp == 0
	{
		Gsp = 2;
	}
}