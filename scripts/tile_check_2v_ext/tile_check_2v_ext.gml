/// @self
/// @description												Checks for tile collision vertically between two positions and returns an array containing the distance to the nearest surface, its angle, and the index of the closest point.
/// @param {Real} _x1											The x-coordinate of the first point.
/// @param {Real} _y1											The y-coordinate of the first point.
/// @param {Real} _x2											The x-coordinate of the second point.
/// @param {Real} _y2											The y-coordinate of the second point.
/// @param {Real} _dir											The direction in which to perform the search.
/// @param {Enum.COLLISION_LAYER|Undefined} [_secondary_layer]	The index of the secondary tile layer to search within (default is COLLISION_LAYER.PATH_A).
/// @param {Enum.QUADRANT|Real} [_quadrant]						The angle range the check is happening within. This will affect if tile properties are gonna be rotated (default is QUADRANT.DOWN).
/// @returns {Array<Real>}
function tile_check_2v_ext(_x1, _y1, _x2, _y2, _dir, _secondary_layer = COLLISION_LAYER.PATH_A, _quadrant = QUADRANT.DOWN)
{
	var _data1 = tile_check_v_ext(_x1, _y1, _dir, _secondary_layer, _quadrant);
	var _data2 = tile_check_v_ext(_x2, _y2, _dir, _secondary_layer, _quadrant);
    
	var _dist1 = _data1[0];
    var _dist2 = _data2[0];
	
	if _dist1 <= _dist2
	{
		return [_dist1, _data1[1], 1];
	}
	
	return [_dist2, _data2[1], 2];
}