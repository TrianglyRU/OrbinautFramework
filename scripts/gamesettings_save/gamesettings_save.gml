function gamesettings_save()
{
	ini_open("config.ini");
	
	// Gameplay
	ini_write_real("Gameplay", "Spindash", Game.SpindashEnabled);
	ini_write_real("Gameplay", "Dropdash", Game.DropdashEnabled);
	ini_write_real("Gameplay", "Peelout",   Game.PeeloutEnabled);
	
	// Video
	ini_write_real("Video", "ResWidth",    Game.ResolutionWidth);
	ini_write_real("Video", "ResHeight",  Game.ResolutionHeight);
	ini_write_real("Video", "WindowSize", 	    Game.WindowSize);
	ini_write_real("Video", "Fullscreen", Game.WindowFullscreen);
	
	// Music
	ini_write_real("Music", "MusicVolume", Game.MusicVolume);
	ini_write_real("Music", "SoundVolume", Game.SoundVolume);
	
	// Control
	ini_write_real("Control", "Up",	   Game.Control[0]);
	ini_write_real("Control", "Down",  Game.Control[1]);
	ini_write_real("Control", "Left",  Game.Control[2]);
	ini_write_real("Control", "Right", Game.Control[3]);
	ini_write_real("Control", "A",	   Game.Control[4]);
	ini_write_real("Control", "B",	   Game.Control[5]);
	ini_write_real("Control", "C",	   Game.Control[6]);
	ini_write_real("Control", "Mode",  Game.Control[7]);
	ini_write_real("Control", "Start", Game.Control[8]);

	ini_close();
}