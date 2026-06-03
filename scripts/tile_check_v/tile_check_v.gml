/// @self
/// @description												Checks for a valid collision tile at the given position using the specified vertical direction. Similar to tile_raycast_v, but without angle calculation or lookup.
/// @param {Real} _x											The x-coordinate of the position.
/// @param {Real} _y											The y-coordinate of the position.
/// @param {Real} _dir											The direction in which to perform the search.
/// @param {Enum.COLLISION_LAYER|Undefined} [_secondary_layer]	The index of the secondary tile layer to search within (default is COLLISION_LAYER.PATH_A).
/// @param {Enum.QUADRANT} [_quadrant]							The angle range the check is happening within. This will affect if tile properties are gonna be rotated (default is QUADRANT.DOWN).
/// @returns {Array<Real>}
function tile_check_v(_x, _y, _dir, _secondary_layer = COLLISION_LAYER.PATH_A, _quadrant = QUADRANT.DOWN)
{
	var _tile_y = floor(_y / TILE_SIZE) * TILE_SIZE;
	var _height = _read_height(_x, _tile_y, _dir, _secondary_layer, _quadrant);
	
	var _distance;
	
	if _dir > 0
	{
	    _distance = _tile_y + TILE_SIZE - _height - _y;
	}
	else
	{
	    _distance = _y - _tile_y - _height + 1;
	}
	
	return _distance <= 0;
}