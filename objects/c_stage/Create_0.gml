#macro ACT_SINGLE 3

/// @method m_stage_set
m_stage_set = function(_stage_index, _name, _act_id, _bgm, _animals, _bottom_bound, _water_pos, _next_room, _do_save)
{
    global.stage_index = _stage_index;
    zone_name = _name;
    act_id = _act_id;
    bgm_track = _bgm;
    animal_set = _animals;
    water_enabled = _water_pos >= 0;
    water_level_init = _water_pos;
    water_level = _water_pos;
    next_stage = _next_room;
    save_progress = _do_save;
    bound_bottom_init = _bottom_bound;
}

// Initialise default values
zone_name = "TEMPLATE";
act_id = 0;
bgm_track = -1;
animal_set = [];
water_enabled = -1;
water_level_init = 0;
water_level = 0;
next_stage = -1;
save_progress = false;
bound_top = array_create(CAMERA_COUNT, 0);
bound_bottom = array_create(CAMERA_COUNT, room_height);
bound_left = array_create(CAMERA_COUNT, 0);
bound_right = array_create(CAMERA_COUNT, room_width);
bound_speed = array_create(CAMERA_COUNT, 0);
bound_bottom_init = room_height;
bound_end = room_width;

// Set up the stage
scr_stage_setup();

if water_enabled
{
    instance_create_depth(0, 0, RENDERER_DEPTH_HIGHEST, obj_water_surface);
}

instance_create_depth(0, 0, RENDERER_DEPTH_HUD, obj_gui_titlecard);
instance_create_depth(0, 0, RENDERER_DEPTH_HUD, obj_gui_hud);

audio_play_bgm(bgm_track);

// Set Discord data based on player and stage
var _player_icon = "";

switch global.player_main
{
    case PLAYER_SONIC:
        _player_icon = "drp_sonic"; 
    break;
    case PLAYER_TAILS: 
        _player_icon = "drp_tails";
    break;
    case PLAYER_KNUCKLES:
        _player_icon = "drp_knuckles";
    break;
    case PLAYER_AMY:
        _player_icon = "drp_amy"; 
    break;
}

var _stage_icon = "";

switch room
{
    case rm_stage_tsz0: _stage_icon = "drp_tech_stadium"; break;
}

discord_set_data($"{zone_name}", act_id == ACT_SINGLE ? "Single Act" : $"Act {act_id + 1}", _stage_icon, _player_icon);

// Set bounds for cameras based on saved data or defaults
var _ring_data = global.giant_ring_data;
var _checkpoint_data = global.checkpoint_data;

if array_length(_ring_data) > 0
{
    c_framework.frame_counter = _ring_data[2];
	
    for (var i = 0; i < CAMERA_COUNT; i++)
    {
        bound_top[i] = _ring_data[3];
        bound_bottom[i] = _ring_data[4];
        bound_left[i] = _ring_data[5];
        bound_right[i] = _ring_data[6];
    }
	
    global.giant_ring_data = [];
}
else if array_length(_checkpoint_data) > 0
{
    c_framework.frame_counter = _checkpoint_data[2];
	
    for (var i = 0; i < CAMERA_COUNT; i++)
    {
        bound_top[i] = _checkpoint_data[3];
        bound_bottom[i] = _checkpoint_data[4];
        bound_left[i] = _checkpoint_data[5];
        bound_right[i] = _checkpoint_data[6];
    }
}
else if bound_bottom_init > 0
{
    for (var i = 0; i < CAMERA_COUNT; i++)
    {
        bound_bottom[i] = bound_bottom_init;
    }
}

// Apply camera bounds
for (var i = 0; i < CAMERA_COUNT; i++)
{
    var _camera = camera_get_data(i);
	
    if _camera != noone
    {
        _camera.min_y = bound_top[i];
        _camera.max_y = bound_bottom[i];
        _camera.min_x = bound_left[i];
        _camera.max_x = bound_right[i];
    }
}