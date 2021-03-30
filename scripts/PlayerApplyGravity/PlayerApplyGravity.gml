function PlayerApplyGravity() 
{	
	// Apply gravity to our vertical speed
	Ysp += Grv;
	
	// Rotate character back
	if Angle < 180 
	{
		Angle -= 2.8125;
	}
	if Angle >= 180 
	{
		Angle += 2.8125;
	}
	if Angle < 0 or Angle > 360 
	{
		Angle = 360;
	}
}