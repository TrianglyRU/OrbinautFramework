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
		
	var _x_last = _player.xprevious;
	var _x = _player.x;
	var _y = _player.y;
	
	if _y < bbox_top || _y >= bbox_bottom
	{
		continue;
	}
	
	if _x_last < x && _x >= x
	{
		_player.secondary_layer = layer_data[1];
	}
	else if _x_last >= x && _x < x
	{
		_player.secondary_layer = layer_data[0];
	}
}