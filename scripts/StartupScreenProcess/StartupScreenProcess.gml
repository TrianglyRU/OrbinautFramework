function StartupScreenProcess()
{
	// Load into target room when timer runs out
	if !(--RoomTimer)
	{
		if Game.ShowSplash
		{
			room_goto(Screen_Splash);
		}
		else
		{
			room_goto(Screen_DevMenu);
		}
	}
}