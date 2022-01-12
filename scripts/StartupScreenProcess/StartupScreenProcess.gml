function StartupScreenProcess()
{
	if !(--RoomTimer)
	{
		// Load into the splash screen room
		if Game.ShowSplash
		{
			room_goto(Screen_Splash);
		}
		
		// Load into the DevMenu
		else if !Game.ForceLoad
		{
			room_goto(Screen_DevMenu);
		}
		
		// Load into the forced room
		else
		{
			room_goto(Game.ForceLoad);
			
			// Set default game data
			Game.ActiveSave = -1;
			Game.Continues  =  2;
			Game.Lives		=  3;	
		}
	}
}