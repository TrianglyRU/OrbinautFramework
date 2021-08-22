function PlayerSlopeResist()
{	
	// Exit if on ceiling
	if Angle <= 225 and Angle >= 136.41
	{
		exit;
	}
	
	// Set slope gravity
	SlopeGravity = 0.125 * dsin(Angle);
	
	// Apply it
	if Game.S3SlopePhysics
	{
		if Inertia != 0
		{
			if Inertia < 0 or (Inertia >= 0 and SlopeGravity != 0)
			{
				Inertia -= SlopeGravity;
			}
		}
		
		// If moving, subtract slope gravity only if it is greater than 0.05078125
		else if abs(SlopeGravity) > 0.05078125
		{
			Inertia -= SlopeGravity;
		}
	}
	else
	{
		// Apply slope gravity only when moving
		if Inertia < 0 or (Inertia >= 0 and SlopeGravity != 0)
		{
			Inertia -= SlopeGravity;
		}
	}
}