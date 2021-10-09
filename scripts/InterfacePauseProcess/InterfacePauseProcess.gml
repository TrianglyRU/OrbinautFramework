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
		}
		else if Input.UpPress
		{
			PauseValue[0] = loop_value(PauseValue[0] - 1, 0, PauseValue[1] ? 2 : 3);
		}
	
		// React to action or start button
		if Input.StartPress or Input.ABCPress
		{
			// 'RESTART' or 'EXIT' menu
			if PauseValue[1]
			{
				// If first option is selected, return to previous menu
				if PauseValue[0]
				{
					PauseValue[1] = 0;
					PauseValue[0] = 0;
				}
				else
				{
					// Stop all audio
					audio_stop_all();
					
					// Restart
					if PauseValue[1] == 1
					{
						room_restart();
						
						// Subtract a life
						Player.Lives -= 1;
						Game.Lives    = Player.Lives;
					}
					
					// Exit
					else if PauseValue[1] == 2
					{
						room_goto(Screen_DevMenu);
						
						// Reset all saved data during the stage		
						Game.StarPostData    = [];
						Game.SpecialRingList = [];
					}
					
					// Clear special ring data
					Game.SpecialRingData = [];
				}
			}
			
			// Main menu
			else switch PauseValue[0]
			{
				// Return to stage
				case 0:
				{
					Stage.IsPaused = false;
					Camera.Enabled = true;
					
					instance_activate_all();
					audio_resume_all();
						
					/* We normally don't do this, but this is one of three cases where we call a script (not a function) inside
					of another script. It is needed here to avoid ALL objects being active for 1 frame after we unpause */
					with Stage 
					{
						StageObjectsActiveProcess();
					}
				}
				break;
					
				// Enter 'RESTART' menu if we have more than 1 life
				case 1: 
				{
					if Player.Lives > 1
					{
						PauseValue[1] = 1;
						PauseValue[0] = 0;
					}
					else
					{
						audio_sfx_play(sfxFail, false);
					}
				}
				break;
					
				// Enter 'EXIT' menu
				case 2: 
				{
					PauseValue[1] = 2;
					PauseValue[0] = 0;
				}
				break;
			}
			
			// Clear input
			Input.StartPress = false;
			Input.ABCPress   = false;
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
			
			// Stop all audio
			audio_pause_all();
		}
	}
}