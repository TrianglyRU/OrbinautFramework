function MenuConfiguration()
{
	// Main Menu
	var StageAccess = Game.DevMode ? 3 : noone;
	
	menu_add_header(0,    "ORBINAUT FRAMEWORK" + "\n\nDEV MENU");
	menu_add_option(0, 0, "GAME START",		  1);
	menu_add_option(0, 1, "STAGE SELECT",     StageAccess);
	menu_add_option(0, 2, "OPTIONS",	      5);
	menu_add_option(0, 3, "EXIT GAME",    noone);

	// Game Start
	menu_add_header(1,    "SELECT A SAVE FILE");
	menu_add_option(1, 0, "NO SAVE MODE",		  2);
	menu_add_option(1, 1, string(DisplayData[0]), 2);
	menu_add_option(1, 2, string(DisplayData[1]), 2);
	menu_add_option(1, 3, string(DisplayData[2]), 2);
	menu_add_option(1, 4, string(DisplayData[3]), 2);
	menu_add_option(1, 5, "DELETE SAVE",		  10);
	
	// Game Start (delete data)
	menu_add_header(10,    "SELECT A SAVE FILE TO DELETE");
	menu_add_option(10, 0, "SLOT 1", 1);
	menu_add_option(10, 1, "SLOT 2", 1);
	menu_add_option(10, 2, "SLOT 3", 1);
	menu_add_option(10, 3, "SLOT 4", 1);
	
	// Game Start (character select)
	menu_add_header(2,    "SELECT A PLAYER");
	menu_add_option(2, 0, "SONIC",    noone);
	menu_add_option(2, 1, "TAILS",	  noone);
	menu_add_option(2, 2, "KNUCKLES", noone);
	
	// Stage Select (character select)
	menu_add_header(3,    "SELECT A PLAYER");
	menu_add_option(3, 0, "SONIC",    4);
	menu_add_option(3, 1, "TAILS",	  4);
	menu_add_option(3, 2, "KNUCKLES", 4);
	
	// Stage Select
	menu_add_header(4,    "SELECT A STAGE");
	menu_add_option(4, 0, "MQZ1", noone);
	menu_add_option(4, 1, "MQZ2", noone);
	menu_add_option(4, 2, "MQZ0", noone);
	
	// Options
	menu_add_header(5,    "GAME OPTIONS");
	menu_add_option(5, 0, "GAMEPLAY", noone);
	menu_add_option(5, 1, "VIDEO",    7);
	menu_add_option(5, 2, "AUDIO",    8);
	menu_add_option(5, 3, "CONTROLS", noone);
	
	// Options (gameplay)
	/*
	*/
	
	// Options (video)
	var FullscreenStatus = Game.WindowFullscreen ? "TRUE" : "FALSE";
	
	menu_add_header(7,    "VIDEO OPTIONS");
	menu_add_option(7, 0, "WINDOW SIZE: " + string(Game.WindowSize) + "X", noone);
	menu_add_option(7, 1, "FULLSCREEN: "  + string(FullscreenStatus),	   noone);
	
	// Options (audio)
	menu_add_header(8,    "AUDIO OPTIONS");
	menu_add_option(8, 0, "SFX VOLUME: " + string(Game.SoundVolume * 100), noone);
	menu_add_option(8, 1, "BGM VOLUME: " + string(Game.MusicVolume * 100), noone);
	
	// Options (controls)
	/*
	*/
}