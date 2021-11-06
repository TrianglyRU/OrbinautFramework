function SplashScreenProcess()
{
	// Count timer
	switch (++RoomTimer)
	{
		// Fade in
		case 10:
			fade_perform(ModeFrom, BlendBlack, 1);
		break;
		
		// Fade out
		case 150:
			fade_perform(ModeInto, BlendBlack, 1);
		break;
		
		// Load into the next room after 3 seconds
		case 180:
		{
			if !Game.ForceLoad
			{
				room_goto(Screen_DevMenu);
			}
			else
			{
				room_goto(Game.ForceLoad);
			
				// Set gamedata
				Game.ActiveSave = -1;
				Game.Lives		= 3;
				Game.Continues  = 2;
			}
		}
		break;
	}
}