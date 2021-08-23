function ObjLedgePieceMain()
{
	// Delay falling
	if Timer  
	{
		Timer--;
	}
	else
	{
		// Fall
		Ysp += 0.21875;
		PosY += Ysp;
	}
	
	// Update position
	y = floor(PosY);
}