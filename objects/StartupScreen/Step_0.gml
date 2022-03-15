/// @description Main
// You can call your scripts in this editor
	
	if !(--RoomTimer)
	{
		if global.ShowSplash
		{
			room_goto(Screen_Splash);
		}
		else
		{
			room_goto(global.StartRoom);
		}
	}