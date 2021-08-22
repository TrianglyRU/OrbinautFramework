function PlayerSlopeResistRoll()
{
	// Exit if on ceiling
	if Angle <= 225 and Angle >= 136.41
	{
		exit;
	}
	
	// Set slope gravity
	SlopeGravity = 0.3125 * dsin(Angle);
	
	// Apply it
	if Inertia < 0  and SlopeGravity < 0
	or Inertia >= 0 and SlopeGravity >= 0
	{
		SlopeGravity /= 4;
	}
	Inertia -= SlopeGravity;
}