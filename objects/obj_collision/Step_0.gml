visible = global.debug_collision > 0;

for (var p = 0; p < PLAYER_COUNT; p++)
{
	var _player = player_get(p);
	
	if p == 0
	{
		visible |= _player.state == PLAYER_STATE_DEBUG_MODE;
	}
	
	obj_act_solid(_player, SOLIDOBJECT.FULL);
}