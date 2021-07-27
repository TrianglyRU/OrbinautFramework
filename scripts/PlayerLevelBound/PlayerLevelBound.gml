function PlayerLevelBound()
{
	// Keep the player inside of stage boundaries using our next position
	if floor(PosX + Xsp) < Stage.LeftBoundary + 16 
	{
		if Grounded
		{
			Inertia  = 0;
		}
		Xsp  = 0;
		PosX = Stage.LeftBoundary + 16;
		
	}
	if floor(PosX + Xsp) > Stage.RightBoundary - 24 
	{
		if Grounded
		{
			Inertia  = 0;
		}
		Xsp  = 0;
		PosX = Stage.RightBoundary - 24;
	}
	
	// Check if player is not in death state
	if !Death and !Drown
	{
		// Check if player is below bottom stage boundary
		if floor(PosY) > Stage.DeathBoundary
		{		
			// Kill player
			object_damage(false, false, true);
		}
	}
}