/// @self c_object
/// @description Determines whether the calling object collides with the specified target object's hitbox.
/// @param {Id.Instance} target The object instance to check.
/// @param {Bool} [use_target_ext] If true, checks the target's extended hitbox; if false, checks the standard hitbox (optional, defaults to false).
/// @returns {Bool}
function obj_check_hitbox(_target, _use_target_ext = false)
{
	// Check if target is the player
	if _target.object_index == obj_player && _target.state != PLAYER_STATE_CONTROL
	{
		return false;
	}

	var _t_data_interact = _target.data_interact;
	var _data_interact = data_interact;

	// Check if both objects can interact
	if !_t_data_interact.interact || !_data_interact.interact
	{
		return false;
	}

	var _target_rx, _target_ry, _target_ox, _target_oy, _hitbox_colour;

	// Determine target hitbox using extended radius if available
	if _use_target_ext
	{
		_target_rx = _t_data_interact.radius_x_ext;
		_target_ry = _t_data_interact.radius_y_ext;

		if _target_rx <= 0 || _target_ry <= 0
		{
			_use_target_ext = false;	
		}	
		else
		{
			_target_ox = _t_data_interact.offset_x_ext;
			_target_oy = _t_data_interact.offset_y_ext;
			_hitbox_colour = $0000DC;
		}
	}

	// Determine target hitbox using normal radius if extended is not used
	if !_use_target_ext
	{
		_target_rx = _t_data_interact.radius_x;
		_target_ry = _t_data_interact.radius_y;

		if _target_rx <= 0 || _target_ry <= 0
		{
			return false;
		}

		_target_ox = _t_data_interact.offset_x;
		_target_oy = _t_data_interact.offset_y;	
		_hitbox_colour = $FF00DC;
	}

	// Calculate hitbox boundaries for both objects
	var _target_x = floor(_target.x) + _target_ox;
	var _target_y = floor(_target.y) + _target_oy;
	var _target_l = _target_x - _target_rx;
	var _target_r = _target_x + _target_rx;
	var _target_t = _target_y - _target_ry;
	var _target_b = _target_y + _target_ry;
	
	var _this_x = floor(x) + _data_interact.offset_x;
	var _this_y = floor(y) + _data_interact.offset_y;
	var _this_l = _this_x - _data_interact.radius_x;
	var _this_r = _this_x + _data_interact.radius_x;
	var _this_t = _this_y - _data_interact.radius_y;
	var _this_b = _this_y + _data_interact.radius_y;

	// Visualise collision if debugging
	if global.debug_collision == 2
	{
		var _ds_list = c_framework.collision.ds_interact;

		if ds_list_find_index(_ds_list, _target) == -1
		{
			ds_list_add(_ds_list, _target_l, _target_t, _target_r, _target_b, _hitbox_colour, _target);
		}

		if ds_list_find_index(_ds_list, id) == -1
		{
			ds_list_add(_ds_list, _this_l, _this_t, _this_r, _this_b, _hitbox_colour, id);
		}
	}

	// Check for horizontal and vertical overlap between hitboxes
	if _target_r < _this_l || _target_l > _this_r
	{
		return false;
	}
	
	if _target_b < _this_t || _target_t > _this_b
	{
		return false;
	}
	
	_data_interact.interact = false;
	_t_data_interact.interact = false;

	return true;
}