FOR_EACH_PLAYER
{
	var _player = player_get(_p);
	
	if _p == 0
	{
		visible = _player.state == PLAYER_STATE.DEBUG_MODE;
	}
	
	solid_object(_player, SOLID_TYPE.FULL);
}