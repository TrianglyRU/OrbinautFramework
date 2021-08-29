function MenuSetup()
{
	// Main Menu
	menu_add_header(0,    "ORBINAUT FRAMEWORK" + "\n\nDEV MENU");
	menu_add_option(0, 0, "GAME START");
	menu_add_option(0, 1, "STAGE SELECT");
	menu_add_option(0, 2, "OPTIONS");
	menu_add_option(0, 3, "EXIT GAME");

	// Game Start
	menu_add_header(1,    "SELECT A SAVE FILE");
	menu_add_option(1, 0, "NO SAVE MODE");
	menu_add_option(1, 1, string(DisplayData[0]));
	menu_add_option(1, 2, string(DisplayData[1]));
	menu_add_option(1, 3, string(DisplayData[2]));
	menu_add_option(1, 4, string(DisplayData[3]));
	menu_add_option(1, 5, "DELETE SAVE");
	
	// Game Start (delete data)
	menu_add_header(10,    "SELECT A SAVE FILE TO DELETE");
	menu_add_option(10, 0, "SLOT 1");
	menu_add_option(10, 1, "SLOT 2");
	menu_add_option(10, 2, "SLOT 3");
	menu_add_option(10, 3, "SLOT 4");
	
	// Game Start (character select)
	menu_add_header(2,    "SELECT A PLAYER");
	menu_add_option(2, 0, "SONIC");
	menu_add_option(2, 1, "TAILS");
	menu_add_option(2, 2, "KNUCKLES");
	
	// Stage Select (character select)
	menu_add_header(3,    "SELECT A PLAYER");
	menu_add_option(3, 0, "SONIC");
	menu_add_option(3, 1, "TAILS");
	menu_add_option(3, 2, "KNUCKLES");
	
	// Stage Select
	menu_add_header(4,    "SELECT A STAGE");
	menu_add_option(4, 0, "TSZ");
	menu_add_option(4, 1,  "- -");
	menu_add_option(4, 2,  "- -");
	menu_add_option(4, 3,  "- -");
	menu_add_option(4, 4,  "- -");
	menu_add_option(4, 5,  "- -");
	menu_add_option(4, 6,  "- -");
	menu_add_option(4, 7,  "- -");
	menu_add_option(4, 8,  "- -");
	menu_add_option(4, 9,  "- -");
	menu_add_option(4, 10, "- -");
	
	// Options
	menu_add_header(5,    "GAME OPTIONS");
	menu_add_option(5, 0, "GAMEPLAY");
	menu_add_option(5, 1, "VIDEO");
	menu_add_option(5, 2, "AUDIO");
	menu_add_option(5, 3, "CONTROLS");
	
	// Options (gameplay)
	var Spindash  = menu_get_boolean(Game.SpindashEnabled);
	var Peelout   = menu_get_boolean(Game.PeeloutEnabled);
	var Dropdash  = menu_get_boolean(Game.DropdashEnabled);
	var GroundCap = menu_get_boolean(Game.GroundSpeedcap);
	var AirCap    = menu_get_boolean(Game.AirSpeedcap);
	var CDCamera  = menu_get_boolean(Game.CDCamera);
	
	menu_add_header(6,    "GAMEPLAY OPTIONS");
	menu_add_option(6, 0, "SPINDASH: "   + string(Spindash));
	menu_add_option(6, 1, "PEELOUT: "    + string(Peelout));
	menu_add_option(6, 2, "DROPDASH: "   + string(Dropdash));
	menu_add_option(6, 3, "GRN SPDCAP: " + string(GroundCap));
	menu_add_option(6, 4, "AIR SPDCAP: " + string(AirCap));
	menu_add_option(6, 5, "CD CAMERA: "  + string(CDCamera));
	
	// Options (video)
	var Fullscreen = menu_get_boolean(Game.WindowFullscreen);
	var PostProcessing = menu_get_boolean(Game.PostProcessing);
	
	menu_add_header(7,    "VIDEO OPTIONS");
	menu_add_option(7, 0, "WINDOW SIZE: "     + string(Game.WindowSize) + "X");
	menu_add_option(7, 1, "FULLSCREEN: "	  + string(Fullscreen));
	menu_add_option(7, 2, "POST-PROCESSING: " + string(PostProcessing));
	
	// Options (audio)
	menu_add_header(8,    "AUDIO OPTIONS");
	menu_add_option(8, 0, "SFX VOLUME: " + string(round(Game.SoundVolume * 100)));
	menu_add_option(8, 1, "BGM VOLUME: " + string(round(Game.MusicVolume * 100)));
	
	// Options (controls)
	menu_add_header(9,    "CONTROL OPTIONS");
	menu_add_option(9, 0, "UP:"    + menu_get_keyname(Game.KeyboardControl[0]));
	menu_add_option(9, 1, "DOWN:"  + menu_get_keyname(Game.KeyboardControl[1]));
	menu_add_option(9, 2, "LEFT:"  + menu_get_keyname(Game.KeyboardControl[2]));
	menu_add_option(9, 3, "RIGHT:" + menu_get_keyname(Game.KeyboardControl[3]));
	menu_add_option(9, 4, "A:"     + menu_get_keyname(Game.KeyboardControl[4]));
	menu_add_option(9, 5, "B:"     + menu_get_keyname(Game.KeyboardControl[5]));
	menu_add_option(9, 6, "C:"	   + menu_get_keyname(Game.KeyboardControl[6]));
	menu_add_option(9, 7, "MODE:"  + menu_get_keyname(Game.KeyboardControl[7]));
	menu_add_option(9, 8, "START:" + menu_get_keyname(Game.KeyboardControl[8]));
}