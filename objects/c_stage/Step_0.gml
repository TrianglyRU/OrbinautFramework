var _c_framework = c_framework;
var _do_update = _c_framework.state != STATE_PAUSED;

if water_enabled
{
	// Adjust water level
	if _do_update
	{
		water_level = obj_oscillate_y(water_level_init, _c_framework.frame_counter * ANGLE_INCREMENT, 10, 1, 90);
	}
	
	// Set distortion and palette split boundaries to water level
	_c_framework.distortion.split_bound = water_level;
	_c_framework.palette.split_bound = water_level;
	_c_framework.background.perspective_y_data[0] = water_level;
}

if !_do_update
{
	exit;
}

// Rotate the stage palette
scr_stage_palette();

// Adjust camera bounds to level bounds
for (var i = 0; i < CAMERA_COUNT; i++)
{
	var _camera = camera_get_data(i);
	
	if _camera == noone || !_camera.allow_movement
	{
		continue;
	}
	
	var _view_x = camera_get_x(i);
	var _view_y = camera_get_y(i);
	var _width = camera_get_width(i);
	var _height = camera_get_height(i);
	
	// Level end bounds
	if bound_end != undefined
	{
		var _left_end_bound = bound_end - camera_get_width(i) - 256;
		
		if _view_x >= _left_end_bound + 256
		{
			bound_left[i] = _left_end_bound + 256;
		}
		else if _view_x >= _left_end_bound
		{
			if instance_exists(obj_capsule) && bound_left[i] < _view_x
			{
				bound_left[i] = _view_x;
			}
			else if bound_left[i] < _left_end_bound
			{
				bound_left[i] = _left_end_bound;
			}
		}
		if bound_right[i] > bound_end
		{
			bound_right[i] = bound_end;
		}
	}
	
	if bound_speed[i] < 2
	{
		bound_speed[i] = 2;
	}
	
	var _left_bound = bound_left[i];
	var _right_bound = bound_right[i];
	var _top_bound = bound_top[i];
	var _bottom_bound = bound_bottom[i];
	var _bound_speed = bound_speed[i];
	
	// Left camera bound
	if _camera.min_x < _left_bound
	{
		if _view_x >= _left_bound
		{
			_camera.min_x = _left_bound;
		}
		else
		{
			_camera.min_x = max(_view_x, _camera.min_x);
			_camera.min_x = min(_camera.min_x + _bound_speed, _left_bound);
		}
	}
	else if _camera.min_x > _left_bound
	{
		_camera.min_x = max(_left_bound, _camera.min_x - _bound_speed);
	}
	
	// Right camera bound
	if _camera.max_x < _right_bound
	{
		_camera.max_x = min(_camera.max_x + _bound_speed, _right_bound);
	}
	else if _camera.max_x > _right_bound
	{
		if _view_x + _width <= _right_bound
		{
			_camera.max_x = _right_bound;
		}
		else
		{
			_camera.max_x = min(_camera.max_x, _view_x + _width);
			_camera.max_x = max(_right_bound, _camera.max_x - _bound_speed);
		}
	}
	
	// Top camera bound
	if _camera.min_y < _top_bound
	{
		if _view_y >= _top_bound
		{
			_camera.min_y = _top_bound;
		}
		else
		{
			_camera.min_y = max(_camera.min_y, _view_y);
			_camera.min_y = min(_camera.min_y + _bound_speed, _top_bound);
		}
	}
	else if _camera.min_y > _top_bound
	{
		_camera.min_y = max(_top_bound, _camera.min_y - _bound_speed);
	}
	
	// Bottom camera bound
	if _camera.max_y < _bottom_bound
	{
		_camera.max_y = min(_camera.max_y + _bound_speed, _bottom_bound);
	}
	else if _camera.max_y > _bottom_bound
	{
		if _view_y + _height <= _bottom_bound
		{
			_camera.max_y = _bottom_bound;
		}
		else
		{
			_camera.max_y = min(_view_y + _height, _camera.max_y);
			_camera.max_y = max(_bottom_bound, _camera.max_y - _bound_speed);
		}
	}
}