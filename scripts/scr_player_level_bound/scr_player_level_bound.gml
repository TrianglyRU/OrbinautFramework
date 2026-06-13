/// @self obj_player
function scr_player_level_bound()
{
	var _left_bound = floor(view_data_ref.left_bound);
	var _right_bound = floor(view_data_ref.right_bound);
	var _top_bound = floor(view_data_ref.top_bound);
	var _bottom_bound = floor(view_data_ref.bottom_bound);
	
	// Most of the checks here use not floored but real positions including
	// subpixels (_i.e., LONG instead of WORD)
	
	if x >= _left_bound && x + vel_x < _left_bound + 16
	{
		spd = 0;
		vel_x = 0;
		x = _left_bound + 16;
	}
	
	if instance_exists(obj_sign_post) && !instance_exists(obj_transition_save)
	{
		_right_bound += 64;
	}
	
	if x < _right_bound && x + vel_x > _right_bound - 24
	{
		spd = 0;
		vel_x = 0;
		x = _right_bound - 24;
	}
	
	if action == ACTION.FLIGHT || action == ACTION.CLIMB
	{
		if y >= _top_bound && y + vel_y < _top_bound + 16
		{
			if action == ACTION.FLIGHT
			{
				grv = PARAM_GRV_TAILS_DOWN;
			}
			
			vel_y = 0;
			y = _top_bound + 16;
		}
	}
	else if action == ACTION.GLIDE && y < _top_bound + 10
	{
		// Reset glide speed
		spd = 0;
	}
	
	if instance_exists(obj_rm_stage)
	{
		if air_timer > 0 && floor(y) >= max(_bottom_bound, floor(obj_rm_stage.bottom_bound[view_data_ref.index]))
		{
			kill();
		}
	}
}