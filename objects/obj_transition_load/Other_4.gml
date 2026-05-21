var _transition_data = global.stage_transition_data;

if _transition_data == undefined
{
	return;
}

var _x = x;
var _y = y;
var _player_data = _transition_data.player_data;

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
	
	var _camera_index = camera_data.index;
	
	if _camera_index == player_index
	{
		camera_data.raw_x = _x - _data.camera_offset_x;
		camera_data.raw_y = _y - _data.camera_offset_y;
		
		// Match the bounds to the camera's own size so the players can't leave the screen
		camera_data.left_bound = camera_data.raw_x;
		camera_data.top_bound = camera_data.raw_y;
		camera_data.right_bound = camera_data.left_bound + camera_get_width(_camera_index);
		camera_data.bottom_bound = camera_data.top_bound + camera_get_height(_camera_index);
		
		// Reset the maximum x-velocity so it smoothly accelerates back to its regular value later
		camera_data.max_vel_x = 0;
	}
}

// Lock the movement and adjust to the stage boundaries instantly as soon as being unlocked
FOR_EACH_CAMERA
{	
	camera_toggle_movement(_c, false); obj_rm_stage.camera_bound_speed[_c] = 65536;
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