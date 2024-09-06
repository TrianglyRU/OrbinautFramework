if !is_reflected
{
	for (var p = 0; p < PLAYER_COUNT; p++)
	{
		var _player = player_get(p);
	
		if !obj_check_hitbox(_player)
		{
			continue;
		}
		
		// Hurt the player or be reflected
		if _player.shield <= SHIELD_NORMAL && _player.shield_state != SHIELD_STATE_DOUBLESPIN
		{
			_player.m_player_hurt();
		}
		else
		{
			var _arctan = darctan2(_player.y - y, _player.x - x);
			var _angle = math_get_angle_rounded(_arctan);
			
			is_reflected = true;
			VelocityX = -8 * dcos(_angle);
			VelocityY = -8 * dsin(_angle);
			Gravity = 0;
			
			break;
		}
	}
}

// Move
x += VelocityX;
y += VelocityY;
VelocityY += Gravity;