function InterfacePauseProcess()
{
	/* Value table
	---------------
	Value[0] - Option
	Value[1] - Menu
	---------------
	*/
	
	// Check if stage is paused
	if Stage.IsPaused
	{	
		// Loop through options
		if Input.DownPress
		{
			PauseValue[0] = loop_value(PauseValue[0] + 1, 0, PauseValue[1] ? 2 : 3);
			
			// Play sound
			audio_sfx_play(sfxPauseSwitch, false);
		}
		else if Input.UpPress
		{
			PauseValue[0] = loop_value(PauseValue[0] - 1, 0, PauseValue[1] ? 2 : 3);
			
			// Play sound
			audio_sfx_play(sfxPauseSwitch, false);
		}
	
		// React to action or start button
		if (Input.StartPress or Input.ABCPress) and !fade_check(StateActive)
		{
			// Check if we're in RESTART or EXIT submenu
			if PauseValue[1]
			{
				// If first option is selected, return to main pause menu
				if PauseValue[0]
				{
					PauseValue[1] = 0;
					PauseValue[0] = 0;
					
					// Play sound
					audio_sfx_play(sfxPauseBack, false);
				}
				else
				{	
					// Play sound
					audio_sfx_play(sfxPauseSelect, false);
					
					// Perform fade
					fade_perform(ModeInto, BlendBlack, 1);
				}
			}
			
			// Main pause menu
			else switch PauseValue[0]
			{
				// Return to stage
				case 0:
				{
					Camera.Enabled = true;
					Stage.IsPaused = false;	
					
					// Manually enable stage update to avoid 1 frame delay
					Stage.DoUpdate = true;
					
					// Activate objects
					instance_activate_range(Camera.ViewX);
					
					// Resume audio
					audio_resume_all();
					
					// Play sound
					audio_sfx_play(sfxPauseBack, false);
				}
				break;
					
				// Enter RESTART menu if we have more than 1 life
				case 1: 
				{
					if Player.Lives > 1
					{
						PauseValue[1] = 1;
						PauseValue[0] = 0;
						
						// Play sound
						audio_sfx_play(sfxPauseSelect, false);
					}
					else
					{
						// Play deny sound
						audio_sfx_play(sfxFail, false);
					}
				}
				break;
					
				// Enter EXIT menu
				case 2: 
				{
					PauseValue[1] = 2;
					PauseValue[0] = 0;
					
					// Play sound
					audio_sfx_play(sfxPauseSelect, false);
				}
				break;
			}
			
			// Clear input
			Input.StartPress = false;
			Input.ABCPress   = false;
		}
		
		// Restart / exit on fade peak
		if fade_check(StateMax)
		{
			// Restart the stage if we're in RESTART menu
			if PauseValue[1] == 1
			{
				Game.Lives -= 1;
				room_restart();						
			}
					
			// Exit to DevMenu
			else if PauseValue[1] == 2
			{
				room_goto(Screen_DevMenu);
						
				// Reset all data saved during the stage		
				Game.StarPostData    = [];
				Game.SpecialRingList = [];
			}
		}
	}
	
	// If we pressed start button and are allowed to pause, then pause!
	else if Input.StartPress
	{
		if CardValue[1] == 3 and Stage.DoUpdate and !Stage.IsFinished
		{
			Input.StartPress = false;
			Camera.Enabled   = false;
			Stage.IsPaused	 = true;
			
			// Manually disable stage update to avoid 1 frame delay
			Stage.DoUpdate = false;
			
			// Stop all audio
			audio_pause_all();
			
			// Play sound
			audio_sfx_play(sfxPauseSelect, false);
		}
	}
}