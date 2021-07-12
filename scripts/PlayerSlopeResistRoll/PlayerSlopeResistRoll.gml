function PlayerSlopeResistRoll()
{
	// Set slope gravity
	if sign(Inertia) == sign(dsin(Angle)) 
	{
		SlopeGravity = 0.078125;
	} 
	else 
	{
		SlopeGravity = 0.3125;
	}

	// Update inertia
	Inertia -= SlopeGravity * dsin(Angle);
}