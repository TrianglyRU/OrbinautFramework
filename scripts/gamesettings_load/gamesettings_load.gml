/// @function gamesettings_load()
function gamesettings_load()
{
	ini_open("config.ini");
	
	Game.MusicVolume    = ini_read_real("Music", "MusicVolume", 0.5);
	Game.SoundVolume    = ini_read_real("Music", "SoundVolume", 0.5);
	Game.WindowSize		= ini_read_real("Video", "Size",        3);
	Game.FullscreenMode = ini_read_real("Video", "Fullscreen",  false);
	
	ini_close();
}