/// @function gamesettings_load(filename)
function gamesettings_load(filename)
{
	// Exit if in dev mode
	if Game.DevMode
	{
		exit;
	}
	
	// Open file
	ini_open(filename + ".ini");
		
	Game.SpindashEnabled    = ini_read_real("Gameplay", "Spindash",    true);
	Game.DropdashEnabled    = ini_read_real("Gameplay", "Dropdash",    false);
	Game.PeeloutEnabled	    = ini_read_real("Gameplay", "Peelout",     false);
	Game.GroundSpeedcap	    = ini_read_real("Gameplay", "GndSpeedcap", false);
	Game.AirSpeedcap	    = ini_read_real("Gameplay", "AirSpeedcap", false);
	Game.ExtendedCamera	    = ini_read_real("Gameplay", "CDCamera",    false);
	Game.ResolutionWidth    = ini_read_real("Video",	"Width",       400);
	Game.ResolutionHeight   = ini_read_real("Video",	"Height",      224);
	Game.WindowSize		    = ini_read_real("Video",	"Size",        2);
	Game.WindowFullscreen   = ini_read_real("Video",	"Fullscreen",  0);
	Game.MusicVolume        = ini_read_real("Music",	"MusicVolume", 0.5);
	Game.SoundVolume        = ini_read_real("Music",	"SoundVolume", 0.5);
	Game.KeyboardControl[0] = ini_read_real("Control",  "Up",		   vk_up);
	Game.KeyboardControl[1] = ini_read_real("Control",	"Down",		   vk_down);
	Game.KeyboardControl[2] = ini_read_real("Control",	"Left",		   vk_left);
	Game.KeyboardControl[3] = ini_read_real("Control",	"Right",	   vk_right);
	Game.KeyboardControl[4] = ini_read_real("Control",	"A",		   ord("Z"));
	Game.KeyboardControl[5] = ini_read_real("Control",	"B",		   ord("X"));
	Game.KeyboardControl[6] = ini_read_real("Control",	"C",		   ord("C"));
	Game.KeyboardControl[7] = ini_read_real("Control",	"Mode",		   vk_space);
	Game.KeyboardControl[8] = ini_read_real("Control",	"Start",	   vk_enter);
	
	// Close file
	ini_close();
}