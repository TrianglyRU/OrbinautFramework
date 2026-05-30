/// @self
/// @description												Finds a tile along a horizontal axis at the given position within a specified tile layer and returns an array containing two values: the distance to the tile's edge and its angle.
/// @param {Real} _x											The x-coordinate of the position.
/// @param {Real} _y											The y-coordinate of the position.
/// @param {Real} _dir											The direction in which to perform the search.
/// @param {Enum.COLLISION_LAYER|Undefined} [_secondary_layer]	The index of the secondary tile layer to search within (default is COLLISION_LAYER.PATH_A).
/// @param {Enum.QUADRANT} [_quadrant]							The angle range the check is happening within. This will affect if tile properties are gonna be rotated (default is QUADRANT.DOWN).
/// @returns {Array<Real>}
function tile_raycast_h(_x, _y, _dir, _secondary_layer = COLLISION_LAYER.PATH_A, _quadrant = QUADRANT.DOWN)
{
	_x = floor(_x);
	_y = floor(_y);
	_y = max(0, _y);
	
	var _best_distance = TILE_SIZE * 2;
    var _best_ang = TILE_EMPTY_ANGLE;
	
	if _y > room_height
	{
		return [_best_distance, _best_ang];
	}
	
	var _markers = obj_game.marker_tilemaps;
	var _tilemaps = obj_game.tilemaps;
	var _widths = obj_game.tile_widths_ref;
	var _angles = obj_game.tile_angles_ref;
	var _tilemaps_num = array_length(_tilemaps);
	
	var _start_cell_id_x = floor(_x / TILE_SIZE);
    var _start_cell_id_y = floor(_y / TILE_SIZE);
	var _mod_y = _y % TILE_SIZE;
	
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
        
        var _result_ang = TILE_EMPTY_ANGLE;
		var _result_distance = _best_distance;
        var _cell_id_x = _start_cell_id_x;
        var _cell_id_y = _start_cell_id_y;
		
		var _check_index = 0;
        var _tile, _index, _w, _flip;
		
        while true
        {
			var _tile_buffer, _index_buffer, _width_buffer, _flip_buffer, _width_data;
			
			_tile = tilemap_get(_tilemap, _cell_id_x, _cell_id_y);
			_flip = tile_get_flip(_tile);
			_index = tile_get_index(_tile);	
			_width_data = _widths[? _index];
			
			// Check validity and get width
			if _width_data != undefined
			{
				var _marker_index = 0;
				var _markermap = _markers[_i];
				
				if _markermap != -1
				{
					var _marker_tile = tilemap_get(_markermap, _cell_id_x, _cell_id_y);
					
					if _marker_tile != -1
					{
						_marker_index = tile_get_index(_marker_tile);
					}
				}
				
				var _is_right = _quadrant == QUADRANT.RIGHT;
				var _is_left = _quadrant == QUADRANT.LEFT;
				var _is_positive = _dir == 1;
				var _is_valid;
				
				switch _marker_index
				{	
					// Top Solid
					case 1:
						_is_valid = _is_right && _is_positive || _is_left && !_is_positive;
					break;
					
					// LBR Solid
					case 2:
						_is_valid = _is_right && !_is_positive || _is_left && _is_positive || !_is_right && !_is_left;
					break;
					
					// All Solid
					default:
						_is_valid = true;
				}
				
				if _is_valid
				{
					var _width_index;
				
					if _flip
					{
						_width_index = TILE_SIZE - 1 - _mod_y;
					}
					else
					{
						_width_index = _mod_y;
					}
				
					_w = _width_data[_width_index];
				}
				else
				{
					_w = 0;
				}
			}
			else
			{
				_w = 0;
			}
			
			// Check nearest tiles
			if _check_index == 0
			{
				if _w == 0
				{
					_check_index = 1;
					_cell_id_x += _dir;
				}
				else if _w == TILE_SIZE
				{
					_check_index = 2;
					_cell_id_x -= _dir;
					_tile_buffer = _tile;
					_index_buffer = _index;
					_width_buffer = _w;
					_flip_buffer = _flip;
				}
				else
				{
					break;
				}
			}
			else 
			{
				if _check_index == 2 && _w == 0
				{
					_tile = _tile_buffer;
					_index = _index_buffer;
					_w = _width_buffer;
					_flip = _flip_buffer;
					_cell_id_x += _dir;
				}
			
				break;
			}
        }
        
		var _mirror = tile_get_mirror(_tile);
		var _ang = _index <= 0 ? TILE_EMPTY_ANGLE : _angles[? _index];
		
		// Get angle
		if _ang != TILE_EMPTY_ANGLE
		{
			if _ang > 0
			{
				if _flip
				{
					_ang = (540 - _ang) % 360;
				}
			
				if _mirror
				{
					_ang = 360 - _ang;
				}
				
				_result_ang = _ang;
			}
			else
			{
				_result_ang = _dir == 1 ? 90 : 270;
			}
		}
		
		// Calculate distance to the edge of the surface
		if _dir == 1
		{
			_result_distance = _cell_id_x * TILE_SIZE + TILE_SIZE - 1 - _w - _x;
		}
		else
		{
			_result_distance = _x - _cell_id_x * TILE_SIZE - _w;
		}
        
		// Get closest tile among the checked layers
        if _result_distance < _best_distance
        {
            _best_distance = _result_distance;
            _best_ang = _result_ang;
        }
    }
	
	return [_best_distance, _best_ang];
}