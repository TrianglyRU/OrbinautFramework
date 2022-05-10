function PlayerLevelBound()
{	
	// Keep us inside of stage boundaries using our next position	
	if floor(PosX + Xsp) < Stage.LeftBoundary + 16
	{
		Gsp   = 0;
		Xsp  = 0;
		PosX = Stage.LeftBoundary + 16;
		
	}
	if !Stage.IsFinished
	{
		if floor(PosX + Xsp) > Stage.RightBoundary - 24 
		{
			Gsp  = 0;
			Xsp  = 0;
			PosX = Stage.RightBoundary - 24;
		}
	}
	else if floor(PosX + Xsp) > Stage.RightBoundary + 40
	{
		Gsp  = 0;
		Xsp  = 0;
		PosX = Stage.RightBoundary + 40;
	}
	
	// Prevent us from leaving top boundary if flying or climbing
	if FlightState or ClimbState
	{
		if floor(PosY + Ysp) < Stage.TopBoundary + 16
		{ 	
			if FlightState
			{
				Grv	= 0.03125;
			}	
			Ysp	 = 0;
			PosY = Stage.TopBoundary + 16;
		}
	}
	
	// Prevent us from gliding above top boundary
	if GlideState == GlideAir and floor(PosY) < Stage.TopBoundary + 10
	{
		Xsp = 0;
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