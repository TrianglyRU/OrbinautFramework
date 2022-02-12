function PlayerSlopeResist()
{	
	// Exit if on ceiling. Angle check here is different in comparison to collision mode checks
	if Angle <= 225 and Angle >= 136.41
	{
		return;
	}
	
	// Set slope gravity
	SlopeGravity = 0.125 * dsin(Angle);
	
	// Apply it
	if !global.S3SlopePhysics
	{
		if Gsp != 0
		{
			Gsp -= SlopeGravity;
		}
	}
	else
	{
		if Gsp != 0
		{
			Gsp -= SlopeGravity;
		}
		
		// If moving, subtract slope gravity only if it is greater than 0.05078125
		else if abs(SlopeGravity) > 0.05078125
		{
			Gsp -= SlopeGravity;
		}
	}
}