/// @self
/// @description												Checks for tile collision vertically between two positions and returns the distance to the nearest surface.
/// @param {Real} _x1											The x-coordinate of the first point.
/// @param {Real} _y1											The y-coordinate of the first point.
/// @param {Real} _x2											The x-coordinate of the second point.
/// @param {Real} _y2											The y-coordinate of the second point.
/// @param {Real} _dir											The direction in which to perform the search.
/// @param {Enum.COLLISION_LAYER|Undefined} [_secondary_layer]	The index of the secondary tile layer to search within (default is COLLISION_LAYER.PATH_A).
/// @param {Enum.QUADRANT|Real} [_quadrant]						The angle range the check is happening within. This will affect if tile properties are gonna be rotated (default is QUADRANT.DOWN).
/// @returns {Real}
function tile_check_2v(_x1, _y1, _x2, _y2, _dir, _secondary_layer = COLLISION_LAYER.PATH_A, _quadrant = QUADRANT.DOWN)
{
	var _dist1 = tile_check_v(_x1, _y1, _dir, _secondary_layer, _quadrant);
	var _dist2 = tile_check_v(_x2, _y2, _dir, _secondary_layer, _quadrant);
    
	return _dist1 <= _dist2 ? _dist1 : _dist2;
}