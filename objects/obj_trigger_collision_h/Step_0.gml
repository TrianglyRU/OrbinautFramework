FOR_EACH_PLAYER
{
	var _player = player_get(_p);
	
	if _p == 0
	{
		visible = _player.state == PLAYER_STATE.DEBUG_MODE;
	}
	
	if _player.state >= PLAYER_STATE.NO_INTERACT || !_player.is_grounded && iv_ground_only
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
	
	if _y_last < y && _y >= y
	{
		_player.secondary_layer = layer_data[1];
	}
	else if _y_last >= y && _y < y
	{
		_player.secondary_layer = layer_data[0];
	}
}