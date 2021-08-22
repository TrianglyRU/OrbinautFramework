function StartupScreenProcess()
{
	// Load into target room when timer runs out
	if !(--RoomTimer)
	{
		if Game.ShowSplash
		{
			room_goto(Splash);
		}
		else
		{
			room_goto(DevMenu);
		}
	}
}