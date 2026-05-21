// Inherit the parent event
event_inherited();

enum GIGANSPIKE_STATE
{
	ROTATE,
	LAUNCHED
}

hurt_player = function()
{
	if image_index == 2
	{
		return;
	}
	
	FOR_EACH_PLAYER
	{
		var _player = player_get(_p);
		
		if !_player.is_invincible() && collision_player(_player)
		{
			_player.hurt(id);
		}
	}
}

depth = draw_depth(30);
state = GIGANSPIKE_STATE.ROTATE;
vel_x = 0;
vel_y = 0;
fly_timer = 0;
parent_boss = noone;