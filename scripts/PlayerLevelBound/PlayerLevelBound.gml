function PlayerLevelBound()
{
	// Keep the player inside of stage boundaries using our next position
	if floor(PosX + Xsp) < Stage.LeftBoundary + 10 
	{
		Inertia = 0;
		Xsp     = 0;
		PosX    = Stage.LeftBoundary + 10;
		
	}
	if floor(PosX + Xsp) > Stage.RightBoundary - 24 
	{
		Inertia = 0;
		Xsp     = 0;
		PosX    = Stage.RightBoundary - 24;
	}
	
	// Top bound
	if GlideState or FlightState
	{
		if floor(PosY - RadiusY - Ysp) < Stage.TopBoundary
		{
			PosY = Stage.TopBoundary + RadiusY + 1;
			
			// Reset gravity if flying
			if FlightState
			{
				Grv	= 0.03125;
			}
		}
	}
	
	// Kill player when falling below death (bottom) boundary)
	if !Death and !Drown
	{
		if floor(PosY) > Stage.DeathBoundary
		{		
			object_damage(false, false, true);
		}
	}
}