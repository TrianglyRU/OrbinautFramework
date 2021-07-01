function PlayerApplyGravity() 
{	
	// Apply gravity to our vertical speed
	Ysp += Grv;
	
	// Rotate movement angle value back to 360
	Angle = Angle < 180 ? max(Angle - 2.8125, 0) : min(Angle + 2.8125, 360);
}