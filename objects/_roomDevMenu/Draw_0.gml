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
	string_display(X, Y - 75, menu_string_display("ORBINAUT FRAMEWORK", MPrint, MTimer), 1);
	string_display(X, Y - 65, menu_string_display("START MENU", MPrint, MTimer), 1);	
				
	switch MenuState
	{
		// Display menu 0 (main)
		case Main:
		{	
			draw_set_halign(fa_center);
			
			string_display(X, Y - 15, menu_string_display("STAGE SELECT", Print, Timer), 1);
			string_display(X, Y,	  menu_string_display("START GAME",   Print, Timer), 1);
			string_display(X, Y + 15, menu_string_display("OPTIONS",      Print, Timer), 1);
			string_display(X, Y + 30, menu_string_display("CLOSE GAME",   Print, Timer), 1);
		}
		break;
		
		// Display menu 1 (Start Game)
		case DataSelect:
		{	
			draw_set_halign(fa_center);
			string_display(X, Y - 15, menu_string_display("NO SAVE: NEW GAME", Print, Timer), 1);
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
			
			string_display(X, Y - 15, menu_string_display("GAMEPLAY", Print, Timer), 1);
			string_display(X, Y,	  menu_string_display("VIDEO AND AUDIO", Print, Timer), 1);
			string_display(X, Y + 15, menu_string_display("INPUT", Print, Timer), 1);
			string_display(X, Y + 30, menu_string_display("BACK", Print, Timer), 1);
		}
		break;
		
		// Display menu 3 (framework options)
		case FrameworkConfig:
		{
			draw_set_halign(fa_left);
			
			string_display(X - 80, Y - 15, menu_string_display("SPINDASH", Print, Timer), 1);
			string_display(X - 80, Y,	   menu_string_display("DROPDASH", Print, Timer), 1);
			string_display(X - 80, Y + 15, menu_string_display("SUPER PEEL OUT", Print, Timer), 1);
			string_display(X - 80, Y + 30, menu_string_display("BACK", Print, Timer), 1);
			
			string_display(X + 65, Y - 15, menu_string_display(Game.SpindashEnabled ? "ON" : "OFF", Print, Timer), 1);
			string_display(X + 65, Y,	   menu_string_display(Game.DropdashEnabled ? "ON" : "OFF", Print, Timer), 1);
			string_display(X + 65, Y + 15, menu_string_display(Game.PeeloutEnabled  ? "ON" : "OFF", Print, Timer), 1);
		}
		break;
		
		// Display menu 4 (video and audio options)
		case AudioVideoConfig:
		{
			draw_set_halign(fa_left);
			
			string_display(X - 80, Y - 15, menu_string_display("ASPECT RATIO", Print, Timer), 1);
			string_display(X - 80, Y,      menu_string_display("WINDOW SIZE",  Print, Timer), 1);
			string_display(X - 80, Y + 15, menu_string_display("FULLSCREEN",   Print, Timer), 1);
			string_display(X - 80, Y + 30, menu_string_display("MUSIC VOLUME", Print, Timer), 1);
			string_display(X - 80, Y + 45, menu_string_display("SOUND VOLUME", Print, Timer), 1);
			string_display(X - 80, Y + 60, menu_string_display("BACK",		   Print, Timer), 1);
			
			string_display(X + 50, Y - 15, menu_string_display(Game.ResolutionWidth == 398 ? "16:9" : "4:3", Print, Timer), 1);
			string_display(X + 50, Y,	   menu_string_display(string(Game.WindowSize) + "X",		  Print, Timer), 1);
			string_display(X + 50, Y + 15, menu_string_display(Game.WindowFullscreen ? "ON" : "OFF",  Print, Timer), 1);
			string_display(X + 50, Y + 30, menu_string_display(string(round(Game.MusicVolume * 100)), Print, Timer), 1);
			string_display(X + 50, Y + 45, menu_string_display(string(round(Game.SoundVolume * 100)), Print, Timer), 1);
		}
		break;
		
		// Display menu 5 (input options)
		case InputConfig:
		{
			draw_set_halign(fa_right);
			
			string_display(X - 16, Y - 45, menu_string_display("UP:",    Print, Timer), 1);
			string_display(X - 16, Y - 30, menu_string_display("DOWN:",  Print, Timer), 1);
			string_display(X - 16, Y - 15, menu_string_display("LEFT:",  Print, Timer), 1);
			string_display(X - 16, Y,	   menu_string_display("RIGHT:", Print, Timer), 1);
			string_display(X - 16, Y + 15, menu_string_display("A:",	 Print, Timer), 1);
			string_display(X - 16, Y + 30, menu_string_display("B:",	 Print, Timer), 1);
			string_display(X - 16, Y + 45, menu_string_display("C:",     Print, Timer), 1);
			string_display(X - 16, Y + 60, menu_string_display("MODE:",  Print, Timer), 1);
			string_display(X - 16, Y + 75, menu_string_display("START:", Print, Timer), 1);
			string_display(X + 16, Y + 90, menu_string_display("BACK",	 Print, Timer), 1);
			
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
			
			string_display(X - 80, Y - 15, menu_string_display("MOONLIGHT BASE ZONE", Print, Timer), 1);
			string_display(X - 80, Y,	   menu_string_display("HORIZON HEIGHTS ZONE", Print, Timer), 1);
			string_display(X - 80, Y + 15, menu_string_display("BACK", Print, Timer), 1);
		}
		
		break;
	}