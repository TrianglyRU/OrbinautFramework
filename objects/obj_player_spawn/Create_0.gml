instance_destroy();

var _target_player = image_index > 0 ? image_index - 1 : global.player_main;

if image_index > 0
{
	if global.player_main != _target_player
	{
		return;
	}
}
else
{
	switch _target_player
	{
		case PLAYER.SONIC:
	
			if iv_shared_exclude_sonic
			{
				return;
			}
		
		break;
		
		case PLAYER.TAILS:
	
			if iv_shared_exclude_tails
			{
				return;
			}
		
		break;
		
		case PLAYER.KNUCKLES:
		
			if iv_shared_exclude_knuckles
			{
				return;
			}
		
		break;
		
		case PLAYER.AMY:
	
			if iv_shared_exclude_amy
			{
				return;
			}
		
		break;
	}
}

player_spawn(x, y, _target_player);