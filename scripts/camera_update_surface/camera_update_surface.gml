/// @self
/// @description Updates the surface associated with the specified viewport index. The current resolution is maintained if no new resolution is provided.
/// @param {Real} index The index of viewport.
/// @param {Real|Undefined} canvas_width The new horizontal resolution of the surface. Pass `undefined` to retain the current width.
/// @param {Real|Undefined} canvas_height The new vertical resolution of the surface. Pass `undefined` to retain the current height.
/// @param {Real|Undefined} [x] The horizontal offset of the surface. Pass `undefined` to retain the current height (optional, defaults to 0).
/// @param {Real|Undefined} [y] The vertical offset of the surface. Pass `undefined` to retain the current height (optional, defaults to 0).
function camera_update_surface(_index, _width, _height, _x = 0, _y = 0)
{
	// Exit if the surface is invalid or doesn't exist
	var _surface = view_surface_id[_index];
	
	if _surface == -1 || !surface_exists(_surface)
	{
		exit;
	}

	// Set initial width and height
	var _w = _width;
	var _h = _height;

	// Retrieve camera data and adjust size/position if provided
	var _camera_data = camera_get_data(_index);
	if _camera_data != noone
	{
		if _width == undefined
		{
			_w = _camera_data.surface_w;
		}
		
		if _height == undefined
		{
			_h = _camera_data.surface_h;
		}
		
		if _x != undefined
		{
			_camera_data.surface_x = _x;
		}
		
		if _y != undefined
		{
			_camera_data.surface_y = _y;
		}
	}

	// Resize the surface to the new dimensions
	surface_resize(_surface, _w, _h);
}
