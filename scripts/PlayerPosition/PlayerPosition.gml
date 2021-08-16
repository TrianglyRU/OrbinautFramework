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
	}

	// Limit vertical speed
	Ysp = clamp(Ysp, -15.75, 15.75);
}