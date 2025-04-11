/// @function scr_fw_game_setup
function scr_fw_game_setup()
{
	// Developer mode. Enables dev shortcuts && room select
	global.dev_mode = false;
	
	// Default settings. Some of them may be overwritten by the config file
	global.window_name = "Orbinaut Framework 2"
	global.init_resolution_w = 400;
	global.init_resolution_h = 224;
	global.window_scale = 2;
	global.use_vsync = true;
	global.gamepad_rumble = false;
	global.music_volume = 0.5;
	global.sound_volume = 0.5;
	global.debug_collision = 0;
	global.start_room = rm_devmenu;
	global.skip_branding = false;
	global.discord_app_id = "1213647618434011196";
	
	// Fonts
	global.font_large = font_register(spr_font_large, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", true, 0);
	global.font_large_alt = font_register(spr_font_large_alt, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", true, 0);
	global.font_small = font_register(spr_font_small, "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890*.:!-+_", false, 0);
	global.font_digits = font_register(spr_font_digits, "0123456789:';", false, 1);
	global.font_digits_alt = font_register(spr_font_digits_alt, "0123456789:';", false, 1);
	global.font_digits_small = font_register(spr_font_digits_small, "0123456789", false, 1);
	global.font_system = font_register(spr_font_system, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890.:,;'(!?)+-*=_[]{}<>|#$%&^@~/", false, 0);
	
	// Common
	global.stage_index = 0;
	global.previous_room_id = 0;
	global.current_save_slot = -1;		// -1 by default, which is no-save slot. Do not change it here
	
	// SONIC FRAMEWORK
	
	// Originals differences
	global.player_physics = PHYSICS_S2;
	global.cpu_behaviour = CPU_BEHAVIOUR_S3;
	global.spin_dash = true;
	global.dash	= true;
	global.drop_dash = true;
	global.double_spin = true;
	global.cd_timer = false;
	global.cd_camera = false;
	
	// Orbinaut improvements
	global.rotation_mode = 1;
	global.no_roll_lock	= false;
	global.no_speed_cap = true;
	global.fix_jump_size = true;
	global.fix_dash_release = true;
	global.better_solid_collision = false;
	global.no_camera_cap = false;
	
	// Common
	global.ds_giant_rings = ds_list_create();
	global.checkpoint_data = [];
	global.giant_ring_data = [];
	global.life_rewards = [];
	global.enable_debug_mode = false;
	global.player_main = PLAYER_SONIC;
	global.player_cpu = PLAYER_NOONE;
	global.continue_count = 0;
	global.emerald_count = 0;
	global.life_count = 0;
	global.score_count = 0;
	global.player_rings = 0;
	global.player_shield = array_create(ENGINE_PLAYER_MAX_COUNT, SHIELD_NONE);
	
	// Shader & effect processing. Disable only for debugging purposes
	global.gfx_enabled = true;
	
	// Tools
	global.tools_binary_collision = false;
}
