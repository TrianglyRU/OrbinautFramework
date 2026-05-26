/// @description Startup

// Common
global.tile_widths = ds_map_create();
global.tile_heights = ds_map_create();
global.tile_angles = ds_map_create();
global.font_data = ds_map_create();
global.gamepads = ds_list_create();
global.looped_bgm = ds_list_create();
global.discord_data = ["", "", "", ""];
global.previous_room_id = room;
global.current_save_slot = undefined;
global.game_progress_flag = 0;
global.debug_collision = false;
global.debug_framework = false;

// Sonic-related
global.ring_spill_counter = 0;
global.player_rings = 0;
global.ring_sound_counter = 0;
global.selected_level_entry = 0;
global.selected_sound_index = 0;
global.selected_player_index = 0;
global.checkpoint_data = [];
global.giant_ring_data = [];
global.stage_transition_data = undefined;
global.life_rewards = [RINGS_THRESHOLD, SCORE_THRESHOLD];
global.player_shields = array_create(PLAYER_MAX_COUNT, SHIELD.NONE);
global.giant_rings = ds_list_create();

// Game setup
randomise();
scr_game_setup();
game_load_settings();

if global.dev_mode
{
	global.window_name += " (Developer Mode)";
}

audio_group_load(audiogroup_global);

display_reset(0, global.vsync);
window_set_caption(global.window_name);
window_enable_borderless_fullscreen(!global.start_exclusive_fullscreen);

if global.start_fullscreen
{
	window_enable_fullscreen();
}
else
{
	window_resize();
}

room_goto(global.start_room);