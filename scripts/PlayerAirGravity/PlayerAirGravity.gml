function PlayerAirGravity()
{
	// Add gravity to vertical speed
	Ysp += Grv;
	
	// Limit vertical speed
	Ysp = clamp(Ysp, -15.75, 15.75);
	
	// Rotate angle back to 360 degrees when airborne
	Angle = Angle < 180 ? max(Angle - 2.8125, 0) : min(Angle + 2.8125, 360);
}