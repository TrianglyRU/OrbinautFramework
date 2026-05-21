if !is_reflected
{
	FOR_EACH_PLAYER
	{
		var _player = player_get(_p);
		
		if !collision_player(_player)
		{
			continue;
		}
		
		if global.player_shields[_p] > SHIELD.NORMAL || _player.shield_state == SHIELD_STATE.DOUBLE_SPIN
		{
			var _arctan = darctan2(_player.y - y, _player.x - x);
			var _angle = math_get_angle_rounded(_arctan);
			
			is_reflected = true;
			vel_x = -8 * dcos(_angle);
			vel_y = -8 * dsin(_angle);
			grv = 0;
			
			break;
		}
		else
		{
			_player.hurt(id);
		}
	}
}

x += vel_x;
y += vel_y;
vel_y += grv;