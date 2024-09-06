/// @self
/// @description Saves settings to the configuration file ("config.ini")
function game_save_settings()
{
	// Open the configuration file for writing
	ini_open("config.ini");

	// Write settings to the configuration file
	ini_write_real("INPUT", "gamepadRumble", global.gamepad_rumble);
	ini_write_real("AUDIO", "bgmVolume", global.music_volume);
	ini_write_real("AUDIO", "sfxVolume", global.sound_volume);
	ini_write_real("VIDEO", "vSync", global.use_vsync);
	ini_write_real("VIDEO", "windowScale", global.window_scale);
	ini_write_real("VIDEO", "windowMode", window_get_fullscreen());

	// Close the configuration file and create a save confirmation object
	ini_close();
	instance_create_depth(0, 0, 0, obj_gui_save);
}