function InputHotkeysProcess()
{	
	// Toggle fullscreen (F4)
	if keyboard_check_pressed(vk_f4)
	{
		window_set_fullscreen(!window_get_fullscreen());
	}
	
	if !global.DevMode
	{
		return;
	}
	
	// Debug keys (ESC -> F3)
	if keyboard_check_pressed(vk_escape)
	{
		room_goto(Screen_DevMenu);
	}
	else if keyboard_check_pressed(vk_f1) 
	{
		game_restart();
	}
	else if keyboard_check_pressed(vk_f2)
	{	
		room_restart();
	}
	else if keyboard_check_pressed(vk_f3) 
	{
		if game_get_speed(gamespeed_fps) == 60
		{
			game_set_speed(2, gamespeed_fps);
		}
		else
		{
			game_set_speed(60, gamespeed_fps);
		}
	}
	
	// Debug overlay (Key 1 -> Key)
	if instance_exists(Interface)
	{
		
		if keyboard_check_pressed(ord("1"))
		{
			Interface.DebugSensors = !Interface.DebugSensors;
		}
		else if keyboard_check_pressed(ord("2"))
		{
			Interface.DebugPositions = !Interface.DebugPositions;
		}
		else if keyboard_check_pressed(ord("3"))
		{
			Interface.DebugSolids = !Interface.DebugSolids;
		}
		else if keyboard_check_pressed(ord("4"))
		{
			Interface.DebugHitboxes = !Interface.DebugHitboxes;
		}
		else if keyboard_check_pressed(ord("5"))
		{
			Interface.DebugTriggers = !Interface.DebugTriggers;
		}
		else if keyboard_check_pressed(ord("9"))
		{
			Interface.DebugFPS = !Interface.DebugFPS;
		}
		else if keyboard_check_pressed(ord("0"))
		{
			Interface.DebugVariables = !Interface.DebugVariables;
		}
	}
}