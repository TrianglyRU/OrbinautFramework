FOR_EACH_PLAYER
{
	var _player = player_get(_p);
	var _speed = abs(_player.spd);
	var _on_object = _player.on_object;
	
	if _on_object != id
	{
		if !_player.is_grounded || _player.action == ACTION.DASH || _speed < 6
		{
			continue;
		}
		
		if _player.state >= PLAYER_STATE.NO_INTERACT
		{
			continue;
		}
		
		var _bound_outer, _bound_inner;
		
		if _on_object != noone && _on_object.object_index == obj_spiral_path
		{
			_bound_outer = 192;
			_bound_inner = 176;
		}
		else
		{
			_bound_outer = 208;
			_bound_inner = 192;	
		}
		
		var _dist_x = floor(_player.x) - x;
		var _dist_y = floor(_player.y) - y - 16;
		
		if abs(_dist_y) >= 48
		{
			continue;
		}
		
		if _player.vel_x < 0
		{
			if _dist_x < _bound_inner || _dist_x > _bound_outer
			{
				continue;
			}
		}
		else if _dist_x < -_bound_outer || _dist_x > -_bound_inner
		{
			continue;
		}
		
		// Not in the original Sonic 2, but is required in some scenarios
		_player.facing = sign(_player.vel_x);
		
		_player.spd = _player.vel_x;
		_player.vel_y = 0;
		_player.angle = 0;
		_player.on_object = id;
		_player.action = ACTION.NONE;
		
		if _player.animation != ANIM.SPIN
		{
			_player.animation = ANIM.FLIP;
		}
	}
	else
	{
		// Note: player's is_grounded flag IS set while running on the path due to on_object flag
		// preventing the collision script to check if there's ground below the player or not
	
		var _total_width = 416;
		var _dist_x = floor(_player.x) - x + _total_width * 0.5;
		
		if _dist_x < 0 || abs(_dist_x) >= _total_width || !_player.is_grounded || _speed < 6
		{
			if _speed >= 6 && _player.animation == ANIM.FLIP
			{
				_player.animation = ANIM.MOVE;
			}
			
			_player.on_object = noone;
		}
		else
		{
			// Override player's animation frame
			if _player.animation == ANIM.FLIP
			{
				var _frame_index = floor(_dist_x / 32);
				
				if _player.facing == -1
				{
					_frame_index = array_length(flip_frame_table) - 1 - _frame_index;
				}
				
				_player.animator.timer = _player.animator.duration;
				_player.image_index = flip_frame_table[_frame_index];
			}
			
			_player.y = y + offset_table[_dist_x] + _player.radius_y_normal - _player.radius_y;
		}
	}
}