function PlayerPosition() 
{	
	// Update position
	PosX += Xsp;
	PosY += Ysp;	
	
	// Are we airborne?
	if !Grounded
	{
		// Add gravity to vertical speed
		Ysp += Grv;
		
		// Rotate angle back to 360 degrees
		Angle = Angle < 180 ? max(Angle - 2.8125, 0) : min(Angle + 2.8125, 360);
	}

	// Limit vertical speed
	Ysp = clamp(Ysp, -15.75, 15.75);
}