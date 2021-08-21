function MenuOptionsProcess()
{
	/* If MenuID does not redirect to another MenuID,
	we add input check, else it is done automatically via MenuMainUpdate() script */
	
	switch MenuID
	{
		// Main Menu
		case 0:
		{
			if Input.APress or Input.StartPress
			{
				// Exit the game
				if OptionID == 3
				{
					game_end();
				}
			}
		}
		break;
		
		// Game Start menu
		case 1:
		{
			if Input.APress or Input.StartPress
			{
				// Get current slot id
				Game.ActiveSave = OptionID - 1;
		
				if OptionID >= 1 and OptionID <= 4
				{
					// Check if there is data
					if SaveData[Game.ActiveSave] != 0
					{
						// Load data
						Game.Character = SaveData[Game.ActiveSave][0];	
						Game.Emeralds  = SaveData[Game.ActiveSave][2];
						Game.Lives	   = SaveData[Game.ActiveSave][3];
						Game.Continues = SaveData[Game.ActiveSave][4];
						Game.Score	   = SaveData[Game.ActiveSave][5];	
				
						// Load stage
						switch SaveData[Game.ActiveSave][1]
						{
							case 0:
								room_goto(MQZ0);
							break;
							default: break;
						}
					}
					else
					{
						/* If there is no data, the game will open character select screen
						   via MenuMainUpdate() script */
					}
				}
			}
		}
		break;
	
		// Game Start (character select with empty saveslot)
		case 2:
		{
			if Input.APress or Input.StartPress
			{
				// Load first zone
				room_goto(MQZ0);
		
				// Set data
				Game.Character = OptionID;	
				Game.Emeralds  = 0;
				Game.Lives	   = 3;
				Game.Continues = 0;
				Game.Score	   = 0;	
		
				// Save data if starting the game not in "no save" slot
				if Game.ActiveSave != -1
				{
					gamedata_save(Game.ActiveSave, OptionID, 0, 0, 3, 0, 0);
				}
			}
		}
		break;
	
		// Stage Select (character select)
		case 3:
		{
			if Input.APress or Input.StartPress
			{
				// Set data
				Game.Character = OptionID;	
				Game.Emeralds  = 0;
				Game.Lives	   = 3;
				Game.Continues = 0;
				Game.Score	   = 0;	
			}
		}
		break;
	
		// Stage Select (zone select)
		case 4:
		{
			if Input.APress or Input.StartPress
			{
				// Use "no save" slot
				Game.ActiveSave = -1;
		
				// Load stage
				switch OptionID
				{
					case 0:
						room_goto(StageTemplate);
					break;
					case 1:
						room_goto(MQZ0);
					break;
				}
			}
		}
		break;
	
		// Options (main)
		case 5:
		{
			if Input.BPress
			{
				// Update config file
				gamesettings_save("config");
			}
		}
		break;
	
		// Options (gameplay)
		case 6:
		{
			switch OptionID
			{
				// Spindash toggle
				case 0:
				{
					if Input.LeftPress or Input.RightPress
					{
						Game.SpindashEnabled = !Game.SpindashEnabled;
					}
					
					// Update option
					menu_update_option(6, 0, "SPINDASH: " + menu_get_boolean(Game.SpindashEnabled));
				}
				break;
			
				// Peelout toggle
				case 1:
				{
					if Input.LeftPress or Input.RightPress
					{
						Game.PeeloutEnabled = !Game.PeeloutEnabled;
					}
				
					// Update option
					menu_update_option(6, 1, "PEELOUT: " + menu_get_boolean(Game.PeeloutEnabled));
				}
				break;
			
				// Dropdash toggle
				case 2:
				{
					if Input.LeftPress or Input.RightPress
					{
						Game.DropdashEnabled = !Game.DropdashEnabled;
					}
				
					// Update option
					menu_update_option(6, 2, "DROPDASH: " + menu_get_boolean(Game.DropdashEnabled));
				}
				break;
			
				// Ground cap toggle
				case 3:
				{
					if Input.LeftPress or Input.RightPress
					{
						Game.GroundSpeedcap = !Game.GroundSpeedcap;
					}

					// Update option
					menu_update_option(6, 3, "GRN SPDCAP: " + menu_get_boolean(Game.GroundSpeedcap));
				}
				break;
			
				// Air cap toggle
				case 4:
				{
					if Input.LeftPress or Input.RightPress
					{
						Game.AirSpeedcap = !Game.AirSpeedcap;
					}
				
					// Update option
					menu_update_option(6, 4, "AIR SPDCAP: " + menu_get_boolean(Game.AirSpeedcap));
				}
				break;
			
				// CD camera toggle
				case 5:
				{
					if Input.LeftPress or Input.RightPress
					{
						Game.CDCamera = !Game.CDCamera;
					}
				
					// Update option
					menu_update_option(6, 5, "CD CAMERA: " + menu_get_boolean(Game.CDCamera));
				}
				break;
			}
		}
		break;
	
		// Options (video)
		case 7:
		{
			switch OptionID
			{
				// Window size toggle
				case 0:		
					if Input.LeftPress
					{
						Game.WindowSize--;
					}
					else if Input.RightPress
					{
						Game.WindowSize++;
					}
					Game.WindowSize = clamp(Game.WindowSize, 1, 4);
				
					// Update window
					window_set_size(Game.Width * Game.WindowSize, Game.Height * Game.WindowSize);
				
					// Update option
					menu_update_option(7, 0, "WINDOW SIZE: " + string(Game.WindowSize) + "X");	
				break;
				
				// Fullscreen toggle
				case 1:					
					if Input.LeftPress or Input.RightPress
					{
						Game.WindowFullscreen = !Game.WindowFullscreen;
					}
					
					// Update window
					window_set_fullscreen(Game.WindowFullscreen);
				
					// Update option
					menu_update_option(7, 1, "FULLSCREEN: " + menu_get_boolean(Game.WindowFullscreen));
				break;
				
				// Post-processing
				case 2:
					if Input.LeftPress or Input.RightPress
					{
						Game.PostProcessing = !Game.PostProcessing;
					}
					
					// Update option
					menu_update_option(7, 2, "POST-PROCESSING: " + menu_get_boolean(Game.PostProcessing));
				break;
			}
		}
		break;
	
		// Options (audio)
		case 8:
		{
			// SFX volume
			if OptionID == 0
			{
				if Input.LeftPress
				{
					Game.SoundVolume -= 0.1;
				}
				else if Input.RightPress
				{
					Game.SoundVolume += 0.1;
				}
				Game.SoundVolume = clamp(Game.SoundVolume, 0, 1);
				
				// Update option
				menu_update_option(8, 0, "SFX VOLUME: " + string(round(Game.SoundVolume * 100)));	
			}
		
			// BGM volume
			else if OptionID == 1
			{
				if Input.LeftPress
				{
					Game.MusicVolume -= 0.1;
				}
				else if Input.RightPress
				{
					Game.MusicVolume += 0.1;
				}
				Game.MusicVolume = clamp(Game.MusicVolume, 0, 1);
				
				// Update option
				menu_update_option(8, 1, "BGM VOLUME: " + string(round(Game.MusicVolume * 100)));
			}
		}
		break;
		
		// Options (controls)
		case 9:
		{
			var Buttons = ["UP", "DOWN", "LEFT", "RIGHT", "A", "B", "C", "MODE", "START"];
			
			// Assign key
			if Input.IgnoreInput
			{
				if keyboard_key and keyboard_check_pressed(vk_anykey)
				{
					for (var i = 0; i < 9; i++)
					{
						if OptionID != i and keyboard_key == Game.KeyboardControl[i]
						{
							var CurButton = Game.KeyboardControl[OptionID];
							Game.KeyboardControl[i] = CurButton;
							menu_update_option(9, i, Buttons[i] + ":" + menu_get_keyname(CurButton));
						}
					}
					Input.IgnoreInput = false;
					Game.KeyboardControl[OptionID] = keyboard_key;
					
					// Update option
					menu_update_option(9, OptionID, Buttons[OptionID] + ":" + menu_get_keyname(keyboard_key));
				}
			}
			
			// Select key
			else if Input.APress or Input.StartPress
			{
				Input.IgnoreInput = true;
				
				// Update option
				menu_update_option(9, OptionID, Buttons[OptionID] + ":" + "*-*");
			}
		}
		break;
		
		// Game Start (save deletetion)
		case 10:
		{
			// Delete data
			SaveData[OptionID] = 0;
			file_delete("saveslot" + string(OptionID) + ".bin");	
		
			// Update option
			menu_update_option(1, OptionID + 1, "SAVE " + string(OptionID + 1) + " - NEW GAME");
		}
		break;
	}
}