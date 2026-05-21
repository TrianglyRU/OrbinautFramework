/// @self
/// @description												Identifies the nearest tile along a vertical axis between two given points and returns an array containing two values: the distance to the found tile's edge and its angle.
/// @param {Real} _x1											The x-coordinate of the first point.
/// @param {Real} _y1											The y-coordinate of the first point.
/// @param {Real} _x2											The x-coordinate of the second point.
/// @param {Real} _y2											The y-coordinate of the second point.
/// @param {Real} _dir											The direction in which to perform the search.
/// @param {Enum.COLLISION_LAYER|Undefined} [_secondary_layer]	The index of the secondary tile layer to search within (default is COLLISION_LAYER.PATH_A).
/// @param {Enum.QUADRANT|Real} [_quadrant]						The angle range the check is happening within. This will affect if tile properties are gonna be rotated (default is QUADRANT.DOWN).
/// @returns {Array<Real>}
function tile_raycast_2v(_x1, _y1, _x2, _y2, _dir, _secondary_layer = COLLISION_LAYER.PATH_A, _quadrant = QUADRANT.DOWN)
{
	var _tile_data1 = tile_raycast_v(_x1, _y1, _dir, _secondary_layer, _quadrant);
	var _tile_data2 = tile_raycast_v(_x2, _y2, _dir, _secondary_layer, _quadrant);
    
	var _floor_dist1 = _tile_data1[0];
    var _floor_dist2 = _tile_data2[0];
	var _floor_ang1 = _tile_data1[1];
	var _floor_ang2 = _tile_data2[1];
	
	if _floor_dist1 <= _floor_dist2
	{
		return [_floor_dist1, _floor_ang1];
	}
	
	return [_floor_dist2, _floor_ang2];
}