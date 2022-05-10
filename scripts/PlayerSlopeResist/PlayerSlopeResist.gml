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
	if Gsp != 0
	{
		Gsp -= SlopeGravity;
	}
	else if global.S3SlopePhysics and abs(SlopeGravity) > 0.05078125
	{
		Gsp -= SlopeGravity;
	}
}