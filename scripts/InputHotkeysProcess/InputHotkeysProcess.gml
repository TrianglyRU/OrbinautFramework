function InputHotkeysProcess()
{	
	// Exit if not in devmode
	if !Game.DevMode
	{
		return;
	}
	
	// Load into DevMenu
	if keyboard_check_pressed(vk_escape)
	{
		room_goto(Screen_DevMenu);
	}
		
	// Restart game (F1)
	if keyboard_check_pressed(vk_f1) 
	{
		game_restart();
	}
	
	// Restart room (F2)
	if keyboard_check_pressed(vk_f2)
	{
		room_restart();
	}
	
	// Debug overlay (F4 -> F10)
	if instance_exists(Interface)
	{
		if keyboard_check_pressed(vk_f4)
		{
			Interface.DebugPositions = !Interface.DebugPositions;
		}
		else if keyboard_check_pressed(vk_f5)
		{
			Interface.DebugSensors = !Interface.DebugSensors;
		}
		else if keyboard_check_pressed(vk_f6)
		{
			Interface.DebugSolids = !Interface.DebugSolids;
		}
		else if keyboard_check_pressed(vk_f7)
		{
			Interface.DebugHitboxes = !Interface.DebugHitboxes;
		}
		else if keyboard_check_pressed(vk_f8)
		{
			Interface.DebugTriggers = !Interface.DebugTriggers;
		}
		else if keyboard_check_pressed(vk_f9)
		{
			Interface.DebugFPS = !Interface.DebugFPS;
		}
		else if keyboard_check_pressed(vk_f10)
		{
			Interface.DebugVariables = !Interface.DebugVariables;
		}
	}

	// Frame-by-frame mode (F12)
	if keyboard_check_pressed(vk_f12) 
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
}