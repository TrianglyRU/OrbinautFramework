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
				Game.ActiveSave = OptionID - 1;
				
				// Read saveslot1-saveslot4 data
				if OptionID > 0 and OptionID < 5
				{
					var Slot = Game.SaveData[Game.ActiveSave];
					
					// If file isn't empty, load into the game
					if  Slot != 0
					{
						Game.Character = Slot[0];
						Game.Stage	   = Slot[1];
						Game.Emeralds  = Slot[2];
						Game.Lives	   = Slot[3];
						Game.Continues = Slot[4];
						Game.SaveState = Slot[5];
						Game.Score	   = Slot[6];
						
						if !Game.SaveState
						{
							if ZoneOrder[Game.Stage] != noone
							{
								room_goto(ZoneOrder[Game.Stage]);
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
				Game.Character = OptionID;
				
				// If we're here from the Game Start menu, load into the first stage
				if PreviousMenuID[MenuID] == 1
				{
					Game.Lives	   = 3;
					Game.Continues = 0;
					Game.Emeralds  = 0;
					Game.Score	   = 0;
					
					if Game.ActiveSave != -1
					{
						gamedata_save(Game.ActiveSave);
					}
					room_goto(StartStage);
					
					// Cancel MenuAutomaticProcess()
					return true;
				}
			}
		}
		break;
		
		// Stage / Screen Select
		case 4:
		case 5:
		{
			if Input.APress or Input.StartPress
			{	
				Game.Lives	   = 3;
				Game.Continues = 2;
				Game.Emeralds  = 7;
				Game.Score	   = 0;
				
				// Load into the game in "no-save" mode
				if MenuRedirect[MenuID][OptionID] != noone
				{
					room_goto(MenuRedirect[MenuID][OptionID]);
				}
				Game.ActiveSave = -1;
				
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
						Game.WindowSize = loop_value(Game.WindowSize + (Input.RightPress ? 1 : -1), 1, 5);
						
						window_set_size(Game.Width * Game.WindowSize, Game.Height * Game.WindowSize);
					}
					break;
					
					// SFX volume
					case 2:
					{
						Game.SoundVolume = loop_value(Game.SoundVolume * 10 + (Input.RightPress ? 1 : -1), 0, 11) / 10;
					}
					break;
		
					// BGM volume
					case 3:
					{
						Game.MusicVolume = loop_value(Game.MusicVolume * 10 + (Input.RightPress ? 1 : -1), 0, 11) / 10;
					}
					break;
				}
			}
			
			// Update config file
			else if Input.BPress
			{
				gamesettings_save();
			}
			
			menu_update_option(MenuID, 0, "FULLSCREEN: "   + menu_get_boolean(window_get_fullscreen()));
			menu_update_option(MenuID, 1, "WINDOW SIZE: "  + string(Game.WindowSize) + "X");
			menu_update_option(MenuID, 2, "SOUND VOLUME: " + string(round(Game.SoundVolume * 100)));
			menu_update_option(MenuID, 3, "MUSIC VOLUME: " + string(round(Game.MusicVolume * 100)));
		}
		break;
		
		// Save Deletion
		case 7:
		{
			if Input.APress or Input.StartPress
			{
				Game.SaveData[OptionID] = 0;
				file_delete("saveslot" + string(OptionID + 1) + ".bin");	
		
				menu_update_option(1, OptionID + 1, "SAVE " + string(OptionID + 1) + " - NEW GAME");
				menu_update_option(MenuID, OptionID, "DELETED");
			}
			else if Input.BPress
			{
				for (var i = 0; i < 4; i++)
				{
					menu_update_option(MenuID, i, "SLOT " + string_upper(i));
				}
			}
		}
		break;
	}
	return false;
}