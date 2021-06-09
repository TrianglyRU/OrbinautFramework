function GameLoadSettings()
{
	if Game.DevMode
	{
		exit;
	}
	
	ini_open("config.ini");
		
	// Gameplay
	Game.SpindashEnabled   = ini_read_real("Gameplay", "Spindash",    true);
	Game.DropdashEnabled   = ini_read_real("Gameplay", "Dropdash",    false);
	Game.PeeloutEnabled	   = ini_read_real("Gameplay", "Peelout",     false);
	Game.GroundSpeedcap	   = ini_read_real("Gameplay", "GndSpeedcap", false);
	Game.AirSpeedcap	   = ini_read_real("Gameplay", "AirSpeedcap", false);
	Game.RolljumpControl   = ini_read_real("Gameplay", "RlljmpCtrl",  true);	 
	Game.ExtendedCamera	   = ini_read_real("Gameplay", "CDCamera",    false);
	Game.OriginalRollLimit = ini_read_real("Gameplay", "OgRollLimit", true);	
	Game.FlyingCancel	   = ini_read_real("Gameplay", "FlyCancel",   true); 
	
	// Video
	Game.ResolutionWidth  = ini_read_real("Video", "ResWidth",  400);
	Game.ResolutionHeight = ini_read_real("Video", "ResHeight", 224);
	Game.WindowSize		  = ini_read_real("Video", "WindowSize",  2);
	Game.WindowFullscreen = ini_read_real("Video", "Fullscreen",  0);
	
	// Music
	Game.MusicVolume = ini_read_real("Music", "MusicVolume", 0.3);
	Game.SoundVolume = ini_read_real("Music", "SoundVolume", 0.3);
	
	// Control
	Game.KeyboardControl[0] = ini_read_real("Control", "Up",	   vk_up);
	Game.KeyboardControl[1] = ini_read_real("Control", "Down",	 vk_down);
	Game.KeyboardControl[2] = ini_read_real("Control", "Left",	 vk_left);
	Game.KeyboardControl[3] = ini_read_real("Control", "Right", vk_right);
	Game.KeyboardControl[4] = ini_read_real("Control", "A",		ord("A"));
	Game.KeyboardControl[5] = ini_read_real("Control", "B",		ord("S"));
	Game.KeyboardControl[6] = ini_read_real("Control", "C",		ord("D"));
	Game.KeyboardControl[7] = ini_read_real("Control", "Mode",	vk_space);
	Game.KeyboardControl[8] = ini_read_real("Control", "Start", vk_enter);
	
	ini_close();
}