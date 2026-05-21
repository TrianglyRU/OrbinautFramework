/// @description					Checks if the instance is visible or drawn within any of the current view boundaries.
/// @param {ID.Instance} _inst_id	The instance to check (default is the calling instance)
/// @returns {Bool}
function instance_is_drawn(_inst_id = id)
{
	if _inst_id != id && !instance_exists(_inst_id)
	{
		return false;
	}
	
	if _inst_id.sprite_index < 0 || !_inst_id.visible
	{
		return false;
	}
	
	FOR_EACH_CAMERA
	{
		if view_camera[_c] == -1
		{
			continue;
		}
		
		var _cx = camera_get_x(_c);
		var _cw = camera_get_width(_c);
		
		var _x = _inst_id.x;
		var _y = _inst_id.y;
		var _w = abs(_inst_id.sprite_width) * 0.5;
		var _h = abs(_inst_id.sprite_height) * 0.5;
		
		if _x + _w - 1 >= _cx && _x - _w < _cx + _cw
		{
			var _cy = camera_get_y(_c);
			var _ch = camera_get_height(_c);
			
			if _y + _h - 1 >= _cy && _y - _h < _cy + _ch
			{
				return true;
			}
		}
	}

	return false;
}