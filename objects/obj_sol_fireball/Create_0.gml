/// @method m_sol_fireball_hurt
m_sol_fireball_hurt = function()
{
	// This method is also called by Sol itself when the fireball is attached to it
	for (var p = 0; p < PLAYER_COUNT; p++)
	{
		var _player = player_get(p);
		
		if _player.shield != SHIELD_FIRE && obj_check_hitbox(_player)
		{
			_player.m_player_hurt();
		}
	}
}

// Inherit the parent event
event_inherited();

vel_x = 0;
flip_timer = 0;
	
obj_set_hitbox(4, 4);
obj_set_priority(4);