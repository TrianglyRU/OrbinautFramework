function MenuOptionsProcess()
{
	switch MenuID
	{
		// Main Menu
		case 0:
		{
			if Input.APress or Input.StartPress
			{
				switch OptionID
				{
					case 0:
						menu_list_redirect(1, true, true);
					break;
					case 1:
						menu_list_redirect(3, true, true);
					break;
					case 2:
						menu_list_redirect(5, true, true);
					break;
					case 3:
						game_end();
					break;
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
		
				// Check if there is data
				if OptionID >= 1 and OptionID <= 4 and Game.SaveData[Game.ActiveSave] != 0
				{
					// Apply data
					Game.Character = Game.SaveData[Game.ActiveSave][0];
					Game.Stage	   = Game.SaveData[Game.ActiveSave][1];
					Game.Emeralds  = Game.SaveData[Game.ActiveSave][2];
					Game.Lives	   = Game.SaveData[Game.ActiveSave][3];
					Game.Continues = Game.SaveData[Game.ActiveSave][4];
					Game.SaveState = Game.SaveData[Game.ActiveSave][5];
					Game.Score	   = Game.SaveData[Game.ActiveSave][6];
				
					// Load stage if the game is not completed
					if !Game.SaveState
					{
						switch Game.Stage
						{
							default:
								room_goto(Stage_TZ);
							break;
						}
					}
					else
					{
						/* You can add redirection to your in-game level select here */
					}
				}
				
				// Redirect to character select
				else if OptionID != 5
				{
					menu_list_redirect(2, true, true);
				}
				
				// Redirect to save deletion
				else
				{
					menu_list_redirect(10, false, true);
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
				room_goto(Stage_TZ);
		
				// Set data
				Game.Character = OptionID;
				Game.Emeralds  = 0;
				Game.Lives	   = 3;
				Game.Continues = 0;
				Game.Score	   = 0;	
		
				// Save data if starting the game not in "no save" slot
				if Game.ActiveSave != -1
				{
					gamedata_save(Game.ActiveSave);
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
				
				// Redirect to stage select
				menu_list_redirect(4, false, true);
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
						room_goto(Stage_TZ);
					break;
					default: 
						audio_sfx_play(sfxFail);
					break;
				}
			}
		}
		break;
	
		// Options (main)
		case 5:
		{	
			if Input.APress or Input.StartPress
			{
				switch OptionID
				{
					// Redirect to gameplay options
					case 0:
						menu_list_redirect(6, true, true);
					break;
					
					// Redirect to video options
					case 1:
						menu_list_redirect(7, true, true);
					break;
					
					// Redirect to audio options
					case 2:
						menu_list_redirect(8, true, true);
					break;
					
					// Redirect to control options
					case 3:
						menu_list_redirect(9, true, true);
					break;
				}
			}
			else if Input.BPress
			{
				// Update config file
				gamesettings_save("config");
			}
		}
		break;
	
		// Options (gameplay)
		case 6:
		{
			if Input.LeftPress or Input.RightPress
			{
				switch OptionID
				{
					// Spindash toggle
					case 0:
					{
						Game.SpindashEnabled = !Game.SpindashEnabled;
						
						// Update option
						menu_update_option(6, 0, "SPINDASH: " + menu_get_boolean(Game.SpindashEnabled));
					}
					break;
			
					// Peelout toggle
					case 1:
					{
						Game.PeeloutEnabled = !Game.PeeloutEnabled;
						
						// Update option
						menu_update_option(6, 1, "PEELOUT: " + menu_get_boolean(Game.PeeloutEnabled));
					}
					break;
			
					// Dropdash toggle
					case 2:
					{
						Game.DropdashEnabled = !Game.DropdashEnabled;
						
						// Update option
						menu_update_option(6, 2, "DROPDASH: " + menu_get_boolean(Game.DropdashEnabled));
					}
					break;
			
					// Ground cap toggle
					case 3:
					{
						Game.GroundSpeedcap = !Game.GroundSpeedcap;
						
						// Update option
						menu_update_option(6, 3, "GRN SPDCAP: " + menu_get_boolean(Game.GroundSpeedcap));
					}
					break;
			
					// Air cap toggle
					case 4:
					{
						Game.AirSpeedcap = !Game.AirSpeedcap;
						
						// Update option
						menu_update_option(6, 4, "AIR SPDCAP: " + menu_get_boolean(Game.AirSpeedcap));
					}
					break;
			
					// CD camera toggle
					case 5:
					{
						Game.CDCamera = !Game.CDCamera;
						
						// Update option
						menu_update_option(6, 5, "CD CAMERA: " + menu_get_boolean(Game.CDCamera));
					}
					break;
				}
			}
		}
		break;
	
		// Options (video)
		case 7:
		{
			if Input.LeftPress or Input.RightPress
			{
				switch OptionID
				{
					// Window size toggle
					case 0:
					{
						Game.WindowSize = loop_value(Game.WindowSize + (Input.RightPress ? 1 : -1), 1, 5);
						window_set_size(Game.Width * Game.WindowSize, Game.Height * Game.WindowSize);
				
						// Update option
						menu_update_option(7, 0, "WINDOW SIZE: " + string(Game.WindowSize) + "X");	
					}
					break;
				
					// Fullscreen toggle
					case 1:	
					{
						Game.WindowFullscreen = !Game.WindowFullscreen;
						window_set_fullscreen(Game.WindowFullscreen);
				
						// Update option
						menu_update_option(7, 1, "FULLSCREEN: " + menu_get_boolean(Game.WindowFullscreen));
					}
					break;
				}
			}
		}
		break;
	
		// Options (audio)
		case 8:
		{
			if Input.LeftPress or Input.RightPress
			{
				// SFX volume
				if OptionID == 0
				{
					Game.SoundVolume = loop_value(Game.SoundVolume * 10 + (Input.RightPress ? 1 : -1), 0, 11) / 10;
					
					// Update option
					menu_update_option(8, 0, "SFX VOLUME: " + string(round(Game.SoundVolume * 100)));	
				}
		
				// BGM volume
				else if OptionID == 1
				{
					Game.MusicVolume = loop_value(Game.MusicVolume * 10 + (Input.RightPress ? 1 : -1), 0, 11) / 10;
				
					// Update option
					menu_update_option(8, 1, "BGM VOLUME: " + string(round(Game.MusicVolume * 100)));
				}
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
			if Input.APress or Input.StartPress
			{
				// Delete data
				Game.SaveData[OptionID] = 0;
				file_delete("saveslot" + string(OptionID + 1) + ".bin");	
		
				// Update option
				menu_update_option(1, OptionID + 1, "SAVE " + string(OptionID + 1) + " - NEW GAME");
				
				// Redirect back to save select
				menu_list_redirect(1, false, false);
			}
		}
		break;
	}
}