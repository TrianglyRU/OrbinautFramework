visible = global.debug_collision > 0;
	
for (var p = 0; p < PLAYER_COUNT; p++)
{
	var _player = player_get(p);
	
	if p == 0
	{
		visible |= _player.state == PLAYER_STATE_DEBUG_MODE;
	}
	
	if _player.state >= PLAYER_STATE_NO_CONTROL || !_player.is_grounded && GroundOnly
	{
		continue;
	}
		
	var _y_last = _player.yprevious;
	var _y = _player.y;
	var _x = _player.x;
		
	// Check if the player is within the horizontal bounds
	if _x < bbox_left || _x >= bbox_right
	{
		continue;
	}
		
	// Check for vertical crossing of the object
	if _y_last < y && _y >= y
	{
		_player.tile_layer = LayerBelow;
	}
	else if _y_last >= y && _y < y
	{
		_player.tile_layer = LayerAbove;
	}
}