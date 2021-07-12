function PlayerApplyGravity() 
{	
	// Apply gravity to our vertical speed
	Ysp += Grv;
	
	// Limit ysp
	if Ysp > 16
	{
		Ysp = 16;
	}
	
	// Rotate movement angle value back to 360
	Angle = Angle < 180 ? max(Angle - 3, 0) : min(Angle + 3, 360);
}