/// @self
/// @description Checks if the specified object is visible within any of the current view boundaries. Note that this function refers to the any GameMaker camera, not specifically the one created with the `camera_new()` function.
/// @param {Id.Instance} id The object instance (optional, defaults to the current instance).
/// @returns {Bool}
function obj_is_visible(_id = id)
{
	var _culling = _id.data_culling;
	var _size_x = _culling.size_x;
	var _size_y = _culling.size_y;
	var _x = _id.x;
	var _y = _id.y;

	// Check if the object is within the bounds of any camera
	for (var i = 0; i < CAMERA_COUNT; i++)
	{
		if !view_visible[i]
		{
			continue;
		}
		
		var _cx = camera_get_x(i);
		var _cy = camera_get_y(i);

		if _x + _size_x >= _cx && _x - _size_x < _cx + camera_get_width(i)
		&& _y + _size_y >= _cy && _y - _size_y < _cy + camera_get_height(i)
		{
			return true;
		}
	}

	return false;
}