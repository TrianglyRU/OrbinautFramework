var _current_max_sag = 0;
var _someone_on_bridge = false;
var _smooth_sag = global.rotation_mode == ROTATION.MANIA;

// Determine which plank each player is standing on and find the plank with max sag
FOR_EACH_PLAYER
{
    var _player = player_get(_p);
	
	solid_object(_player, SOLID_TYPE.TOP);
	
	if _player.on_object != id
	{
		ds_list_delete_value(players_on_bridge, _player);
		continue;
	}
	
	ds_list_add_once(players_on_bridge, _player);
	
	_someone_on_bridge = true;
	
	var _plank_index = clamp(floor(floor(_player.x - x + plank_count * plank_width_half) / plank_width) + 1, 1, plank_count) - 1;
	var _plank_sag = plank_max_sag[_plank_index];
	
	if _plank_sag > _current_max_sag
	{
		peak_sag_plank_index = _plank_index + 1;
		peak_sag_value = _plank_sag;
		
		_current_max_sag = _plank_sag;
	}
	
	player_plank_index[_p] = _plank_index;
}

// Smoothly raise or lower the whole bridge via sag_angle
if _someone_on_bridge
{
	if sag_angle < 90
	{
		sag_angle += BRIDGE_ANGLE_INCREMENT;
	}	
}
else if sag_angle > 0
{
	sag_angle -= BRIDGE_ANGLE_INCREMENT;
}

// Recalculate each plank's sag relative to the peak-sag plank
for (var _i = 0; _i < plank_count; _i++)
{
	var _distance_from_peak = abs(_i + 1 - peak_sag_plank_index);
	var _sag_strength = 1;
	
	if _i < peak_sag_plank_index
	{
		_sag_strength -= _distance_from_peak / peak_sag_plank_index;
	}
	else
	{
		_sag_strength -= _distance_from_peak / (plank_count - peak_sag_plank_index + 1);
	}
	
	var _target_sag_offset = peak_sag_value * dsin(90 * _sag_strength);
    
    if _smooth_sag
	{
        plank_sag_offset[_i] += (_target_sag_offset - plank_sag_offset[_i]) * BRIDGE_LERP_VALUE;
	}
    else
	{
        plank_sag_offset[_i] = _target_sag_offset;
	}
	
	plank_y[_i] = y + plank_sag_offset[_i] * dsin(sag_angle);
}

// Move players along with the plank they're standing on
for (var _i = ds_list_size(players_on_bridge) - 1; _i >= 0; _i--)
{
	var _player = players_on_bridge[| _i];
	
	if instance_exists(_player)
	{
		_player.y += round(plank_sag_offset[player_plank_index[_player.player_index]] * dsin(sag_angle));
	}
}