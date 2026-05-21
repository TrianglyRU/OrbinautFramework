FOR_EACH_PLAYER
{
	var _player = player_get(_p);
	var _vel_x = _player.vel_x;
	
	solid_object(_player, SOLID_TYPE.SIDES);
	
	if iv_knuckles_only && _player.player_type != PLAYER.KNUCKLES
	{
		continue;
	}
	
	var _shield = global.player_shields[_p];
	var _side = _vel_x >= 0 ? SOLID_TOUCH.LEFT : SOLID_TOUCH.RIGHT;
	
	if _side != solid_touch[_p]
	{
		continue;
	}
	
	// Conditions upon which players can destroy the wall
	if not (_player.animation == ANIM.SPIN && _player.is_grounded && abs(_vel_x) >= 4 || 
		   _player.player_type == PLAYER.KNUCKLES || 
		   _player.action == ACTION.HAMMER_SPIN || 
		   _player.animation == ANIM.HAMMER_DASH || 
		   _player.super_timer > 0 || 
		   _player.shield_state == SHIELD_STATE.ACTIVE && _shield == SHIELD.FIRE)
	{
		continue;
	}
	
	if _player.action == ACTION.GLIDE && _player.action_state == GLIDE_STATE.AIR
	{
		_player.release_glide(0);
	}
	
	_player.x -= 4 * sign(_vel_x);
	_player.vel_x = _vel_x;
	_player.spd = _vel_x;
	_player.set_push_anim_by = noone;
	
	var _smash_dir = floor(_player.x) >= floor(x) ? 1 : -1;
	
	for (var _i = 0; _i < 2; _i ++)
	{
		for (var _j = 0; _j < 4; _j++)
		{
			var _vx = 6 * _smash_dir;
			var _vy = -6 + 4 * _j;
			
			if _smash_dir == -1 && _i == 1 || _smash_dir == 1 && _i == 0
			{
				_vx -= 2 * sign(_vx);
				_vy -= 1 * sign(_vy);
			}
			
			instance_create_piece(x - 8 + 16 * _i, y - 24 + 16 * _j, sprite_index, image_index, 16 * _i, 16 * _j, 16, 16, _vx, _vy, 0, false, false, false);
		}
	}
	
	audio_sfx_play(snd_break_block);
	input_set_rumble(_p, 0.35, INPUT_RUMBLE_STRONG);
	instance_destroy();
	
	break;
}