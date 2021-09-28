function PlayerLevelBound()
{
	// Exit if stage is inactive
	if !Stage.DoUpdate
	{
		exit;
	}
	
	// Keep us inside of stage boundaries using our next position
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
	
	// Prevent us from leaving top boundary if flying or climbing
	if FlightState or ClimbState
	{
		if floor(PosY) < Stage.TopBoundary + 16 and Ysp < 0
		{ 
			if FlightState
			{
				Grv	= 0.03125;
			}	
			Ysp = 0;
		}
	}
	
	// Kill us if we have fallen below death boundary
	if !Death and !Drown
	{
		if floor(PosY) > Stage.DeathBoundary
		{		
			player_damage(false, false, true);
		}
	}
}