/// @self
/// @description Loads the configuration file ("config.ini").
function game_load_settings()
{
	if !global.load_config_on_start
	{
		return;
	}
	
	ini_open("config.ini");
	
	global.gamepad_rumble = ini_read_real("INPUT", "gamepadRumble", global.gamepad_rumble);
	global.music_volume = ini_read_real("AUDIO", "bgmVolume", global.music_volume);
	global.sound_volume = ini_read_real("AUDIO", "sfxVolume", global.sound_volume);
	global.window_scale = ini_read_real("VIDEO", "windowScale", global.window_scale);
	global.vsync = ini_read_real("VIDEO", "vSync", global.vsync);
	global.start_fullscreen = ini_read_real("VIDEO", "fullscreenEnabled", global.start_fullscreen);
	global.start_exclusive_fullscreen = ini_read_real("VIDEO", "fullscreenExclusive", global.start_exclusive_fullscreen);
	
	ini_close();
}