function PlayerMoveRoll()
{
	// Stop pushing
	Pushing = false;
	
	// Perform only if directional input is allowed
	if MovementLock == false
	{
		// If pressing left
		if Input.Left and Inertia > 0
		{
			Inertia -= RollDec;
		}
	
		// If pressing right
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
	
	// Convert inertia to normal axis speeds
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
	
	// Keep rolling if forced to
	else
	{
		if Inertia == 0
		{
			Inertia = 2 * Facing;
		}
	}
}