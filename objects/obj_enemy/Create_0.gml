// Inherit the parent event
event_inherited();

enum REACT_TYPE
{
	BADNIK,
	BOSS
}

react_to_players = function(_react_type)
{
	FOR_EACH_PLAYER
	{
		var _player = player_get(_p);

		if !collision_player(_player, true)
		{
			continue;
		}
		
        var _can_damage = false;
        
        if _player.animation == ANIM.HAMMER_DASH || _player.animation == ANIM.SPIN
        {
            _can_damage = true;
        }
		else if _player.is_true_glide() || _player.action == ACTION.SPIN_DASH
		{
			_can_damage = true;
		}
		else if _player.action == ACTION.FLIGHT
		{
			var _vector = math_get_vector_rounded(_player.x - x, _player.y - y);
		
			if math_get_quadrant(_vector) == QUADRANT.DOWN
			{
				_can_damage = true;
			}
		}
		else if _player.super_timer > 0 || _player.item_inv_timer > 0
		{
			_can_damage = true; 
		}
		
		if !_can_damage
		{
            _player.hurt(id); continue;
        }
        
        if !_player.is_grounded
        {
            if _react_type == REACT_TYPE.BOSS
            {
                _player.vel_x *= -0.5;
                _player.vel_y *= -0.5;
            }
            else if floor(_player.y) >= floor(y) || _player.vel_y < 0
            {
                _player.vel_y -= _player.vel_y < 0 ? -1 : 1;
            }
            else if _player.vel_y > 0
            {
                _player.vel_y *= -1;
            }
        }
        
        input_set_rumble(_p, 0.05, INPUT_RUMBLE_MEDIUM);
        
        return _player;
	}
	
	return noone;
}

replace_with_animal_by = function(_player)
{
	_player.add_score(++_player.score_combo);
	
	with instance_create(x, y, obj_score)
	{
		combo = _player.score_combo;
	}
	
	instance_create(x, y, obj_animal);
	instance_create(x, y, obj_explosion_dust);
	audio_sfx_play(snd_destroy);
	instance_destroy();
}