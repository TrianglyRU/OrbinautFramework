function PlayerPositionUpdate() 
{	
	// Update current position
	PosX += Xsp;
	PosY += Ysp;
	
	// Keep the player inside of stage boundaries
	if PosX < Stage.LeftBoundary + 16 
	{
		PosX     = Stage.LeftBoundary + 16;
		Xsp      = 0;
		Inertia  = 0;
	}
	if PosX > Stage.RightBoundary - 24 
	{
		PosX     = Stage.RightBoundary - 24;
		Xsp      = 0;
		Inertia  = 0;
	}
}
