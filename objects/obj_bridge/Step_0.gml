var _max_dip = 0;
var _player_touch = false;

for (var p = 0; p < PLAYER_COUNT; p++)
{
    var _player = player_get(p);
	
	obj_act_solid(_player, SOLIDOBJECT.TOP);
	
	if !obj_check_solid(_player, SOLIDCOLLISION.TOP)
	{
		continue;
	}
	
	_player_touch = true;
	
	// Get the log player is standing on
	var _active_log = clamp
	(
		floor(floor(_player.x - x + log_amount * log_size_half) / log_size) + 1, 1, log_amount
	);
		
	var _dip_value = dip[_active_log - 1];
	if _dip_value > _max_dip
	{
		active_log = _active_log;
		max_dip = _dip_value;
		
		// Remember current dip value for the next player
		_max_dip = max_dip;
	}
	
	_player.y += round(_dip_value * dsin(angle));
}

// Calculate y position for each log
for (var i = 0; i < log_amount; i++)
{
	var _log_diff = abs(i + 1 - active_log);
	var _log_dist = 1;
	
	if i < active_log
	{
		_log_dist -= _log_diff / active_log;
	}
	else
	{
		_log_dist -= _log_diff / (log_amount - active_log + 1);
	}
	
	log_y[i] = y + round(max_dip * dsin(90 * _log_dist) * dsin(angle));
}

// Adjust the angle
if _player_touch
{
	if angle < 90
	{
		angle += 5.625;
	}	
}
else if angle > 0
{
	angle -= 5.625;
}