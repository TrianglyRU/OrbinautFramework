/// @function scr_player_camera
function scr_player_camera()
{
	gml_pragma("forceinline");
	
	var _camera_data = camera_data;

	if _camera_data.target != noone || player_index != camera_data.index
	{
		exit;
	}

	// Calculate camera movement based on target position
	var _border_x = !global.cd_camera * 16;
	var _border_y = 32;
	var _width = camera_get_width(_camera_data.index);
	var _height = camera_get_height(_camera_data.index);
	var _target = id;
	var _target_x = _target.x - _camera_data.pos_x - _width / 2;
	var _target_y = _target.y - _camera_data.pos_y - _height / 2 + 16;
	
	// Horizontal movement
	if _target_x > 0
	{
		_camera_data.vel_x = min(_target_x, _camera_data.vel_x_max);
	}
	else if _target_x < -_border_x
	{ 
		_camera_data.vel_x = max(_target_x + _border_x, -_camera_data.vel_x_max);  
	}
	else
	{
		_camera_data.vel_x = 0;
	}
	
	// Vertical movement
	if _target.is_grounded
	{
		if _target.animation == ANI_SPIN
		{
			_target_y -= (_target.radius_y_normal - _target.radius_y);
		}
		
		var _limit = abs(_target.spd_ground) < 8 ? 6 : _camera_data.vel_y_max;
		
		_camera_data.vel_y = clamp(_target_y, -_limit, _limit);
	}
	else if _target_y > _border_y
	{
		_camera_data.vel_y = min(_target_y - _border_y, _camera_data.vel_y_max);  
	}
	else if _target_y < -_border_y
	{ 
		_camera_data.vel_y = max(_target_y + _border_y, -_camera_data.vel_y_max);  
	} 
	else
	{
		_camera_data.vel_y = 0;
	}

	// Handle camera offset adjustments for camera shake
	if global.cd_camera
	{
		var _x_shift_dist = 64;
		var _x_shift_spd = 2;
		var _x_shift_dir = spd_ground != 0 ? sign(spd_ground) : facing;
		
		if abs(spd_ground) >= 6 || action == ACTION_SPINDASH
		{
			if _camera_data.delay_x == 0 && _camera_data.offset_x != _x_shift_dist * _x_shift_dir
			{
				_camera_data.offset_x += _x_shift_spd * _x_shift_dir;
			}
		}
		else
		{
			_camera_data.offset_x -= _x_shift_spd * sign(_camera_data.offset_x);
		}
	}

	// Manage vertical camera shift based on animation state
	var _do_shift_down = animation == ANI_DUCK;
	var _do_shift_up = animation == ANI_LOOKUP;

	if _do_shift_down || _do_shift_up
	{
		if camera_view_timer > 0
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
		if _camera_data.offset_y != 0
		{
			_camera_data.offset_y -= 2 * sign(_camera_data.offset_y);
		}
		
		exit;
	}

	if _do_shift_down && _camera_data.offset_y < 88 	
	{
		_camera_data.offset_y += 2;
	}
	else if _do_shift_up && _camera_data.offset_y > -104 
	{
		_camera_data.offset_y -= 2;
	}
}