FOR_EACH_PLAYER
{
	var _player = player_get(_p);
	
	if _p == 0
	{
		visible = _player.state == PLAYER_STATE.DEBUG_MODE;
	}
	
	if _player.state >= PLAYER_STATE.NO_INTERACT
	{
		continue;
	}
	
	var _y_last = _player.yprevious;
	var _y = _player.y;
	var _x = _player.x;
	
	if _x < bbox_left || _x >= bbox_right
	{
		continue;
	}
	
	if (_y_last >= y || _y < y) && (_y_last < y || _y >= y)
	{
		continue;
	}
	
	if !_player.is_forced_roll
	{
		_player.is_forced_roll = true;
		_player.roll();
	}
	else
	{
		_player.is_forced_roll = false;
	}
	
	_player.action = ACTION.NONE;
	_player.reset_gravity();
}