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
				// If first option is selected, return to main menu
				if PauseValue[0]
				{
					PauseValue[1] = 0;
					PauseValue[0] = 0;
				}
				else
				{
					// Restart
					if PauseValue[1] == 1
					{
						room_restart();
						
						// Subtract a life
						Game.Lives--;
						
						// Clear special ring data
						Game.SpecialRingData = [];
					}
					
					// Exit
					else if PauseValue[1] == 2
					{
						Game.StarpostID		= false;
						Game.Score			= 0;
						Game.Time			= 0;
						Game.StageBoundary  = 0;						
						Game.PlayerPosition = [];
						Game.SpecialRingIDs = [];
						
						room_goto(DevMenu);
					}
					
					// Stop all audio
					audio_stop_all();
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
						
					/* We normally don't do this, but this is one of three cases where we call a script (not function) inside
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
	
	// If stage is not paused, pause!
	else if Stage.DoUpdate and Input.StartPress
	{
		Stage.IsPaused	 = true;	
		Camera.Enabled   = false;
		Input.StartPress = false;
		
		// Stop all audio
		audio_pause_all();
	}
}