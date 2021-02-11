/// @description Navigation
// You can write your code in this editor
	
	if (TextTimer < 60) TextTimer++;
	if (TextPrint < 40) TextPrint++;
	if (MainTimer < 60) MainTimer++;
	if (MainPrint < 40) MainPrint++;
	
	// Disable fade
	Game.FadeEnabled = false;
	
	// Navigate between options
	if (Input.DownPress) MenuOption++;
	if (Input.UpPress)   MenuOption--;
	
	// Cycle through options
	var LinesCount;
	switch MenuState
	{
		case 0: LinesCount = 3 break;
		case 2: LinesCount = 2 break;
	}
	MenuOption = wrap_zero(MenuOption, LinesCount);
	
	// Key A
	if Input.APress
	{
		switch MenuState
		{
			// Main menu behaviour
			case 0:
			{
				switch MenuOption
				{
					case 0: MenuState = 1; room_goto(MBZ) break;
					case 1: 
					{
						MenuState = 2; MenuOption = 0; 
						TextTimer = 0; TextPrint = 0; 
					} 
					break;
					case 2: game_end(); break;
				}
			}
			break;
		
			// Stage select behaviour
			case 1:
			{
		
			}
			break;
		
			// Options behaviour
			case 2:
			{
				switch MenuOption
				{
					case 0: Game.TileCollisionMethod = Game.TileCollisionMethod == false ? true : false; break;
					case 1: 
					{
					MenuState = 0; MenuOption = 1; 
					TextTimer = 0; TextPrint = 0;
					}
					break;
				}
			}
			break;
			// Control behaviour
			case 3:
			{
				switch MenuOption
				{
					case 0: break;
					case 1: break;
				}
			}
			break;
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