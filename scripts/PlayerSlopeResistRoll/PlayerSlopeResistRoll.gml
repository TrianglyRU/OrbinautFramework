function PlayerSlopeResistRoll()
{
	// Exit if on ceiling
	if Angle <= 225 and Angle >= 136.41
	{
		exit;
	}
	
	// Set slope gravity
	if sign(Inertia) != sign(dsin(Angle))
	{
		SlopeGravity = 0.3125 * dsin(Angle);
	}
	else
	{
		SlopeGravity = 0.078125 * dsin(Angle);
	}
	
	// Apply it
	Inertia -= SlopeGravity;
}