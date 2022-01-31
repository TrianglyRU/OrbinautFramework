function PlayerMovementRoll()
{
	// Decelerate
	if !GroundLock
	{
		if Input.Left
		{
			if Inertia > 0
			{
				Inertia -= RollDec;
				if Inertia < 0
				{
					Inertia = -0.5;
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
			if Inertia < 0
			{
				Inertia += RollDec;
				if Inertia >= 0
				{
					Inertia = 0.5;
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
	if Inertia > 0
	{
		Inertia = max(Inertia - RollFrc, 0);
	}
	else if Inertia < 0
	{
		Inertia = min(Inertia + RollFrc, 0);
	}
	
	// Convert inertia to speeds
	Xsp = Inertia *  dcos(Angle);
	Ysp = Inertia * -dsin(Angle);
	
	// Limit rolling speed
	if !Game.NoRollSpeedLimit
	{
		Xsp = clamp(Xsp, -16, 16);
	}

	// Unroll
	if !ForcedRoll
	{
		if !Game.SKCrouch and Inertia == 0 
		or  Game.SKCrouch and abs(Inertia) < 0.5
		{
			PosY     -= DefaultRadiusY - SmallRadiusY;
			RadiusX   = DefaultRadiusX;
			RadiusY   = DefaultRadiusY;		
			Spinning  = false;
			Animation = AnimIdle;
		}
	}
	else if Inertia == 0
	{
		Inertia = 4 * Facing;
	}
}