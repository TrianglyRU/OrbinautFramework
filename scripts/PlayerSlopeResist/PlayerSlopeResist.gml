function PlayerSlopeResist()
{	
	// Set slope gravity	
	if !Game.S3SlopePhysics
	{
		if Angle >= 46.41 and Angle <= 315
		{
			SlopeGravity = 0.125 * dsin(Angle);
		}
		else if Inertia != 0
		{
			SlopeGravity = 0.125 * dsin(Angle);
		}
	}
	else
	{
		if Angle >= 35.16 and Angle <= 326.25
		{
			SlopeGravity = 0.125 * dsin(Angle);
		}
		else if Inertia != 0
		{
			SlopeGravity = 0.125 * dsin(Angle);
		}
		else if abs(0.125 * dsin(Angle)) < 0.05078125
		{
			SlopeGravity = 0;
		}
	}
	
	// Apply it to inertia
	Inertia -= SlopeGravity;
}