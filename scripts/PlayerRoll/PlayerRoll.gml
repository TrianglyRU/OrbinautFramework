function PlayerRoll()
{
	// Set 'roll' animation
	Animation = AnimRoll;
	
	// Reset flags
	Skidding = false;
	
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
		if !Game.SKCrouch and Inertia == 0
		or  Game.SKCrouch and abs(Inertia) < 0.5
		{
			// Reset radiuses
			RadiusY = DefaultRadiusY;
			RadiusX = DefaultRadiusX;
			PosY   -= DefaultRadiusY - SmallRadiusY;
		
			// Unroll
			Spinning = false;
		}
	}
	
	// Keep rolling if forced to
	else if Inertia == 0
	{
		/* In Sonic 1 the game sets your Inertia to 2, in Sonic 2 however this
		   was changed to 4 */
		Inertia = 4 * Facing;
	}
}