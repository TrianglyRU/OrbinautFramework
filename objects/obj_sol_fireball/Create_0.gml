// Inherit the parent event
event_inherited();
event_culler(CULL_ACTION.NONE);

hurt_players = function()
{
	FOR_EACH_PLAYER
	{
		var _player = player_get(_p);
		
		if global.player_shields[_p] != SHIELD.FIRE && collision_player(_player)
		{
			_player.hurt(id);
		}
	}
}

depth = draw_depth(40);
vel_x = 0;
flip_timer = 0;