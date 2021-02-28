/// @description Options
// You can write your code in this editor
	
	var Timer  = TextTimer div 3;
	var Print  = TextPrint div 2;
	var MTimer = MainTimer div 3;
	var MPrint = MainPrint div 2;
	
	// Get centre
	var X = Game.ResolutionWidth  / 2;
	var Y = Game.ResolutionHeight / 2;
	
	// Set font to use in the room
	draw_set_halign(fa_center);
	
	// Display framework title
	string_display(X, Y - 75, "ORBINAUT FRAMEWORK", 1);
	string_display(X, Y - 65, "START MENU", 1);	
				
	switch MenuState
	{
		// Display menu 0 (main)
		case Main:
		{	
			draw_set_halign(fa_center);
			
			string_display(X, Y - 15, "STAGE SELECT",1);
			string_display(X, Y,	  "START GAME", 1);
			string_display(X, Y + 15, "OPTIONS", 1);
			string_display(X, Y + 30, "CLOSE GAME", 1);
		}
		break;
		
		// Display menu 1 (Start Game)
		case DataSelect:
		{	
			draw_set_halign(fa_center);
			string_display(X, Y - 15, "NO SAVE: NEW GAME", 1);
			string_display(X, Y,	  menu_string_display(menu_string_savedata(0), Print, Timer), 1);
			string_display(X, Y + 15, menu_string_display(menu_string_savedata(1), Print, Timer), 1);
			string_display(X, Y + 30, menu_string_display(menu_string_savedata(2), Print, Timer), 1);
			string_display(X, Y + 45, menu_string_display(menu_string_savedata(3), Print, Timer), 1);
			string_display(X, Y + 60, menu_string_display("DELETE SAVE", Print, Timer), 1);
			string_display(X, Y + 75, menu_string_display("BACK", Print, Timer), 1);
			
		}
		break;
		
		// Display menu 2 (options)
		case Options:
		{	
			draw_set_halign(fa_center);
			
			string_display(X, Y - 15, "GAMEPLAY", 1);
			string_display(X, Y,	  "VIDEO AND AUDIO", 1);
			string_display(X, Y + 15, "INPUT", 1);
			string_display(X, Y + 30, "BACK", 1);
		}
		break;
		
		// Display menu 3 (framework options)
		case FrameworkConfig:
		{
			draw_set_halign(fa_left);
			
			string_display(X - 80, Y - 15, "SPINDASH", 1);
			string_display(X - 80, Y,	   "DROPDASH", 1);
			string_display(X - 80, Y + 15, "SUPER PEEL OUT", 1);
			string_display(X - 80, Y + 30, "BACK", 1);
			
			string_display(X + 65, Y - 15, Game.SpindashEnabled ? "ON" : "OFF", 1);
			string_display(X + 65, Y,	   Game.DropdashEnabled ? "ON" : "OFF", 1);
			string_display(X + 65, Y + 15, Game.PeeloutEnabled  ? "ON" : "OFF", 1);
		}
		break;
		
		// Display menu 4 (video and audio options)
		case AudioVideoConfig:
		{
			draw_set_halign(fa_left);
			
			string_display(X - 80, Y - 15, "ASPECT RATIO", 1);
			string_display(X - 80, Y,      "WINDOW SIZE", 1);
			string_display(X - 80, Y + 15, "FULLSCREEN", 1);
			string_display(X - 80, Y + 30, "MUSIC VOLUME", 1);
			string_display(X - 80, Y + 45, "SOUND VOLUME", 1);
			string_display(X - 80, Y + 60, "BACK", 1);
			
			string_display(X + 50, Y - 15, Game.ResolutionWidth == 398 ? "16:9" : "4:3", 1);
			string_display(X + 50, Y,	   string(Game.WindowSize) + "X", 1);
			string_display(X + 50, Y + 15, Game.WindowFullscreen ? "ON" : "OFF", 1);
			string_display(X + 50, Y + 30, string(round(Game.MusicVolume * 100)), 1);
			string_display(X + 50, Y + 45, string(round(Game.SoundVolume * 100)), 1);
		}
		break;
		
		// Display menu 5 (input options)
		case InputConfig:
		{
			draw_set_halign(fa_right);
			
			string_display(X - 16, Y - 45, "UP:", 1);
			string_display(X - 16, Y - 30, "DOWN:", 1);
			string_display(X - 16, Y - 15, "LEFT:", 1);
			string_display(X - 16, Y,	   "RIGHT:", 1);
			string_display(X - 16, Y + 15, "A:", 1);
			string_display(X - 16, Y + 30, "B:", 1);
			string_display(X - 16, Y + 45, "C:", 1);
			string_display(X - 16, Y + 60, "MODE:", 1);
			string_display(X - 16, Y + 75, "START:", 1);
			string_display(X + 16, Y + 90, "BACK", 1);
			
			draw_set_halign(fa_left);
			for (var i = 0; i < 9; i++) {
				string_display(X, Y - 45 + 15 * i, menu_string_display(i == MenuOption and ChngCntrl ? ": :" : string(Game.Control[i]) + ":" + menu_input_get_keyname(Game.Control[i]), Print, Timer), 1);
			}
		}
		break;
		
		// Display menu 6 (stage select)
		case StageSelect:
		{
			draw_set_halign(fa_left);
			
			string_display(X - 80, Y - 15, "MOONLIGHT BASE 1", 1);
			string_display(X - 80, Y,	   "MOONLIGHT BASE 2", 1);
			string_display(X - 80, Y + 15, "HORIZON HEIGHTS", 1);
			string_display(X - 80, Y + 30, "BACK", 1);
		}
		
		break;
	}