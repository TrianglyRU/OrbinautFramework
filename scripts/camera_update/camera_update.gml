/// @self
/// @description Updates the size of the camera associated with the specified viewport index. The current size is maintained if no new size is provided.
/// @param {Real} index The index of the viewport.
/// @param {Real|Undefined} width The new width of the camera. Pass `undefined` to retain the current width.
/// @param {Real|Undefined} height The new height of the camera. Pass `undefined` to retain the current height.
/// @param {Real|Undefined} pos_x The new x position of the camera in the room. Pass `undefined` to retain the current position.
/// @param {Real|Undefined} pos_y The new y position of the camera in the room. Pass `undefined` to retain the current position.
function camera_update(_index, _width, _height, _pos_x, _pos_y)
{
	// Exit if the camera is not set
	var _camera = view_camera[_index];	
	
	if _camera == -1
	{
		exit;
	}

	// Retrieve current camera data and calculate new size/position
	var _camera_data = c_framework.camera_data[_index];
	var _w = _width == undefined ? camera_get_view_width(_camera) : _width + ENGINE_RENDERER_HORIZONTAL_BUFFER * 2;
	var _h = _height == undefined ? camera_get_view_height(_camera) : _height;
	var _x = _pos_x == undefined ? _camera_data.pos_x : _pos_x;
	var _y = _pos_y == undefined ? _camera_data.pos_y : _pos_y;

	// Update camera data and apply new settings
	_camera_data.pos_x = _x;
	_camera_data.pos_y = _y;
	_camera_data.pos_x_prev = _x;
	_camera_data.pos_y_prev = _y;
	
	camera_set_view_pos(_camera, _x - ENGINE_RENDERER_HORIZONTAL_BUFFER, _y);
	camera_set_view_size(_camera, _w, _h);
}
