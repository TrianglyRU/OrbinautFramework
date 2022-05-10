/// @description Main
// You can write your code in this editor
	
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