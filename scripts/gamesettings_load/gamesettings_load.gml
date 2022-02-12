/// @function gamesettings_load()
function gamesettings_load()
{
	ini_open("config.ini");
	
	global.MusicVolume    = ini_read_real("Music", "MusicVolume", 0.5);
	global.SoundVolume    = ini_read_real("Music", "SoundVolume", 0.5);
	global.WindowSize		= ini_read_real("Video", "Size",        3);
	global.FullscreenMode = ini_read_real("Video", "Fullscreen",  false);
	
	ini_close();
}