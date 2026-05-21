/// @self obj_player
function scr_player_camera()
{
	if camera_data.target != noone || player_index != camera_data.index
	{
		return;
	}
	
	var _border_x = !global.cd_camera * CAMERA_FREESPACE_X;
	var _border_y = CAMERA_FREESPACE_Y;
	
	var _w = camera_get_width(camera_data.index);
	var _h = camera_get_height(camera_data.index);
	var _target_x = floor(x) - camera_data.raw_x - _w * 0.5;
	var _target_y = floor(y) - camera_data.raw_y - _h * 0.5 + 16;
	var _max_vel_x = camera_data.max_vel_x;
	var _max_vel_y = camera_data.max_vel_y;
	
	if _target_x > 0
	{
		camera_data.vel_x = min(_target_x, _max_vel_x);
	}
	else if _target_x < -_border_x
	{ 
		camera_data.vel_x = max(_target_x + _border_x, -_max_vel_x);  
	}
	else
	{
		camera_data.vel_x = 0;
	}
	
	if is_grounded
	{
		if animation == ANIM.SPIN
		{
			_target_y -= radius_y_normal - radius_y;
		}
		
		var _limit = abs(spd) < 8 ? 6 : 16;
		
		camera_data.vel_y = clamp(_target_y, -_limit, _limit);
	}
	else if (_target_y > _border_y)
	{
		camera_data.vel_y = min(_target_y - _border_y, _max_vel_y);  
	}
	else if (_target_y < -_border_y)
	{ 
		camera_data.vel_y = max(_target_y + _border_y, -_max_vel_y);  
	} 
	else
	{
		camera_data.vel_y = 0;
	}
	
	if global.cd_camera
	{
		var _x_shift_dist = 64;
		var _x_shift_spd = 2;
		var _x_shift_dir = spd != 0 ? sign(spd) : facing;
		
		if abs(spd) >= 6 || action == ACTION.SPIN_DASH
		{
			if camera_data.delay_x == 0 && camera_data.offset_x != _x_shift_dist * _x_shift_dir
			{
				camera_data.offset_x += _x_shift_spd * _x_shift_dir;
			}
		}
		else if camera_data.offset_x != 0
		{
			camera_data.offset_x -= _x_shift_spd * sign(camera_data.offset_x);
		}
	}
	
	var _do_shift_down = animation == ANIM.DUCK;
	var _do_shift_up = animation == ANIM.LOOKUP;

	if _do_shift_down || _do_shift_up
	{
		if camera_view_timer > 0 && state == PLAYER_STATE.DEFAULT
		{
			camera_view_timer--;
		}
	}
	else if global.spin_dash || global.dash
	{
		camera_view_timer = CAMERA_VIEW_TIMER_DEFAULT;
	}

	if camera_view_timer > 0
	{
		if camera_data.offset_y != 0
		{
			camera_data.offset_y -= 2 * sign(camera_data.offset_y);
		}
	}
	else if _do_shift_down && camera_data.offset_y < 88
	{
		camera_data.offset_y += 2;
	}
	else if _do_shift_up && camera_data.offset_y > -104
	{
		camera_data.offset_y -= 2;
	}
}