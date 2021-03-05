function gamesettings_load()
{
	ini_open("config.ini");
	
	// Gameplay
	Game.SpindashEnabled = ini_read_real("Gameplay", "Spindash", 1);
	Game.DropdashEnabled = ini_read_real("Gameplay", "Dropdash", 0);
	Game.PeeloutEnabled	 = ini_read_real("Gameplay", "Peelout",  1);
	
	// Video
	Game.ResolutionWidth  = ini_read_real("Video", "ResWidth",  398);
	Game.ResolutionHeight = ini_read_real("Video", "ResHeight", 224);
	Game.WindowSize		  = ini_read_real("Video", "WindowSize",  2);
	Game.WindowFullscreen = ini_read_real("Video", "Fullscreen",  0);
	
	// Music
	Game.MusicVolume = ini_read_real("Music", "MusicVolume", 0.3);
	Game.SoundVolume = ini_read_real("Music", "SoundVolume", 0.3);
	
	// Control
	Game.Control[0] = ini_read_real("Control", "Up",	   vk_up);
	Game.Control[1] = ini_read_real("Control", "Down",	 vk_down);
	Game.Control[2] = ini_read_real("Control", "Left",	 vk_left);
	Game.Control[3] = ini_read_real("Control", "Right", vk_right);
	Game.Control[4] = ini_read_real("Control", "A",		ord("A"));
	Game.Control[5] = ini_read_real("Control", "B",		ord("S"));
	Game.Control[6] = ini_read_real("Control", "C",		ord("D"));
	Game.Control[7] = ini_read_real("Control", "Mode",	vk_space);
	Game.Control[8] = ini_read_real("Control", "Start", vk_enter);
	
	ini_close();
}