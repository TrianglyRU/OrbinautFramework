function MenuOptionReact()
{
	// Main Menu
	if MenuID == 0 and Input.APress
	{
		// Exit the game
		if OptionID == 3
		{
			game_end();
		}
	}
	
	// Game Start menu
	if MenuID == 1 and Input.APress
	{
		// Get current slot id
		Game.ActiveSave = OptionID - 1;
			
		// Check if "no save" slot has been selected
		if OptionID == 0
		{
			// Do not save data
			DataMode = 0;
		}
		
		// Check if saveslot has been selected
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
						room_goto(MQZ1);
					break;
					
					// Do not load anything if stage not set
					default:
					break;
				}
			}
			else
			{
				/* If there is no data, the game will open character select screen
				   via MenuMainUpdate() script									   */
				
				// Also set data mode to "save new game"
				DataMode = 1;
			}
		}
	}
	
	// Game Start (character select / no data)
	if MenuID == 2 and Input.APress
	{
		// Load first zone
		room_goto(MQZ1);
		
		// Set data
		Game.Character = OptionID;	
		Game.Emeralds  = 0;
		Game.Lives	   = 3;
		Game.Continues = 0;
		Game.Score	   = 0;	
		
		// Save data
		if DataMode == 1
		{
			gamedata_save(Game.ActiveSave, OptionID, 0, 0, 3, 0, 0);
		}
	}
	
	// Game Start (data delete)
	if MenuID == 10 and Input.APress
	{
		// Cleat slot
		SaveData[OptionID] = 0;
		
		// Delete data
		file_delete("saveslot" + string(OptionID) + ".bin");	
		
		// Reset display data
		menu_update_option(1, OptionID + 1, "SAVE " + string(OptionID + 1) + " - NEW GAME");
	}
	
	// Stage Select (character select)
	if MenuID == 3 and Input.APress
	{
		// Set data
		Game.Character = OptionID;	
		Game.Emeralds  = 0;
		Game.Lives	   = 3;
		Game.Continues = 0;
		Game.Score	   = 0;	
	}
	
	// Stage Select (stage select)
	if MenuID == 4 and Input.APress
	{
		// Do not save any progress
		Game.ActiveSave = -1;
		
		// Load stages
		switch OptionID
		{
			case 0:
				room_goto(MQZ1);
			break;
			case 1:
				room_goto(MQZ2);
			break;
		}
	}
}