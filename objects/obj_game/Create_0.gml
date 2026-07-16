/// @description Initialisation
if room == rm_startup
{
	return;
}

enum GAME_STATE
{
	NORMAL, STOP_OBJECTS, STOP_ALL
}

enum SAVE_DATA_STATE
{
	EMPTY,
	EXISTS,
	CLEAR
}

#macro GLOBAL_PARAM_GRV 0.21875
#macro GAME_PROGRESS_MAX 255
#macro RINGS_THRESHOLD 100
#macro SCORE_THRESHOLD 50000
#macro ANGLE_RAW_MAX 256
#macro ANGLE_INCREMENT (360 / ANGLE_RAW_MAX)
#macro FRAME_COUNTER obj_game.frame_counter

#macro PLAYER_MAX_COUNT 8
#macro PLAYER_COUNT obj_game.player_count
#macro FOR_EACH_PLAYER for (var _p = 0; _p < PLAYER_COUNT; _p++)

state = GAME_STATE.NORMAL; 
frame_counter = 0;
oscillation_angle = 0;
player_count = 0;
allow_pause = false;
clear_vram_on_room_end = true;
depth = 16000;

#region AUDIO

enum CHANNEL_STATE
{
	DEFAULT, MUTE, TEMP_MUTE, STOP
}

#macro AUDIO_CHANNEL_COUNT 4
#macro AUDIO_CHANNEL_JINGLE (AUDIO_CHANNEL_COUNT - 1)

audio_channel_states = array_create(AUDIO_CHANNEL_COUNT, CHANNEL_STATE.DEFAULT);
audio_channel_bgms = array_create(AUDIO_CHANNEL_COUNT, undefined);
audio_emitter_bgm = array_create(AUDIO_CHANNEL_COUNT, undefined);
audio_emitter_sfx = audio_emitter_create();
audio_bus_sfx = audio_bus_create();
audio_bus_bgm = audio_bus_create();

audio_emitter_bus(audio_emitter_sfx, audio_bus_sfx);
audio_emitter_gain(audio_emitter_sfx, global.sound_volume);

for (var _i = 0; _i < AUDIO_CHANNEL_COUNT; _i++)
{
	audio_emitter_bgm[_i] = audio_emitter_create();
	
	audio_emitter_bus(audio_emitter_bgm[_i], audio_bus_bgm);
	audio_emitter_gain(audio_emitter_bgm[_i], global.music_volume);
}

#endregion

#region BACKGROUND

bg_distance_x = 0;
bg_distance_y = 0;
bg_scroll_x = 0;
bg_scroll_y = 0;

#endregion

#region COLLISION

enum COLLISION_LAYER
{
    MAIN = 0,
	PATH_A = 1,
	PATH_B = 2
}

#macro TILE_COUNT 256
#macro TILE_SIZE 16
#macro TILE_EMPTY_ANGLE -4

/// @function _get_layer
var _get_layer = function(_layer)
{
	return layer_exists(_layer) ? layer_tilemap_get_id(_layer) : -1;
}

angle_map = ds_map_create();
markers = ds_map_create();

var _marker_ids = 
[
	_get_layer("Markers_Main"), _get_layer("Markers_A"), _get_layer("Markers_B")
];

// MAIN 0, PATH_A 1, PATH_B 2
tilemaps =
[
	_get_layer("Collision_Main"), _get_layer("Collision_A"), _get_layer("Collision_B")	
];

for (var _i = 0; _i < array_length(tilemaps); _i++)
{
	markers[? tilemaps[_i]] = _marker_ids[_i];
}

#endregion

#region CULLING

#macro CULLING_ROUND_VALUE 128
#macro CULLING_ADD_WIDTH 320
#macro CULLING_ADD_HEIGHT 288

restore_stopped_objects = function()
{
	var _list_size = ds_list_size(stopped_objects);
	
	if _list_size > 0
	{
		for (var _i = _list_size - 1; _i >= 0; _i--)
		{
			instance_activate_object(stopped_objects[| _i]);
		}
		
		ds_list_clear(stopped_objects);
	}
}

stopped_objects = ds_list_create();

#endregion

#region DEBUG

debug_get_state_name = function()
{
	switch state
	{
		case GAME_STATE.NORMAL: return "NORMAL";
		case GAME_STATE.STOP_OBJECTS: return "STPOBJ";
		case GAME_STATE.STOP_ALL: return "STPALL";
		default: return "UNKNWN";
	}
}

#endregion

#region DEFORMATION

deformation_timer = 0;
deformation_bound = room_height;
deformations_data = ds_list_create();

#endregion

#region FADE

enum FADE_STATE
{
    ACTIVE, PLAIN_COLOUR, NONE
}

enum FADE_TYPE
{
    BLACK_ORDER = 0,
	BLACK_SYNC = 1, 
	DULL_ORDER = 2, 
	DULL_SYNC = 3, 
	WHITE_ORDER = 4,
	WHITE_SYNC = 5, 
	FLASH_ORDER = 6, 
	FLASH_SYNC = 7,
	NONE = -1
}

enum FADE_DIRECTION
{
    IN, OUT, NONE
}

#macro FADE_TIMER_MAX 765		// 255 * 3
#macro FADE_STEP 36.4285714285	// 255 / 7

fade_effect = fx_create("_filter_layer_rgb_fade");
fade_timer = FADE_TIMER_MAX;
fade_direction = FADE_DIRECTION.NONE;
fade_type = FADE_TYPE.NONE;
fade_state = FADE_STATE.NONE;
fade_target_game_state = GAME_STATE.STOP_ALL;
fade_step = 0;
fade_frequency_timer = 0;
fade_frequency_target = 0;
fade_in_action = undefined;
fade_out_action = undefined;

if fade_effect != -1
{
	layer_set_fx(layer, fade_effect);
}

#endregion

#region INPUT

#macro INPUT_SLOT_COUNT 4
#macro INPUT_GAMEPAD_DEADZONE 0.15
#macro INPUT_RUMBLE_LIGHT 0.1
#macro INPUT_RUMBLE_MEDIUM 0.3
#macro INPUT_RUMBLE_STRONG 0.6

input_rumble_time_left = array_create(INPUT_SLOT_COUNT, 0);
input_down = ds_list_create();
input_press = ds_list_create();

for (var _i = 0; _i < INPUT_SLOT_COUNT; _i++)
{
	input_down[| _i] = input_create();
	input_press[| _i] = input_create();
}

#endregion

#region PALETTE

// Should match sh_palette_map limit
#macro PALETTE_TOTAL_SLOT_COUNT 256

palette_bound = room_height;
palette_durations = array_create(PALETTE_TOTAL_SLOT_COUNT, 0);
palette_timers = array_create(PALETTE_TOTAL_SLOT_COUNT, 0);
palette_indices = array_create(PALETTE_TOTAL_SLOT_COUNT, 1);
palette_loop_indices = array_create(PALETTE_TOTAL_SLOT_COUNT, 0);
palette_end_indices = array_create(PALETTE_TOTAL_SLOT_COUNT, 0);
palette_data = [undefined, undefined];

#endregion

#region RENDERER

#macro draw_colour draw_get_colour()
#macro draw_color draw_get_colour()

#macro RENDER_APPLICATION_WIDTH surface_get_width(application_surface)
#macro RENDER_APPLICATION_HEIGHT surface_get_height(application_surface)
#macro RENDER_DEPTH_OVERLAY -25
#macro RENDER_DEPTH_HUD_PRIORITY 0
#macro RENDER_DEPTH_HUD 25
#macro RENDER_DEPTH_PRIORITY 50

#macro VIEW_COUNT 4
#macro FOR_EACH_VIEW for (var _v = 0; _v < VIEW_COUNT; _v++)
#macro FOR_EACH_VISIBLE_VIEW for (var _v = 0; _v < VIEW_COUNT; _v++) if (view_visible[_v])
#macro view_data obj_game.view_data_struct

#macro CAMERA_HORIZONTAL_BUFFER 8
#macro CAMERA_VIEW_TIMER_DEFAULT 120
#macro CAMERA_MAX_VEL_X 16
#macro CAMERA_MAX_VEL_Y 16
#macro CAMERA_FREESPACE_X 16
#macro CAMERA_FREESPACE_Y 32

resize_window_with_hotkey = function(_scale)
{
	global.window_scale = _scale;
	
	if window_get_fullscreen()
	{
		window_disable_fullscreen();
	}
	else
	{
		window_resize();
	}
}

update_view_camera_pos = function(_index)
{
	if _index >= VIEW_COUNT
	{
		return;
	}
	
	var _view_data = view_data[_index];
	var _raw_pos_x = floor(_view_data.raw_x + _view_data.offset_x);
	var _raw_pos_y = floor(_view_data.raw_y + _view_data.offset_y);
	
	var _x = clamp(_raw_pos_x, _view_data.left_bound, _view_data.right_bound - camera_get_width(_index)) + _view_data.shake_offset;
    var _y = clamp(_raw_pos_y, _view_data.top_bound, _view_data.bottom_bound - camera_get_height(_index)) + _view_data.shake_offset;
	
	_view_data.coarse_x = (_x - CULLING_ROUND_VALUE) & -CULLING_ROUND_VALUE;
	_view_data.coarse_y = (_y - CULLING_ROUND_VALUE) & -CULLING_ROUND_VALUE;
	
    camera_set_view_pos(view_camera[_index], _x - CAMERA_HORIZONTAL_BUFFER, _y);
}

var _startup_info = room_get_info(rm_startup);
var _w = _startup_info.width;
var _h = _startup_info.height;

FOR_EACH_VIEW
{
	view_data[_v] =
	{
        index: _v,
        allow_updates: true,
        target: noone,
		max_vel_x: CAMERA_MAX_VEL_X,
		max_vel_y: CAMERA_MAX_VEL_Y,
        vel_x: 0,
        vel_y: 0,
        raw_x: 0,
        raw_y: 0,
        pos_x_prev: 0,
        pos_y_prev: 0,
        delay_x: 0,
        delay_y: 0,
        offset_x: 0,
        offset_y: 0,
		top_bound: 0,
        left_bound: 0,
        right_bound: room_width,
        bottom_bound: room_height,
        shake_offset: 0,
        shake_timer: 0,
        coarse_x: -1,
        coarse_y: -1,
        coarse_x_last: -1,
        coarse_y_last: -1,
        surface_x: 0,
        surface_y: 0,
        surface_w: _w + CAMERA_HORIZONTAL_BUFFER * 2,
        surface_h: _h
    };
	
	camera_destroy(view_camera[_v]);
	
	view_camera[_v] = camera_create_view(-CAMERA_HORIZONTAL_BUFFER, 0, _w + CAMERA_HORIZONTAL_BUFFER * 2, _h);
	view_visible[_v] = false;
}

for (var _i = VIEW_COUNT; _i < 8; _i++)
{
	view_visible[_i] = false;
}

view_visible[0] = true;
view_enabled = true;

surface_resize(application_surface, _w, _h);

#endregion

#region SPRITE ANIMATOR

sprite_array = [];
sprite_update_enabled = false;

#endregion