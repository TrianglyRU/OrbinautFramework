/// @description Navigation
// You can write your code in this editor
	
	// Disable fade
	Game.FadeEnabled = false;
	
	// Navigate between options
	if Input.DownPress
	{
		MenuOption += 1;
	}
	if Input.UpPress
	{
		MenuOption -= 1;
	}
	
	// Cycle through options
	switch MenuState
	{
		case 0:
		{
			if (MenuOption < 0) MenuOption = 2;
			if (MenuOption > 2) MenuOption = 0;
		}
		break;
		case 2:
		{
			if (MenuOption < 0) MenuOption = 1;
			if (MenuOption > 1) MenuOption = 0;
		}
	}
	
	// Key A
	if Input.APress
	{
		// Main menu behaviour
		if MenuState = 0
		{
			switch MenuOption
			{
				case 0: MenuState = 1; room_goto(MBZ) break;
				case 1: MenuState = 2; MenuOption = 0; break;
				case 2: game_end(); break;
			}
		}
		
		// Stage select behaviour
		if MenuState = 1
		{
		}
		
		// Options behaviour
		if MenuState = 2
		{
			switch MenuOption
			{
				case 0: Game.TileCollisionMethod = Game.TileCollisionMethod == false ? true : false; break;
				case 1: MenuState = 0; MenuOption = 1; break;
			}
		}
	}
	
	// Set Sonic
	var X = Game.ResolutionWidth / 2;
	var Y = Game.ResolutionHeight / 2;
	
	if MenuState = 0
	{
		objLoadingIcon.x = X - 70;
		switch MenuOption
		{
			case 0: objLoadingIcon.y = Y - 15 - 6; break;
			case 1: objLoadingIcon.y = Y - 6; break;
			case 2: objLoadingIcon.y = Y + 15 - 6; break;
		}
	}
	if MenuState = 2
	{
		objLoadingIcon.x = X - 105;
		switch MenuOption
		{
			case 0: objLoadingIcon.y = Y - 15 - 6; break;
			case 1: objLoadingIcon.y = Y - 6; break;
		}
	}
		
	
	