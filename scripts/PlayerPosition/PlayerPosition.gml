function PlayerPosition() 
{	
	// Update position
	PosX += Xsp;
	PosY += Ysp;	
	
	// Add gravity if airborne
	if !Grounded
	{
		Ysp += Grv;
	}
}