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
			if Inertia == 0 and abs(0.125 * dsin(Angle)) < 0.05078125
			{
				SlopeGravity = 0;
			}
			else
			{
				SlopeGravity = 0.125 * dsin(Angle);
			}
		}
		else if Inertia != 0
		{
			SlopeGravity = 0.125 * dsin(Angle);
		}
	}
	
	// Apply it to inertia
	Inertia -= SlopeGravity;
}