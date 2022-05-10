/// @function settings_save()
function settings_save()
{
	ini_open("config.ini");
	
	ini_write_real("Music", "MusicVolume", global.MusicVolume);
	ini_write_real("Music", "SoundVolume", global.SoundVolume);
	ini_write_real("Video", "Size", 	   global.WindowSize);
	ini_write_real("Video", "Fullscreen",  window_get_fullscreen());
	
	ini_close();			
}