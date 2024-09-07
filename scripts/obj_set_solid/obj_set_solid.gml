/// @self c_object
/// @description Configures the object's solid collision area by setting its size and offset relative to the object's centre.
/// @param {Real} radius_x The horizontal radius of the solid collision area.
/// @param {Real} radius_y The vertical radius of the solid collision area.
/// @param {Real} [offset_x] The horizontal offset of the collision area from the object's centre (optional, defaults to 0).
/// @param {Real} [offset_y] The vertical offset of the collision area from the object's centre (optional, defaults to 0).
function obj_set_solid(_radius_x, _radius_y, _offset_x = 0, _offset_y = 0)
{
	var _data_solid = data_solid;
	
	_data_solid.radius_x = _radius_x;
	_data_solid.radius_y = _radius_y;
	_data_solid.offset_x = _offset_x;
	_data_solid.offset_y = _offset_y;
	_data_solid.height_map = [];
}
