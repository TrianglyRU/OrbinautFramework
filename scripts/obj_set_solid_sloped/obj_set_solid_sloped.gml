/// @self c_object
/// @description Configures the collision properties for a sloped object using a heightmap.
/// @param {Array<Real>} heightmap An array of numbers representing the height at various points.
/// @param {Real} [offset_x] The horizontal offset of the collision area from the object's centre (optional, defaults to 0).
/// @param {Real} [offset_y] The vertical offset of the collision area from the object's centre (optional, defaults to 0).
function obj_set_solid_sloped(_heightmap, _offset_x = 0, _offset_y = 0)
{
	var _data_solid = data_solid;

	var _x1 = array_length(_heightmap);
	var _y1 = max(_heightmap[0], _heightmap[_x1 - 1]);

	// Set solid object properties based on heightmap
	_data_solid.radius_x = floor(_x1 / 2);
	_data_solid.radius_y = _y1;
	_data_solid.offset_x = _offset_x;
	_data_solid.offset_y = _offset_y;
	_data_solid.height_map = _heightmap;
}