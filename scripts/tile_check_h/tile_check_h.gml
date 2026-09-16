/// @self
/// @description												Checks for tile collision horizontally and returns the distance to the nearest surface.
/// @param {Real} _x											The x-coordinate of the position.
/// @param {Real} _y											The y-coordinate of the position.
/// @param {Real} _dir											The direction in which to perform the search.
/// @param {Enum.COLLISION_LAYER|Undefined} [_secondary_layer]	The index of the secondary tile layer to search within (default is COLLISION_LAYER.PATH_A).
/// @param {Enum.QUADRANT} [_quadrant]							The angle range the check is happening within. This will affect if tile properties are gonna be rotated (default is QUADRANT.DOWN).
/// @returns {Real}
function tile_check_h(_x, _y, _dir, _secondary_layer = COLLISION_LAYER.PATH_A, _quadrant = QUADRANT.DOWN)
{
	_x = floor(_x);
	_y = floor(_y);
	_y = max(0, _y);
	
	if _y >= room_height
	{
		return TILE_SIZE * 2;
	}
	
	return _calc_distance_h(_x, _y, _dir, _secondary_layer, _quadrant);
}