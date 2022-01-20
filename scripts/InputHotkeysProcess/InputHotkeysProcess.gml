function InputHotkeysProcess()
{	
	// Toggle fullscreen
	if keyboard_check_pressed(vk_f4)
	{
		Game.FullscreenMode = !Game.FullscreenMode;
		window_set_fullscreen(Game.FullscreenMode);
	}
	
	// Exit if not in devmode
	if !Game.DevMode
	{
		exit;
	}
		
	// Restart game (F1)
	if keyboard_check_pressed(vk_f1) 
	{
		game_restart();
	}
	
	// Restart stage/room (F2, F3)
	if instance_exists(Stage)
	{
		if keyboard_check_pressed(vk_f2)
		{
			Game.StarPostData	 = [];
			Game.SpecialRingData = [];
			Game.SpecialRingList = [];
			room_restart();
		}
		else if keyboard_check_pressed(vk_f3) 
		{
			Game.SpecialRingData = [];
			room_restart();
		}
	}
	else if keyboard_check_pressed(vk_f2) or keyboard_check_pressed(vk_f3)
	{
		room_restart();
	}
	
	// Debug overlay (F5 -> F10)
	if instance_exists(Interface)
	{
		if keyboard_check_pressed(vk_f5)
		{
			Interface.DebugPositions = !Interface.DebugPositions;
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
		if game_get_speed(gamespeed_fps) != 1
		{
			game_set_speed(1, gamespeed_fps);
		}
		else
		{
			game_set_speed(60, gamespeed_fps);
		}
	}
}