function PlayerSlopeResistRoll()
{
	// Set slope gravity
	if sign(Inertia) == sign(dsin(Angle)) 
	{
		SlopeGravity = 0.078125 * dsin(Angle);
	} 
	else 
	{
		SlopeGravity = 0.3125 * dsin(Angle);
	}

	// Apply it to inertia
	Inertia -= SlopeGravity;
}