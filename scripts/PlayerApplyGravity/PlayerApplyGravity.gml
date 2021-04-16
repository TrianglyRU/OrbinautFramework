function PlayerApplyGravity() 
{	
	// Apply gravity to our vertical speed
	Ysp += Grv;
	
	// Rotate movement angle value back to 360
	if Angle < 180 
	{
		Angle -= 2.8125;
	}
	else if Angle >= 180 
	{
		Angle += 2.8125;
	}
	if Angle < 0 or Angle > 360 
	{
		Angle = 360;
	}
}