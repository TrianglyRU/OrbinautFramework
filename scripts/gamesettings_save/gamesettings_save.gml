/// @function gamesettings_save(filename)
function gamesettings_save(filename)
{
	// Open config file
	ini_open(filename + ".ini");
	
	// Write data
	ini_write_real("Control",  "Up",			 Game.KeyboardControl[0]);
	ini_write_real("Control",  "Down",			 Game.KeyboardControl[1]);
	ini_write_real("Control",  "Left",			 Game.KeyboardControl[2]);
	ini_write_real("Control",  "Right",			 Game.KeyboardControl[3]);
	ini_write_real("Control",  "A",				 Game.KeyboardControl[4]);
	ini_write_real("Control",  "B",				 Game.KeyboardControl[5]);
	ini_write_real("Control",  "C",				 Game.KeyboardControl[6]);
	ini_write_real("Control",  "Mode",			 Game.KeyboardControl[7]);
	ini_write_real("Control",  "Start",			 Game.KeyboardControl[8]);
	ini_write_real("Video",    "Width",			 Game.Width);
	ini_write_real("Video",    "Height",		 Game.Height);
	ini_write_real("Video",    "Size", 			 Game.WindowSize);
	ini_write_real("Video",    "Fullscreen",	 Game.WindowFullscreen);
	ini_write_real("Music",    "MusicVolume",	 Game.MusicVolume);
	ini_write_real("Music",    "SoundVolume",	 Game.SoundVolume);
	
	// Close file
	ini_close();			
}