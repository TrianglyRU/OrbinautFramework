/// @self
/// @description Creates a new camera and assigns it to a new surface, returning a struct containing its data. It will delete any existing camera assigned to the same index.
/// @param {Real} index The index to assign the new camera to.
/// @param {Real} width The horizontal resolution of the camera.
/// @param {Real} height The vertical resolution of the camera.
/// @param {Real} canvas_width The horizontal size of the canvas (surface).
/// @param {Real} canvas_height The vertical size of the canvas (surface).
/// @param {Real} [pos_x] The initial x position of the camera in the room (optional, defaults to 0).
/// @param {Real} [pos_y] The initial y position of the camera in the room (optional, defaults to 0).
/// @param {Real} [canvas_x] The horizontal offset of the surface on the screen (optional, defaults to 0).
/// @param {Real} [canvas_y] The vertical offset of the surface on the screen (optional, defaults to 0).
/// @returns {Struct}
function camera_new(_index, _width, _height, _canvas_width, _canvas_height, _pos_x = 0, _pos_y = 0, _canvas_x = 0, _canvas_y = 0)
{
	// Destroy existing camera
	camera_destroy(view_camera[_index]);
	
	var _vel_x_max = 16;
	var _vel_y_max = 16;

	if global.no_camera_cap
	{
		_vel_x_max = 65535;
		_vel_y_max = 65535;
	}

	// Create the camera data struct
	var _camera_struct =
	{
		index: _index,
		allow_movement: true,
		target: noone,
		vel_x_max: _vel_x_max,
		vel_y_max: _vel_y_max,
		vel_x: 0,
		vel_y: 0,
		pos_x: _pos_x,
		pos_y: _pos_y,
		pos_x_prev: 0,
		pos_y_prev: 0,
		delay_x: 0,
		delay_y: 0,
		offset_x: 0,
		offset_y: 0,	
		min_x: 0,
		min_y: 0,
		max_x: room_width,
		max_y: room_height,
		shake_x: 0,
		shake_y: 0,
		shake_timer: 0,
		coarse_x: -1,
		coarse_y: -1,
		coarse_x_last: -1,
		coarse_y_last: -1,
		
		// Private
		surface_x: _canvas_x,
		surface_y: _canvas_y,
		surface_w: _canvas_width + ENGINE_RENDERER_HORIZONTAL_BUFFER * 2,
		surface_h: _canvas_height
	};
	
	// Create a new camera view
	view_camera[_index] = camera_create_view(_camera_struct.pos_x, _camera_struct.pos_y, _width + ENGINE_RENDERER_HORIZONTAL_BUFFER * 2, _height);
	view_visible[_index] = true;
	
	c_framework.camera_data[_index] = _camera_struct;

	return _camera_struct;
}