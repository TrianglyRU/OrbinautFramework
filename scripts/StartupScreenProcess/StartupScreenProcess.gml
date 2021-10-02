function StartupScreenProcess()
{
	// Load into target room when timer runs out
	if !(--RoomTimer)
	{
		if Game.ShowSplash
		{
			room_goto(Screen_Splash);
		}
		else if !Game.ForceLoad
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
}