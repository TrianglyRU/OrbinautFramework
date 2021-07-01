function gamesettings_save(filename)
{
	ini_open(filename + ".ini");
	
	ini_write_real("Control", "Start",      Game.KeyboardControl[8]);
	ini_write_real("Control", "Mode",       Game.KeyboardControl[7]);
	ini_write_real("Control", "C",	        Game.KeyboardControl[6]);
	ini_write_real("Control", "B",	        Game.KeyboardControl[5]);
	ini_write_real("Control", "A",	        Game.KeyboardControl[4]);
	ini_write_real("Control", "Right",      Game.KeyboardControl[3]);
	ini_write_real("Control", "Left",       Game.KeyboardControl[2]);
	ini_write_real("Control", "Down",	    Game.KeyboardControl[1]);
	ini_write_real("Control", "Up",		    Game.KeyboardControl[0]);
	ini_write_real("Music", "SoundVolume",         Game.SoundVolume);
	ini_write_real("Music", "MusicVolume",         Game.MusicVolume);
	ini_write_real("Video", "Fullscreen",     Game.WindowFullscreen);
	ini_write_real("Video", "WindowSize", 	        Game.WindowSize);
	ini_write_real("Video", "ResHeight",	  Game.ResolutionHeight);
	ini_write_real("Video", "ResWidth",		   Game.ResolutionWidth);
	
	ini_close();
	/*ini_write_real("Gameplay", "FlyCancel",       Game.FlyingCancel);
	ini_write_real("Gameplay", "OgRollLimit", Game.NoRollSpeedLimit);
	ini_write_real("Gameplay", "CDCamera",      Game.ExtendedCamera);
	ini_write_real("Gameplay", "RlljmpCtrl",   Game.RolljumpControl);
	ini_write_real("Gameplay", "AirSpeedcap",      Game.AirSpeedcap);
	ini_write_real("Gameplay", "GndSpeedcap",	Game.GroundSpeedcap);
	ini_write_real("Gameplay", "Peelout",		Game.PeeloutEnabled);
	ini_write_real("Gameplay", "Dropdash",	   Game.DropdashEnabled);
	ini_write_real("Gameplay", "Spindash",     Game.SpindashEnabled);*/			
}