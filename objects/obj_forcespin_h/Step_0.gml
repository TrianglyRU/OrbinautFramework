visible = global.debug_collision > 0;
	
for (var p = 0; p < PLAYER_COUNT; p++)
{
	var _player = player_get(p);
		
	if p == 0
	{
		visible |= _player.state == PLAYER_STATE_DEBUG_MODE;
	}
	
	if _player.state >= PLAYER_STATE_NO_CONTROL
	{
		continue;
	}
		
	var _x_last = _player.xprevious;
	var _x = _player.x;
	var _y = _player.y;
		
	// Check if the player is within the vertical bounds
	if _y < bbox_top || _y >= bbox_bottom
	{
		continue;
	}
		
	// Check for horizontal crossing of the object
	if (_x_last >= x || _x < x) && (_x_last < x || _x >= x)
	{
		continue;
	}
	
	_player.action = ACTION_NONE;
	_player.forced_roll = !_player.forced_roll;		
	_player.m_player_reset_gravity();
}