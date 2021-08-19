function MenuOptionsProcess()
{
	/* If MenuID does not redirect to another MenuID,
	we add input check, else it is done automatically via MenuMainUpdate() script */
	
	// Main Menu
	if MenuID == 0 and (Input.APress or Input.StartPress)
	{
		// Exit the game
		if OptionID == 3
		{
			game_end();
		}
	}
	
	// Game Start menu
	if MenuID == 1 and (Input.APress or Input.StartPress)
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
	
	// Game Start (character select with empty saveslot)
	if MenuID == 2 and (Input.APress or Input.StartPress)
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
	
	// Game Start (save deletetion)
	if MenuID == 10
	{
		// Delete data
		SaveData[OptionID] = 0;
		file_delete("saveslot" + string(OptionID) + ".bin");	
		
		// Update option
		menu_update_option(1, OptionID + 1, "SAVE " + string(OptionID + 1) + " - NEW GAME");
	}
	
	// Stage Select (character select)
	if MenuID == 3 and (Input.APress or Input.StartPress)
	{
		// Set data
		Game.Character = OptionID;	
		Game.Emeralds  = 0;
		Game.Lives	   = 3;
		Game.Continues = 0;
		Game.Score	   = 0;	
	}
	
	// Stage Select (zone select)
	if MenuID == 4 and (Input.APress or Input.StartPress)
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
	
	// Options (main)
	if MenuID == 5 and Input.BPress
	{
		// Update config file
		gamesettings_save("config");
	}
	
	// Options (gameplay)
	if MenuID == 6
	{
		switch OptionID
		{
			// Spindash toggle
			case 0:
			{
				if Input.LeftPress
				{
					Game.SpindashEnabled--;
				}
				else if Input.RightPress
				{
					Game.SpindashEnabled++;	
				}
				Game.SpindashEnabled = clamp(Game.SpindashEnabled, 0, 1);
				
				// Update option
				menu_update_option(6, 0, "SPINDASH: " + menu_get_boolean(Game.SpindashEnabled));
			}
			break;
			
			// Peelout toggle
			case 1:
			{
				if Input.LeftPress
				{
					Game.PeeloutEnabled--;
				}
				else if Input.RightPress
				{
					Game.PeeloutEnabled++;	
				}
				Game.PeeloutEnabled = clamp(Game.PeeloutEnabled, 0, 1);
				
				// Update option
				menu_update_option(6, 1, "PEELOUT: " + menu_get_boolean(Game.PeeloutEnabled));
			}
			break;
			
			// Dropdash toggle
			case 2:
			{
				if Input.LeftPress
				{
					Game.DropdashEnabled--;
				}
				else if Input.RightPress
				{
					Game.DropdashEnabled++;	
				}
				Game.DropdashEnabled = clamp(Game.DropdashEnabled, 0, 1);
				
				// Update option
				menu_update_option(6, 2, "DROPDASH: " + menu_get_boolean(Game.DropdashEnabled));
			}
			break;
			
			// Ground cap toggle
			case 3:
			{
				if Input.LeftPress
				{
					Game.GroundSpeedcap--;
				}
				else if Input.RightPress
				{
					Game.GroundSpeedcap++;	
				}
				Game.GroundSpeedcap = clamp(Game.GroundSpeedcap, 0, 1);
				
				// Update option
				menu_update_option(6, 3, "GRN SPDCAP: " + menu_get_boolean(Game.GroundSpeedcap));
			}
			break;
			
			// Air cap toggle
			case 4:
			{
				if Input.LeftPress
				{
					Game.AirSpeedcap--;
				}
				else if Input.RightPress
				{
					Game.AirSpeedcap++;	
				}
				Game.AirSpeedcap = clamp(Game.AirSpeedcap, 0, 1);
				
				// Update option
				menu_update_option(6, 4, "AIR SPDCAP: " + menu_get_boolean(Game.AirSpeedcap));
			}
			break;
			
			// CD camera toggle
			case 5:
			{
				if Input.LeftPress
				{
					Game.ExtendedCamera--;
				}
				else if Input.RightPress
				{
					Game.ExtendedCamera++;	
				}
				Game.ExtendedCamera = clamp(Game.ExtendedCamera, 0, 1);
				
				// Update option
				menu_update_option(6, 5, "CD CAMERA: " + menu_get_boolean(Game.ExtendedCamera));
			}
			break;
		}
	}
	
	// Options (video)
	if MenuID == 7
	{
		// Window size toggle
		if OptionID == 0
		{			
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
		}
		
		// Fullscreen toggle
		else if OptionID == 1
		{
			if Input.LeftPress
			{
				Game.WindowFullscreen--;
			}
			else if Input.RightPress
			{
				Game.WindowFullscreen++;
			}
			Game.WindowFullscreen = clamp(Game.WindowFullscreen, 0, 1);
				
			// Update window
			window_set_fullscreen(Game.WindowFullscreen);
				
			// Update option
			menu_update_option(7, 1, "FULLSCREEN: " + menu_get_boolean(Game.WindowFullscreen));
		}
	}
	
	// Options (audio)
	if MenuID == 8
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
}