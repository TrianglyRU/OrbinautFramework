if animator.timer < 0
{
	animator.clear(0);
}

FOR_EACH_PLAYER
{
    var _player = player_get(_p);
	
    if !collision_player(_player)
    {
        continue;
    }
	
	audio_sfx_play(snd_bumper);
    
	if _player.action == ACTION.CARRIED
	{
	    _player.action = ACTION.NONE;
	}
	
	var _angle = math_get_vector_rounded(_player.x - x, _player.y - y);
	
	_player.is_jumping = false;
	_player.is_grounded = false;
	_player.air_lock_flag = false;
	_player.set_push_anim_by = noone;
	_player.vel_x = BUMPER_FORCE * dsin(_angle);
	_player.vel_y = BUMPER_FORCE * dcos(_angle);
	
	if animator.timer == 0
	{
		animator.start(sprite_index, 1, 3, 4);
	}
}