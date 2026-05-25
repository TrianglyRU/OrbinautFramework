if obj_game.state >= GAME_STATE.STOP_SYSTEM
{
    return;
}

FOR_EACH_CAMERA
{
	var _camera_data = view_data[_c];
	
	if _camera_data == undefined || !_camera_data.allow_movement
	{
		continue;
	}
	
	var _view_x = camera_get_x(_c);
	var _view_y = camera_get_y(_c);
	var _w = camera_get_width(_c);
	var _h = camera_get_height(_c);
	
	// Level end bounds
	if end_bound != undefined
	{
		var _left_end_bound = end_bound - camera_get_width(_c) - 256;
		
		if _view_x >= _left_end_bound + 256
		{
			left_bound[_c] = _left_end_bound + 256;
		}
		else if _view_x >= _left_end_bound
		{
			if instance_exists(obj_capsule) && left_bound[_c] < _view_x
			{
				left_bound[_c] = _view_x;
			}
			else if left_bound[_c] < _left_end_bound
			{
				left_bound[_c] = _left_end_bound;
			}
		}
		
		if right_bound[_c] > end_bound
		{
			right_bound[_c] = end_bound;
		}
	}
	
	if camera_bound_speed[_c] < 2
	{
		camera_bound_speed[_c] = 2;
	}
	
	var _left_bound = left_bound[_c];
	var _right_bound = right_bound[_c];
	var _top_bound = top_bound[_c];
	var _bottom_bound = bottom_bound[_c];
	var _bound_speed = camera_bound_speed[_c];
	
	// Left camera bound
	if _camera_data.left_bound < _left_bound
	{
		if _view_x >= _left_bound
		{
			_camera_data.left_bound = _left_bound;
		}
		else
		{
			_camera_data.left_bound = max(_view_x, _camera_data.left_bound);
			_camera_data.left_bound = min(_camera_data.left_bound + _bound_speed, _left_bound);
		}
	}
	else if _camera_data.left_bound > _left_bound
	{
		_camera_data.left_bound = max(_left_bound, _camera_data.left_bound - _bound_speed);
	}
	
	// Right camera bound
	if _camera_data.right_bound < _right_bound
	{
		_camera_data.right_bound = min(_camera_data.right_bound + _bound_speed, _right_bound);
	}
	else if _camera_data.right_bound > _right_bound
	{
		if _view_x + _w <= _right_bound
		{
			_camera_data.right_bound = _right_bound;
		}
		else
		{
			_camera_data.right_bound = min(_camera_data.right_bound, _view_x + _w);
			_camera_data.right_bound = max(_right_bound, _camera_data.right_bound - _bound_speed);
		}
	}
	
	// Top camera bound
	if _camera_data.top_bound < _top_bound
	{
		if _view_y >= _top_bound
		{
			_camera_data.top_bound = _top_bound;
		}
		else
		{
			_camera_data.top_bound = max(_camera_data.top_bound, _view_y);
			_camera_data.top_bound = min(_camera_data.top_bound + _bound_speed, _top_bound);
		}
	}
	else if _camera_data.top_bound > _top_bound
	{
		_camera_data.top_bound = max(_top_bound, _camera_data.top_bound - _bound_speed);
	}
	
	// Bottom camera bound
	if _camera_data.bottom_bound < _bottom_bound
	{
		_camera_data.bottom_bound = min(_camera_data.bottom_bound + _bound_speed, _bottom_bound);
	}
	else if _camera_data.bottom_bound > _bottom_bound
	{
		if _view_y + _h <= _bottom_bound
		{
			_camera_data.bottom_bound = _bottom_bound;
		}
		else
		{
			_camera_data.bottom_bound = min(_view_y + _h, _camera_data.bottom_bound);
			_camera_data.bottom_bound = max(_bottom_bound, _camera_data.bottom_bound - _bound_speed);
		}
	}
}