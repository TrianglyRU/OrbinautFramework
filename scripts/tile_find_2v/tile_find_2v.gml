/// @self
/// @description Identifies the nearest tile along a vertical axis between two given points and returns an array containing two values: the distance to the found tile's edge and its angle.
/// @param {Real} x1 The x-coordinate of the first point.
/// @param {Real} y1 The y-coordinate of the first point.
/// @param {Real} x2 The x-coordinate of the second point.
/// @param {Real} y2 The y-coordinate of the second point.
/// @param {Enum.DIRECTION} dir The direction in which to perform the search.
/// @param {Enum.TILELAYER} layer The index of the tile layer to search within.
/// @param {Enum.TILEBEHAVIOUR} [behaviour] The behaviour type of the tile (optional, defaults to DEFAULT).
/// @returns {Array<Real>}
function tile_find_2v(_x1, _y1, _x2, _y2, _dir, _layer, _behaviour = TILEBEHAVIOUR.DEFAULT)
{
	// Retrieve tile data for both coordinates
	var _tile_data1 = tile_find_v(_x1, _y1, _dir, _layer, _behaviour);
	var _tile_data2 = tile_find_v(_x2, _y2, _dir, _layer, _behaviour);
	var _floor_dist1 = _tile_data1[0];
	var _floor_ang1 = _tile_data1[1];
	var _floor_dist2 = _tile_data2[0];
	var _floor_ang2 = _tile_data2[1];
	
	// Compare floor distances and return the tile data with the smaller distance
	if _floor_dist1 <= _floor_dist2
	{
		return [_floor_dist1, _floor_ang1];
	}
	
	return [_floor_dist2, _floor_ang2];
}