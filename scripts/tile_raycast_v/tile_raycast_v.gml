/// @self
/// @description												Finds a tile along a vertical axis at the given position within a specified tile layer and returns an array containing two values: the distance to the tile's edge and its angle.
/// @param {Real} _x											The x-coordinate of the position.
/// @param {Real} _y											The y-coordinate of the position.
/// @param {Real} _dir											The direction in which to perform the search.
/// @param {Enum.COLLISION_LAYER|Undefined} [_secondary_layer]	The index of the secondary tile layer to search within (default is COLLISION_LAYER.PATH_A).
/// @param {Enum.QUADRANT} [_quadrant]							The angle range the check is happening within. This will affect if tile properties are gonna be rotated (default is QUADRANT.DOWN).
/// @returns {Array<Real>}
function tile_raycast_v(_x, _y, _dir, _secondary_layer = COLLISION_LAYER.PATH_A, _quadrant = QUADRANT.DOWN)
{
	_x = floor(_x);
	_y = floor(_y);
	
    if _x < 0 || _x >= room_width
    {
        return [TILE_SIZE * 2, TILE_EMPTY_ANGLE];
    }
	
	// Get distance to the nearest surface
	var _distance = _calc_distance_v(_x, _y, _dir, _secondary_layer, _quadrant);
	var _sy = _y + _dir * _distance;
	
	var _tilemap = collision_tilemap_get(_x, _sy, _secondary_layer);
	var _angle;
	
	if _tilemap != -1
	{
		var _tile = tilemap_get_at_pixel(_tilemap, _x, _sy);
		var _set_angle = global.tile_angles[? tilemap_get_tileset(_tilemap)][? tile_get_index(_tile)];
		
		if tile_get_empty(_tile)
		{
			_angle = TILE_EMPTY_ANGLE;
		}
		else
		{
			// Get angle of the surface
			if _set_angle == undefined
			{
				var _ax1 = floor(_x / TILE_SIZE) * TILE_SIZE;
				var _ax2 = _ax1 + TILE_SIZE - 1;
				var _ay1 = _sy + _dir * _calc_distance_v(_ax1, _sy, _dir, _secondary_layer, _quadrant);
				var _ay2 = _sy + _dir * _calc_distance_v(_ax2, _sy, _dir, _secondary_layer, _quadrant);
				
				if _dir > 0
				{
					_angle = point_direction(_ax1, _ay1, _ax2, _ay2);
				}
				else
				{
					_angle = point_direction(_ax2, _ay2, _ax1, _ay1);
				}
		
				_angle = _correct_angle(_angle);
			}
	
			// Read set angle
			else if _set_angle != 0
			{
				if tile_get_flip(_tile)
				{
				    _set_angle = (540 - _set_angle) % 360;
				}
        
				if tile_get_mirror(_tile)
				{
				    _set_angle = 360 - _set_angle;
				}
				
				_angle = _set_angle;
			}
			else
			{
				_angle = _dir == 1 ? 0 : 180;
			}
		}
	}
	else
	{
		_angle = TILE_EMPTY_ANGLE;
	}
	
	return [_distance - 1, _angle];
}

/// @self tile_raycast_v
function _calc_distance_v(_x, _y, _dir, _secondary_layer, _quadrant)
{
	var _tile_y = floor(_y / TILE_SIZE) * TILE_SIZE;
	var _height = _read_height(_x, _tile_y, _dir, _secondary_layer, _quadrant);
	
	if _height == 0 || _height == TILE_SIZE
    {
		var _tile_y_prev = _tile_y;
		var _tile_step = _dir * TILE_SIZE;
		
		if _height == 0
		{
			_tile_y += _tile_step;
		}
		else
		{
			_tile_y -= _tile_step;
		}
		
		var _height_2 = _read_height(_x, _tile_y, _dir, _secondary_layer, _quadrant);
		
		if _tile_y == _tile_y_prev - _tile_step && _height_2 == 0
		{
			_tile_y = _tile_y_prev;
		}
		else
		{
			_height = _height_2;
		}
	}
	
	if _dir > 0
	{
	    return _tile_y + TILE_SIZE - _height - _y;
	}
	else
	{
	    return _y - _tile_y - _height + 1;
	}
}

/// @self tile_raycast_v
function _read_height(_x, _y, _dir, _secondary_layer, _quadrant)
{
	var _tilemap = collision_tilemap_get(_x, _y, _secondary_layer);
	
	if _tilemap == -1
	{
		return 0;
	}
	
	var _tile = tilemap_get_at_pixel(_tilemap, _x, _y);
	
	if tile_get_empty(_tile)
	{
		return 0;
	}
	
	var _tileset = tilemap_get_tileset(_tilemap);
	var _index = tile_get_index(_tile);
	var _height_data = global.tile_heights[? _tileset][? _index];
	
	if _height_data == undefined
	{
		return 0;
	}
	
	var _marker_index = 0;
	var _marker = obj_game.markers[? _tilemap];
	
	if _marker != -1
	{
		var _marker_tile = tilemap_get_at_pixel(_marker, _x, _y);
				
		if _marker_tile != -1
		{
			_marker_index = tile_get_index(_marker_tile);
		}
	}
		
	var _is_down = _quadrant == QUADRANT.DOWN;
	var _is_up = _quadrant == QUADRANT.UP;
	var _is_positive = _dir == 1;
	var _is_valid;
		
	switch _marker_index
	{
	    // Top Solid
	    case 1: 
	        _is_valid = _is_down && _is_positive || _is_up && !_is_positive;
		break;
					
	    // LBR Solid
	    case 2: 
	        _is_valid = _is_down && !_is_positive || _is_up && _is_positive || !_is_down && !_is_up;
		break;
					
		// All Solid
		default:
			_is_valid = true;
	}
		
	if !_is_valid
	{
		return 0;
	}
	
	var _height_index = _x % TILE_SIZE;
	
	if tile_get_mirror(_tile)
	{
		_height_index = TILE_SIZE - 1 - _height_index;	
	}
	
	var _height = _height_data[_height_index];
	
	if _height != 0
	{
		var _raw_angle = global.tile_angles[? _tileset][? _index];
		
		if _raw_angle != undefined && _raw_angle == 0
		{
			var _flip = tile_get_flip(_tile);
			
			if _dir > 0 && _flip || _dir < 0 && !_flip
		    {
		        _height = TILE_SIZE;
		    }
		}
	}

	return _height;
}