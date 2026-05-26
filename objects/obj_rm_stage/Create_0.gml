#macro ACT_SINGLE 3
#macro ACT_TRANSITION_BOUND_SPEED 65535

setup_stage = function(_name, _act_index, _bgm, _animals, _next_room, _progress_flag)
{
    zone_name = _name;
    act_index = _act_index;
    bgm_track = _bgm;
    animal_set = _animals;
    next_stage = _next_room;
	progress_flag = _progress_flag;
}

zone_name = "TEMPLATE";
act_index = 0;
progress_flag = 0;
bgm_track = undefined;
next_stage = undefined;
default_physics = global.player_physics;
drp_room_icon = "";
drp_char_icon = "";
animal_set = [];
end_bound = room_width;

FOR_EACH_CAMERA
{
	camera_bound_speed[_c] = 0;
	left_bound[_c] = 0;
	top_bound[_c] = 0;
	right_bound[_c] = room_width;
	bottom_bound[_c] = room_height;
}

// Call Setup Event
event_perform(ev_other, ev_user0);

switch global.player_main
{
	case PLAYER.TAILS:
		drp_char_icon = "player_tails";
	break;
	
	case PLAYER.KNUCKLES: 
		drp_char_icon = "player_knuckles";
	break;
	
	case PLAYER.AMY:
		drp_char_icon = "player_amy";
	break;
	
	// PLAYER.SONIC, others
	default:
		drp_char_icon = "player_sonic";	
}

discord_set_data(zone_name, act_index == ACT_SINGLE ? "Single Act" : "Act " + string(act_index + 1), drp_room_icon, drp_char_icon);

instance_create(0, 0, obj_gui_titlecard);
instance_create(0, 0, obj_gui_hud);
audio_bgm_play(bgm_track);

var _ring_data = global.giant_ring_data;
var _checkpoint_data = global.checkpoint_data;

if array_length(_ring_data) > 0
{
	obj_game.frame_counter = _ring_data[2];
	
    FOR_EACH_CAMERA
    {
        top_bound[_c] = _ring_data[3];
        bottom_bound[_c] = _ring_data[4];
        left_bound[_c] = _ring_data[5];
        right_bound[_c] = _ring_data[6];
    }
}
else if array_length(_checkpoint_data) > 0
{
	obj_game.frame_counter = _checkpoint_data[2];
	
    FOR_EACH_CAMERA
    {
        top_bound[_c] = _checkpoint_data[3];
        bottom_bound[_c] = _checkpoint_data[4];
        left_bound[_c] = _checkpoint_data[5];
        right_bound[_c] = _checkpoint_data[6];
    }
}

FOR_EACH_CAMERA
{
    var _camera_data = view_data[_c];
	
    if _camera_data != undefined
    {
        _camera_data.top_bound = top_bound[_c];
        _camera_data.bottom_bound = bottom_bound[_c];
        _camera_data.left_bound = left_bound[_c];
        _camera_data.right_bound = right_bound[_c];
    }
}