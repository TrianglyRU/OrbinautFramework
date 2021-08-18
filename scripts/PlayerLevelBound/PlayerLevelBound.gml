function PlayerLevelBound()
{
	// Keep the player inside of stage boundaries using our next position
	if floor(Player.PosX + Player.Xsp) < Stage.LeftBoundary + 10 
	{
		Player.Inertia = 0;
		Player.Xsp     = 0;
		Player.PosX    = Stage.LeftBoundary + 10;
		
	}
	if floor(Player.PosX + Player.Xsp) > Stage.RightBoundary - 24 
	{
		Player.Inertia = 0;
		Player.Xsp     = 0;
		Player.PosX    = Stage.RightBoundary - 24;
	}
	
	// Kill the player when falling below death (bottom) boundary
	if !Player.Death and !Player.Drown
	{
		if floor(Player.PosY) > Stage.DeathBoundary
		{		
			object_damage(false, false, true);
		}
	}
}