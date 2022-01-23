function StartupScreenProcess()
{
	if !(--RoomTimer)
	{
		if Game.ShowSplash
		{
			room_goto(Screen_Splash);
		}
		else
		{
			room_goto(Game.StartRoom);
		}
	}
}