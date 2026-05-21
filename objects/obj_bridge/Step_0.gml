var _max_bend_value_temp = 0;
var _apply_bend = false;
var _use_modern_bend = global.rotation_mode == ROTATION.MANIA;

// Calculate bend properties based on players' positions
FOR_EACH_PLAYER
{
    var _player = player_get(_p);
	
	solid_object(_player, SOLID_TYPE.TOP);
	
	if _player.on_object != id
	{
		ds_list_delete_value(players_on, _player);
		continue;
	}
	
	ds_list_add_once(players_on, _player);
	
	_apply_bend = true;
	
	var _log_index = clamp(floor(floor(_player.x - x + log_amount * log_size_half) / log_size) + 1, 1, log_amount) - 1;
	var _bend_value = log_bend_value[_log_index];
	
	if _bend_value > _max_bend_value_temp
	{
		max_bend_log_number = _log_index + 1;
		max_bend_value = _bend_value;
		
		_max_bend_value_temp = _bend_value;
	}
	
	log_index_by_player[_p] = _log_index;
}

// Apply bend
if _apply_bend
{
	if bend_angle < 90
	{
		bend_angle += BRIDGE_ANGLE_INCREMENT;
	}	
}
else if bend_angle > 0
{
	bend_angle -= BRIDGE_ANGLE_INCREMENT;
}

// Update logs
for (var _i = 0; _i < log_amount; _i++)
{
	var _distance = abs(_i + 1 - max_bend_log_number);
	var _strength = 1;
	
	if _i < max_bend_log_number
	{
		_strength -= _distance / max_bend_log_number;
	}
	else
	{
		_strength -= _distance / (log_amount - max_bend_log_number + 1);
	}
	
	var _bend_offset = max_bend_value * dsin(90 * _strength);
    
    if _use_modern_bend
	{
        log_bend_offset[_i] += (_bend_offset - log_bend_offset[_i]) * BRIDGE_LERP_VALUE;
	}
    else
	{
        log_bend_offset[_i] = _bend_offset;
	}
	
	log_y[_i] = y + log_bend_offset[_i] * dsin(bend_angle);
}

// Update players
for (var _i = ds_list_size(players_on) - 1; _i >= 0; _i--)
{
	var _player = players_on[| _i];
	
	if instance_exists(_player)
	{
		_player.y += round(log_bend_offset[log_index_by_player[_player.player_index]] * dsin(bend_angle));
	}
}