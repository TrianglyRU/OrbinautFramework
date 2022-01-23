/// @function gamesettings_save(filename)
function gamesettings_save(filename)
{
	ini_open(filename + ".ini");
	
	ini_write_real("Music", "MusicVolume", Game.MusicVolume);
	ini_write_real("Music", "SoundVolume", Game.SoundVolume);
	ini_write_real("Video", "Size", 	   Game.WindowSize);
	ini_write_real("Video", "Fullscreen",  window_get_fullscreen());
	
	ini_close();			
}