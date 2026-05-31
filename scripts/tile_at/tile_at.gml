/// @self
/// @description												Checks whether a solid tile exists at the given position.
/// @param {Real} _x											The x-coordinate of the position.
/// @param {Real} _y											The y-coordinate of the position.
/// @param {Enum.COLLISION_LAYER|Undefined} [_secondary_layer]	The index of the secondary tile layer to check within (default is COLLISION_LAYER.PATH_A).
/// @returns {Enum.TILE_SOLIDITY}
function tile_at(_x, _y, _secondary_layer = COLLISION_LAYER.PATH_A)
{
	var _markers = obj_game.marker_tilemaps;
	var _tilemaps = obj_game.tilemaps;
	var _tilemaps_num = array_length(_tilemaps);
	
	_x = floor(_x);
	_y = floor(_y);
	
    for (var _i = 0; _i < _tilemaps_num; _i++)
	{
        // Don't check anything other than the main layer or the specified secondary layer
		if _i != COLLISION_LAYER.MAIN && _i != _secondary_layer
		{
			continue;
		}
		
        var _tilemap = _tilemaps[_i];
		
        if _tilemap == -1
        {
            continue;
        }
		
		if !collision_point(_x, _y, _tilemap, true, true)
		{
			continue;
		}
		
		var _marker_index = 0;
		var _markermap = _markers[_i];
		
		if _markermap != -1
		{
			var _x_cell = floor(_x / TILE_SIZE);
			var _y_cell = floor(_y / TILE_SIZE);
			var _marker_tile = tilemap_get(_markermap, _x_cell, _y_cell);
			
			if _marker_tile != -1
			{
				_marker_index = tile_get_index(_marker_tile);
			}
		}
		
		return _marker_index + 1;
	}
	
	return TILE_SOLIDITY.NONE;
}