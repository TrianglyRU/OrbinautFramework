function InputHotkeysRead()
{	
	if room != DevMenu
	{
		// Stage restart
		if keyboard_check_pressed(vk_f1) 
		{
			Game.SavedCheckpoint = 0;
			Game.SavedPosition	 = 0;
			room_restart();
		}
		if keyboard_check_pressed(vk_f2)
		{
			room_restart();
		}

		// Game restart
		if keyboard_check_pressed(vk_f3) 
		{
			game_restart();
		}
		
		// Debug view
		if instance_exists(Stage)
		{
			if Stage.State != ActStateLoading
			{
				if keyboard_check_pressed(vk_f4)
				{
					Screen.DebugViewEnabled = !Screen.DebugViewEnabled;
				}
				if keyboard_check_pressed(vk_f5) 
				{
					Screen.DebugShowSolidboxes = !Screen.DebugShowSolidboxes;
				}
				if keyboard_check_pressed(vk_f6) 
				{
					Screen.DebugShowHitboxes = !Screen.DebugShowHitboxes;
				}
				if keyboard_check_pressed(vk_f7) 
				{
					Screen.DebugShowCollision = !Screen.DebugShowCollision;
				}
			}
		}
		
		// Low FPS mode
		if keyboard_check_pressed(vk_f8) 
		{
			game_set_speed(game_get_speed(gamespeed_fps) == 60 ? 1 : 60, gamespeed_fps);
		}
	
		// Player
		if keyboard_check_pressed(ord("1")) 
		{
			Player.Inertia += 6 * Player.Facing;	
		}
		if keyboard_check_pressed(ord("2")) 
		{
			Player.Inertia = 16 * Player.Facing;
		}
		if keyboard_check_pressed(ord("3")) 
		{
			Player.HighSpeedBonus = 1500;
		}
		if keyboard_check_pressed(ord("4")) 
		{
			Player.isSuper = true;
			Player.Rings   = 50;
		}
		
		// Ignore input mode
		if keyboard_check_pressed(ord("L")) 
		{
			IgnoreInput = true;
			ResetInput  = true;
		}
	
		// Window resize
		if keyboard_check_pressed(vk_numpad1) 
		{
			Game.WindowSize = 1; 
			window_set_size(Game.ResolutionWidth * Game.WindowSize, Game.ResolutionHeight * Game.WindowSize);
		}
		if keyboard_check_pressed(vk_numpad2) 
		{
			Game.WindowSize = 2; 
			window_set_size(Game.ResolutionWidth * Game.WindowSize, Game.ResolutionHeight * Game.WindowSize);
		}
		if keyboard_check_pressed(vk_numpad3) 
		{
			Game.WindowSize = 3; 
			window_set_size(Game.ResolutionWidth * Game.WindowSize, Game.ResolutionHeight * Game.WindowSize);
		}
		if keyboard_check_pressed(vk_numpad4) 
		{
			Game.WindowSize = 4; 
			window_set_size(Game.ResolutionWidth * Game.WindowSize, Game.ResolutionHeight * Game.WindowSize);
		}	
	}
}