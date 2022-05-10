/// @description Process Input
// You can write your code in this editor
	
	#region Update
	{
		if keyboard_check(vk_anykey)
		{
			Type = "Keyboard";
		}
		else if gamepad_is_connected(0) or gamepad_is_connected(4)
		{
			Type = "Gamepad";
		}
	}
	#endregion
	
	#region Gamepad Process
	{
		if !IgnoreInput and Type == "Gamepad"
		{
			// Choose between XInput and DirectInput. XInput is priority
			var PadID = gamepad_is_connected(0) ? 0 : 4;
	
			var LVAxisValue = gamepad_axis_value(PadID, gp_axislv);
			var LHAxisValue = gamepad_axis_value(PadID, gp_axislh);
	
			// Key Press
			UpPress    = (LVAxisValue < 0 and !Up)    or gamepad_button_check_pressed(PadID, gp_padu);
			DownPress  = (LVAxisValue > 0 and !Down)  or gamepad_button_check_pressed(PadID, gp_padd);
			LeftPress  = (LHAxisValue < 0 and !Left)  or gamepad_button_check_pressed(PadID, gp_padl);
			RightPress = (LHAxisValue > 0 and !Right) or gamepad_button_check_pressed(PadID, gp_padr);
	
			APress     = gamepad_button_check_pressed(PadID, gp_face1);
			BPress     = gamepad_button_check_pressed(PadID, gp_face2);
			CPress     = gamepad_button_check_pressed(PadID, gp_face4);
			ModePress  = gamepad_button_check_pressed(PadID, gp_select);
			StartPress = gamepad_button_check_pressed(PadID, gp_start);
	
			ABCPress   = APress or BPress or CPress;
	
			// Key Down
			Up	  = LVAxisValue < 0 or gamepad_button_check(PadID, gp_padu);
			Down  = LVAxisValue > 0 or gamepad_button_check(PadID, gp_padd);
			Left  = LHAxisValue < 0 or gamepad_button_check(PadID, gp_padl);
			Right = LHAxisValue > 0 or gamepad_button_check(PadID, gp_padr);
	
			A     = gamepad_button_check(PadID, gp_face1);
			B     = gamepad_button_check(PadID, gp_face2);
			C	  = gamepad_button_check(PadID, gp_face4);
			Mode  = gamepad_button_check(PadID, gp_select);
			Start = gamepad_button_check(PadID, gp_start);
	
			ABC   = A or B or C;
		}
	}
	#endregion
	
	#region Keyboard Process
	{
		// Check if we should exit
		if !IgnoreInput and Type == "Keyboard"
		{
			var Key = global.KeyboardControl;
		
			// Key Pressed
			UpPress    = keyboard_check_pressed(Key[0]);
			DownPress  = keyboard_check_pressed(Key[1]);
			LeftPress  = keyboard_check_pressed(Key[2]);
			RightPress = keyboard_check_pressed(Key[3]);
	
			APress     = keyboard_check_pressed(Key[4]);
			BPress     = keyboard_check_pressed(Key[5]);
			CPress     = keyboard_check_pressed(Key[6]);	
			ModePress  = keyboard_check_pressed(Key[7]);
			StartPress = keyboard_check_pressed(Key[8]);
	
			ABCPress   = APress or BPress or CPress;
		
			// Key Down
			Up    = keyboard_check(Key[0]);
			Down  = keyboard_check(Key[1]);
			Left  = keyboard_check(Key[2]);
			Right = keyboard_check(Key[3]);
	
			A     = keyboard_check(Key[4]);
			B     = keyboard_check(Key[5]);
			C     = keyboard_check(Key[6]);
			Mode  = keyboard_check(Key[7]);
			Start = keyboard_check(Key[8]);
	
			ABC   = A or B or C;
		}
	}
	#endregion
	
	#region Hotkeys Process
	{
		// Toggle fullscreen (F4)
		if keyboard_check_pressed(vk_f4)
		{
			window_set_fullscreen(!window_get_fullscreen());
		}
	
		// Debug keys (ESC -> F3, F5 -> F10)
		if global.DevMode
		{
			if keyboard_check_pressed(vk_escape)
			{
				// Reset data
				global.StarPostData    = [];
				global.BonusStageData  = [];
				global.SpecialRingData = [];
				global.SpecialRingList = [];
				
				room_goto(Screen_DevMenu);
			}
			else if keyboard_check_pressed(vk_f1) 
			{
				game_restart();
			}
			else if keyboard_check_pressed(vk_f2)
			{	
				// Reset data
				global.StarPostData    = [];
				global.BonusStageData  = [];
				global.SpecialRingData = [];
				
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
		}
	}
	#endregion
	
	#region Reset
	{
		// Ignore "double" input
		if Left and Right
		{
			Left       = false;
			LeftPress  = false;
			Right      = false;
			RightPress = false;
		
		}
		if Up and Down
		{
			Up        = false;
			Down      = false;
			UpPress   = false;
			DownPress = false;
		}	
	
		// Reset all buttons once input is ignored
		if IgnoreInput == true
		{
			Up			= false;
			Down		= false;
			Left		= false;
			Right		= false;
			A			= false;
			B			= false;
			C			= false;
			ABC			= false;
			Start       = false;
			Mode		= false;
			UpPress		= false;
			DownPress	= false;
			LeftPress	= false;
			RightPress	= false;
			APress		= false;
			BPress		= false;
			CPress		= false;
			ABCPress	= false;
			StartPress  = false;
			ModePress   = false;
			IgnoreInput = 2;
		}
	}
	#endregion