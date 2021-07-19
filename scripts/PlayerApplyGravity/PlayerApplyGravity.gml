function PlayerApplyGravity() 
{	
	// Apply gravity to our vertical speed (and limit it)
	Ysp = min(Ysp + Grv, 16);

	// Rotate our angle back to 360 degrees
	Angle = Angle < 180 ? max(Angle - 2.8125, 0) : min(Angle + 2.8125, 360);
}