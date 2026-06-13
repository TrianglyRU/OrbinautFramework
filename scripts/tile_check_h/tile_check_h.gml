/// @self
/// @description												Checks for a valid collision tile at the given position using the specified horizontal direction. Similar to tile_raycast_h, but without angle calculation or lookup.
/// @param {Real} _x											The x-coordinate of the position.
/// @param {Real} _y											The y-coordinate of the position.
/// @param {Real} _dir											The direction in which to perform the search.
/// @param {Enum.COLLISION_LAYER|Undefined} [_secondary_layer]	The index of the secondary tile layer to search within (default is COLLISION_LAYER.PATH_A).
/// @param {Enum.QUADRANT} [_quadrant]							The angle range the check is happening within. This will affect if tile properties are gonna be rotated (default is QUADRANT.DOWN).
/// @returns {Array<Real>}
function tile_check_h(_x, _y, _dir, _secondary_layer = COLLISION_LAYER.PATH_A, _quadrant = QUADRANT.DOWN)
{
	var _tile_x = floor(_x / TILE_SIZE) * TILE_SIZE;
	var _width = _read_width(_tile_x, _y, _dir, _secondary_layer, _quadrant);
	
	var _distance;
	
	if _dir > 0
	{
	    _distance = _tile_x + TILE_SIZE - _width - _x;
	}
	else
	{
	    _distance = _x - _tile_x - _width;
	}
	
	return _distance <= 0;
}