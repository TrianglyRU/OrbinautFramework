/// @function scr_player_level_bound
function scr_player_level_bound()
{
	gml_pragma("forceinline");
	
	var _left_bound = camera_data.min_x + 16;
	var _right_bound = camera_data.max_x - 24;
	var _top_bound = camera_data.min_y + 16;
	var _bottom_bound = camera_data.max_y;
	
	// The checks here use real positions including subpixels, not floored
	// (i.e., long instead of word)

	// Check and handle left boundary
	if x + vel_x < _left_bound
	{
		spd_ground = 0;
		vel_x = 0;
		x = _left_bound;
	}
	
	// Check and handle right boundary
	if instance_exists(obj_signpost)
	{
		_right_bound += 64;
	}
	
	if x + vel_x > _right_bound
	{
		spd_ground = 0;
		vel_x = 0;
		x = _right_bound;
	}

	// Handle vertical boundaries based on action
	if action == ACTION_FLIGHT || action == ACTION_CLIMB
	{
		if y + vel_y < _top_bound
		{ 	
			if action == ACTION_FLIGHT
			{
				grv = PARAM_GRV_TAILS_DOWN;
			}
			vel_y = 0;
			y = _top_bound;
		}
	}
	else if action == ACTION_GLIDE && y < _top_bound - 6
	{
		glide_value = 0;
	}
	
	// Check if player falls below the bottom boundary
	if instance_exists(c_stage)
	{
		if air_timer > 0 && floor(y) >= max(_bottom_bound, c_stage.bound_bottom[camera_data.index])
		{
			m_player_kill();
		}
	}
}