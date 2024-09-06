// Update player position and camera
with obj_player
{
	x = other.x;
	y = other.y - radius_y - 1;

	c_stage.bound_bottom[player_index] = room_height;

	var _camera = camera_get_data(player_index);
	
	if _camera == noone
	{
		continue;
	}

	_camera.max_y = room_height;
	
	var _x = x - camera_get_width(player_index) / 2;
	var _y = y - camera_get_height(player_index) / 2 + 16;

	camera_update(player_index, undefined, undefined, _x, _y);
}

// Destroy the instance
instance_destroy();