FOR_EACH_PLAYER
{
	var _player = player_get(_p);
	var _is_spinning = _player.animation == ANIM.SPIN;
	
	solid_object(_player, _is_spinning ? SOLID_TYPE.FULL_NO_LAND : SOLID_TYPE.FULL);
	
	if !_is_spinning || solid_touch[_p] != SOLID_TOUCH.TOP
	{
		continue;
	}
	
	_player.is_grounded = false;
	_player.vel_y = -3;
	_player.add_score(++_player.score_combo);
	
	with instance_create(x, y, obj_score)
	{
		combo = _player.score_combo;
	}
	
	for (var _i = 0; _i < 2; _i++)
	{
		for (var _j = 0; _j < 2; _j++)
		{
			var _vel_x = -2;
			var _vel_y = -2;

			if _i > 0
			{
				_vel_x *= -1;
			}

			if _j > 0
			{
				_vel_y = _vel_y * 0.5;
				_vel_x = _vel_x * 0.5;
			}
			
			instance_create_piece(x - 8 + _i * 16, y - 8 + _j * 16, sprite_index, image_index, 16 * _i, 16 * _j, 16, 16, _vel_x, _vel_y, 0, false, false, false);
		}
	}
	
	with obj_player
	{
		if release_from_solid(other.id)
		{
			input_set_rumble(_p, 0.35, INPUT_RUMBLE_STRONG);
		}
	}
	
	audio_sfx_play(snd_break_block);
	input_set_rumble(_p, 0.35, INPUT_RUMBLE_STRONG);
	instance_destroy();
	
	break;
}