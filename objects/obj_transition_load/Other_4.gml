var _transition_data = global.stage_transition_data;

if _transition_data == undefined
{
	return;
}

var _x = x;
var _y = y;
var _player_data = _transition_data.player_data;

// Disable camera updates
FOR_EACH_VIEW
{
	view_data[_v].allow_updates = false;
}

with obj_player
{
	var _data = _player_data[player_index];
	
	if _data == undefined
	{
		continue;
	}
	
	x = _x - _data.offset_x;
	y = _y - _data.offset_y;
	facing = _data.facing;
	
	// Restore shield
	global.player_shields[player_index] = _data.shield;
	
	if _data.shield != SHIELD.NONE
	{
		instance_create(x, y, obj_shield, { player: id });
	}
	
	// Re-fill up initial record data
	for (var _i = 0; _i < recorded_data_length; _i++)
	{
		record_data(_i);
	}
	
	var _camera_index = view_data_ref.index;
	
	if _camera_index == player_index
	{
		view_data_ref.raw_x = _x - _data.camera_offset_x;
		view_data_ref.raw_y = _y - _data.camera_offset_y;
		
		// Match the bounds to the camera size so players can't leave the screen
		view_data_ref.left_bound = view_data_ref.raw_x;
		view_data_ref.top_bound = view_data_ref.raw_y;
		view_data_ref.right_bound = view_data_ref.left_bound + camera_get_width(_camera_index);
		view_data_ref.bottom_bound = view_data_ref.top_bound + camera_get_height(_camera_index);
		
		// Reset the maximum x-velocity so it smoothly accelerates back to its regular value later
		view_data_ref.max_vel_x = 0;
	}
}

if _transition_data.background_transition
{
	obj_game.bg_distance_x = _transition_data.background_distance_x - x;
	obj_game.bg_distance_y = _transition_data.background_distance_y - y;
	obj_game.bg_scroll_x = _transition_data.background_scroll_x;
	obj_game.bg_scroll_y = _transition_data.background_scroll_y;
}

obj_game.deformation_timer = _transition_data.deformation_timer;

x += _transition_data.marker_offset_x;
y += _transition_data.marker_offset_y;
sprite_index = _transition_data.marker_sprite;
depth = _transition_data.marker_depth;

if sprite_index != spr_object
{
	visible = true;
}

delete global.stage_transition_data;
	   global.stage_transition_data = undefined;