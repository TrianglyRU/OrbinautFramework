if animator.timer < 0
{
	animator.clear(0);
}

FOR_EACH_PLAYER
{
	var _player = player_get(_p);
	var _touch_side = image_xscale >= 0 ? SOLID_TOUCH.RIGHT : SOLID_TOUCH.LEFT;
	
	solid_object(_player, SOLID_TYPE.FULL);
	
	if image_index != 0 || !_player.is_grounded
	{
		continue;
	}
		
	if solid_touch[_p] != _touch_side
	{
		if sign(_player.vel_x) != sign(image_xscale) && _player.vel_x != 0
		{
			continue;
		}
		
		var _x = floor(_player.x);
		var _y = floor(_player.y);
		var _this_y = floor(y);
		
		if _y < _this_y - 24 || _y >= _this_y + 24
		{
			continue;
		}
		
		var _l_bound = floor(x);
		var _r_bound = _l_bound;
		
		if image_xscale < 0
		{
			_l_bound -= 40;
		}
		else
		{
			_r_bound += 40;
		}
		
		if _x < _l_bound || _x >= _r_bound
		{
			continue;
		}
	}
	
	_player.x -= image_xscale * 8;
	_player.facing = image_xscale;
	_player.vel_x = image_xscale * launch_force;
	_player.spd = _player.vel_x;
	_player.ground_lock_timer = 16;
	_player.action = ACTION.NONE;
	
	animator.start(sprite_index, 1, 9, 1);
	
	audio_sfx_play(snd_spring);
	input_set_rumble(_p, 0.20, INPUT_RUMBLE_LIGHT);
}