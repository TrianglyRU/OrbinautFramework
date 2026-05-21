if animator.timer < 0
{
	animator.clear(0);
}

FOR_EACH_PLAYER
{
	var _player = player_get(_p);
	var _prev_anim = _player.animation;
	var _touch_side = image_yscale >= 0 ? SOLID_TOUCH.TOP : SOLID_TOUCH.BOTTOM;
	
	solid_object(_player, SOLID_TYPE.FULL_CLEAR_PLAYER);
	
    if image_index != 0 || solid_touch[_p] != _touch_side
    {
        continue;
    }
	
	if image_yscale >= 0
	{
		if _prev_anim == iv_bounce_animation || _prev_anim == ANIM.FLIP_EXTENDED
		{
			_player.animator.restart();
		}
		
		if iv_bounce_animation == ANIM.FLIP
		{
			_player.animation = launch_force > 10 ? ANIM.FLIP_EXTENDED : ANIM.FLIP;
		}
		else
		{
			_player.animation = iv_bounce_animation;
		}
	}
	else
	{
		_player.vel_x = 0;
	}
	
	_player.y += image_yscale * 8;
	_player.vel_y = image_yscale * -launch_force;
	_player.reset_substate();
	
	animator.start(sprite_index, 1, 9, 1);
	
    audio_sfx_play(snd_spring);
	input_set_rumble(_p, 0.20, INPUT_RUMBLE_LIGHT);
}