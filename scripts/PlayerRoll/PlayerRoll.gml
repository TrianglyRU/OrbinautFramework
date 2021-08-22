function PlayerRoll()
{
	// Set 'roll' animation
	Animation = AnimSpin;
	
	// Decelerate
	if !GroundLock
	{
		if Input.Left and Inertia > 0
		{
			Inertia -= RollDec;
		}
		if Input.Right and Inertia < 0
		{
			Inertia += RollDec;
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
		if !Game.SKCrouch and Inertia == 0 or Game.SKCrouch and abs(Inertia) < 0.5
		{
			// Reset collision radiuses
			RadiusX = DefaultRadiusX;
			RadiusY = DefaultRadiusY;
			PosY   -= DefaultRadiusY - SmallRadiusY;
			
			Spinning = false;
		}
	}
	
	// If forced to roll, keep rolling
	else if Inertia == 0
	{
		// Limit vertical speed
		if Ysp < -15.75
		{
			Ysp = -15.75;
		}
		Inertia = 2 * Facing;
	}
}