if obj_game.state == GAME_STATE.STOP_ALL
{
    return;
}

FOR_EACH_VISIBLE_VIEW
{
	var _view_data = view_data[_v];
	
	if !_view_data.allow_updates
	{
		continue;
	}
	
	var _view_x = camera_get_x(_v);
	var _view_y = camera_get_y(_v);
	var _w = camera_get_width(_v);
	var _h = camera_get_height(_v);
	
	// Level end bounds
	if end_bound != undefined
	{
		var _left_end_bound = end_bound - camera_get_width(_v) - 256;
		
		if _view_x >= _left_end_bound + 256
		{
			left_bound[_v] = _left_end_bound + 256;
		}
		else if _view_x >= _left_end_bound
		{
			if instance_exists(obj_capsule) && left_bound[_v] < _view_x
			{
				left_bound[_v] = _view_x;
			}
			else if left_bound[_v] < _left_end_bound
			{
				left_bound[_v] = _left_end_bound;
			}
		}
		
		if right_bound[_v] > end_bound
		{
			right_bound[_v] = end_bound;
		}
	}
	
	var _left_bound = left_bound[_v];
	var _right_bound = right_bound[_v];
	var _top_bound = top_bound[_v];
	var _bottom_bound = bottom_bound[_v];
	var _bound_speed = camera_bound_speed[_v];
	
	if camera_bound_speed[_v] >= ACT_TRANSITION_BOUND_SPEED
	{
		_view_data.left_bound = _left_bound;
		_view_data.right_bound = _right_bound;
		_view_data.top_bound = _top_bound;
		_view_data.bottom_bound = _bottom_bound;
		camera_bound_speed[_v] = 2;
		
		continue;
	}

	if camera_bound_speed[_v] < 2
	{
		camera_bound_speed[_v] = 2;
	}

	// Left camera bound
	if _view_data.left_bound < _left_bound
	{
		if _view_x >= _left_bound
		{
			_view_data.left_bound = _left_bound;
		}
		else
		{
			_view_data.left_bound = max(_view_x, _view_data.left_bound);
			_view_data.left_bound = min(_view_data.left_bound + _bound_speed, _left_bound);
		}
	}
	else if _view_data.left_bound > _left_bound
	{
		_view_data.left_bound = max(_left_bound, _view_data.left_bound - _bound_speed);
	}
	
	// Right camera bound
	if _view_data.right_bound < _right_bound
	{
		_view_data.right_bound = min(_view_data.right_bound + _bound_speed, _right_bound);
	}
	else if _view_data.right_bound > _right_bound
	{
		if _view_x + _w <= _right_bound
		{
			_view_data.right_bound = _right_bound;
		}
		else
		{
			_view_data.right_bound = min(_view_data.right_bound, _view_x + _w);
			_view_data.right_bound = max(_right_bound, _view_data.right_bound - _bound_speed);
		}
	}
	
	// Top camera bound
	if _view_data.top_bound < _top_bound
	{
		if _view_y >= _top_bound
		{
			_view_data.top_bound = _top_bound;
		}
		else
		{
			_view_data.top_bound = max(_view_data.top_bound, _view_y);
			_view_data.top_bound = min(_view_data.top_bound + _bound_speed, _top_bound);
		}
	}
	else if _view_data.top_bound > _top_bound
	{
		_view_data.top_bound = max(_top_bound, _view_data.top_bound - _bound_speed);
	}
	
	// Bottom camera bound
	if _view_data.bottom_bound < _bottom_bound
	{
		_view_data.bottom_bound = min(_view_data.bottom_bound + _bound_speed, _bottom_bound);
	}
	else if _view_data.bottom_bound > _bottom_bound
	{
		if _view_y + _h <= _bottom_bound
		{
			_view_data.bottom_bound = _bottom_bound;
		}
		else
		{
			_view_data.bottom_bound = min(_view_y + _h, _view_data.bottom_bound);
			_view_data.bottom_bound = max(_bottom_bound, _view_data.bottom_bound - _bound_speed);
		}
	}
}