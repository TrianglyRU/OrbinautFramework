function MenuManualProcess()
{
	switch MenuID
	{
		// Main Menu
		case 0:
		{
			if (Input.APress or Input.StartPress) and OptionID == 3
			{
				game_end();
			}
		}
		break;
		
		// Game Start menu
		case 1:
		{
			if Input.APress or Input.StartPress
			{
				// Set active saveslot (no-save slot will be -1)
				global.ActiveSave = OptionID - 1;
				
				// Read saveslot1-saveslot4 data
				if OptionID > 0 and OptionID < 5
				{
					var Slot = global.SaveData[global.ActiveSave];
					
					// If file isn't empty, load into the game
					if  Slot != 0
					{
						global.Character = Slot[0];
						global.Stage	 = Slot[1];
						global.Emeralds  = Slot[2];
						global.Lives	 = Slot[3];
						global.Continues = Slot[4];
						global.SaveState = Slot[5];
						global.Score	 = Slot[6];
						
						if !global.SaveState
						{
							if ZoneOrder[global.Stage] != noone
							{
								room_goto(ZoneOrder[global.Stage]);
							}
							else
							{
								audio_sfx_play(sfxFail, false);
							}
						}
						else
						{
							// Load into the in-game stage select
						}
						
						// Cancel MenuAutomaticProcess()
						return true;
					}					
				}
			}
		}
		break;
	
		// Character Select
		case 3:
		{
			if Input.APress or Input.StartPress
			{
				global.Character = OptionID;
				
				// If starting a new game, load into the first stage
				if PreviousMenuID[MenuID] == 1
				{
					global.Lives	 = 3;
					global.Continues = 0;
					global.Emeralds  = 0;
					global.Score	 = 0;
					
					if global.ActiveSave != -1
					{
						gamedata_save(global.ActiveSave);
					}
					room_goto(StartStage);
					
					// Cancel MenuAutomaticProcess()
					return true;
				}
				
				/* Else automatic sredirection will happen here */
			}
		}
		break;
		
		// Stage / Screen Select
		case 4:
		case 5:
		{
			if Input.APress or Input.StartPress
			{	
				global.Lives	 = 1;
				global.Continues = 2;
				global.Emeralds  = 7;
				global.Score	 = 0;
				
				// Load into the game in "no-save" mode
				if MenuRedirect[MenuID][OptionID] != noone
				{
					room_goto(MenuRedirect[MenuID][OptionID]);
				}
				global.ActiveSave = -1;
				
				// Cancel MenuAutomaticProcess()
				return true;
			}
		}
		break;
		
		// Options
		case 6:
		{	
			if Input.LeftPress or Input.RightPress
			{
				switch OptionID
				{
					// Fullscreen toggle
					case 0:	
					{		
						window_set_fullscreen(!window_get_fullscreen());
					}
					break;
					
					// Window size toggle
					case 1:
					{
						global.WindowSize = loop_value(global.WindowSize + (Input.RightPress ? 1 : -1), 1, 4);
						
						window_set_size(global.Width * global.WindowSize, global.Height * global.WindowSize);
					}
					break;
					
					// SFX volume
					case 2:
					{
						global.SoundVolume = loop_value(global.SoundVolume * 10 + (Input.RightPress ? 1 : -1), 0, 10) / 10;
					}
					break;
		
					// BGM volume
					case 3:
					{
						global.MusicVolume = loop_value(global.MusicVolume * 10 + (Input.RightPress ? 1 : -1), 0, 10) / 10;
					}
					break;
				}
			}
			
			// Update config file
			else if Input.BPress
			{
				gamesettings_save();
			}
			
			var Option0 = menu_get_initial_string(MenuID, 0);
			var Option1 = menu_get_initial_string(MenuID, 1);
			var Option2 = menu_get_initial_string(MenuID, 2);
			var Option3 = menu_get_initial_string(MenuID, 3);
			
			menu_update_option(MenuID, 0, Option0 + menu_get_boolean(window_get_fullscreen()));
			menu_update_option(MenuID, 1, Option1 + string(global.WindowSize) + "X");
			menu_update_option(MenuID, 2, Option2 + string(round(global.SoundVolume * 100)));
			menu_update_option(MenuID, 3, Option3 + string(round(global.MusicVolume * 100)));
		}
		break;
		
		// Save Deletion
		case 7:
		{
			if Input.APress or Input.StartPress
			{
				global.SaveData[OptionID] = 0;
				file_delete("saveslot" + string(OptionID + 1) + ".bin");	
		
				menu_update_option(1, OptionID + 1, "SAVE " + string(OptionID + 1) + " - NEW GAME");
				menu_update_option(MenuID, OptionID, "DELETED");
			}
			else if Input.BPress
			{
				for (var i = 0; i < 4; i++)
				{
					menu_update_option(MenuID, i, menu_get_initial_string(MenuID, i));
				}
			}
		}
		break;
	}
	return false;
}