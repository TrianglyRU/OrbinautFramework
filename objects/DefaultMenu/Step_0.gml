/// @description Main
// You can write your code in this editor
	
	#region Manual Process
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
				
					if OptionID >= 1 and OptionID <= 4
					{	
						// If saveslot isn't empty, load into the game
						var SlotData = global.SaveData[global.ActiveSave];
						if  SlotData != 0
						{
							global.Character = SlotData[0];
							global.ZoneID	 = SlotData[1];
							global.Emeralds  = SlotData[2];
							global.Lives	 = SlotData[3];
							global.Continues = SlotData[4];
							global.SaveState = SlotData[5];
							global.Score	 = SlotData[6];
							
							if !global.SaveState
							{
								// If the game isn't complete in this slot, load the level
								if ZoneOrder[global.ZoneID] != noone
								{
									room_goto(ZoneOrder[global.ZoneID]);
								}
								else
								{
									show_message("NO STAGE FOUND! \nIndex " + string(global.ZoneID) + " of ZoneOrder array isn't assigned");
								}
							}
							else
							{
								// Else load into the in-game stage select?
							}
						
							// Cancel automatic process
							return;
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
						// NEW GAME
						if StartStage != noone
						{
							global.Lives	 = 3;
							global.Continues = 0;
							global.Emeralds  = 0;
							global.Score	 = 0;
							global.ZoneID    = 0;
							global.SaveState = 0;
					
							if global.ActiveSave != -1
							{
								savedata_save(global.ActiveSave);
							}
							room_goto(StartStage);
						}
						else
						{
							show_message("NO STAGE FOUND! \nStartStage is currently set to NOONE");
						}
					
						// Cancel automatic process
						return;
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
					// Load into the game in "no-save" mode
					if MenuRedirect[MenuID][OptionID] != noone
					{
						global.ActiveSave = -1;
						global.Lives	  =  3;
						global.Continues  =  2;
						global.Emeralds   =  0;
						global.Score	  =  0;
						global.ZoneID     =  0;
						global.SaveState  =  0;
					
						room_goto(MenuRedirect[MenuID][OptionID]);
					}
					else
					{
						show_message("NO STAGE FOUND! \nTarget room is set to NOONE for this option");
					}
				
					// Cancel automatic process
					return;
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
					settings_save();
				}
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
	}
	#endregion
	
	#region Automatic Process
	{
		// Navigate between options
		if Input.DownPress
		{
			OptionID++;
		}
		else if Input.UpPress
		{
			OptionID--; 
		}
		OptionID = loop_value(OptionID, 0, MenuSize[MenuID] - 1);
	
		// Select
		if Input.APress or Input.StartPress
		{
			var Target  = MenuRedirect[MenuID][OptionID];
			if  Target != noone
			{
				PreviousOptionID[Target] = OptionID;
				PreviousMenuID[Target]   = MenuID;
				MenuID					 = Target;
				OptionID				 = 0;
	
				Input.APress	 = false;
				Input.StartPress = false;
			}
		}

		// Back to previous menu
		if Input.BPress and MenuID != 0
		{
			if PreviousOptionID[MenuID] != noone
			{
				OptionID = PreviousOptionID[MenuID];
			}
			else
			{
				OptionID = 0;
			}
			MenuID		 = PreviousMenuID[MenuID];
			Input.BPress = false;
		}
	}
	#endregion
	
	#region Update Option Strings
	{
		/* Because automatic process (i.e. redirection) happens after manual process,
		there is 1 frame delay for strings that have to load some data to display, so
		we're updating them here */
		
		// Exit if we're not in the options menu
		if MenuID != 6
		{
			return;
		}
		
		// Get initial option name
		var Option0 = menu_get_initial_string(MenuID, 0);
		var Option1 = menu_get_initial_string(MenuID, 1);
		var Option2 = menu_get_initial_string(MenuID, 2);
		var Option3 = menu_get_initial_string(MenuID, 3);
		
		// Update option
		menu_update_option(MenuID, 0, Option0 + menu_get_boolean(window_get_fullscreen()));
		menu_update_option(MenuID, 1, Option1 + string(global.WindowSize) + "X");
		menu_update_option(MenuID, 2, Option2 + string(round(global.SoundVolume * 100)));
		menu_update_option(MenuID, 3, Option3 + string(round(global.MusicVolume * 100)));
	}
	#endregion