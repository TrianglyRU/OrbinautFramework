function PlayerSlopeResistRoll()
{
	// Exit if on ceiling. Angle check here is different in comparison to collision mode checks
	if Angle <= 225 and Angle >= 136.41
	{
		return;
	}
	
	// Set slope gravity and then apply it
	if sign(Gsp) != sign(dsin(Angle))
	{
		SlopeGravity = 0.3125 * dsin(Angle);
	}
	else
	{
		SlopeGravity = 0.078125 * dsin(Angle);
	}
	Gsp -= SlopeGravity;
}