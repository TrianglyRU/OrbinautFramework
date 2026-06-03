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
	
	if _y >= room_height
	{
		return [TILE_SIZE * 2, TILE_EMPTY_ANGLE];
	}
	
	// Get distance to the nearest surface
	var _distance = _calc_distance_h(_x, _y, _dir, _secondary_layer, _quadrant);
	var _sx = _x + _dir * _distance;
	
	var _tilemap = collision_tilemap_get(_sx, _y, _secondary_layer);
	var _angle;
	
	if _tilemap != -1
	{
		var _tile = tilemap_get_at_pixel(_tilemap, _sx, _y);
		
		if tile_get_empty(_tile)
		{
			_angle = TILE_EMPTY_ANGLE;
		}
		else
		{
			var _set_angle = global.tile_angles[? tilemap_get_tileset(_tilemap)][? tile_get_index(_tile)];
			
			if _set_angle == undefined
			{
				var _ay1 = floor(_y / TILE_SIZE) * TILE_SIZE;
				var _ay2 = _ay1 + TILE_SIZE - 1;
				var _ax1 = _sx + _dir * _calc_distance_h(_sx, _ay1, _dir, _secondary_layer, _quadrant);
				var _ax2 = _sx + _dir * _calc_distance_h(_sx, _ay2, _dir, _secondary_layer, _quadrant);
				
				if _dir > 0
				{
					_angle = point_direction(_ax2, _ay2, _ax1, _ay1);
				}
				else
				{
					_angle = point_direction(_ax1, _ay1, _ax2, _ay2);
				}
				
				_angle = _correct_angle(_angle);
			}
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
				_angle = _dir == 1 ? 90 : 270;
			}
		}
	}
	else
	{
		_angle = TILE_EMPTY_ANGLE;
	}
	
	return [_distance - 1, _angle];
}

/// @self tile_raycast_h
function _calc_distance_h(_x, _y, _dir, _secondary_layer, _quadrant)
{
	var _tile_x = floor(_x / TILE_SIZE) * TILE_SIZE;
	var _width = _read_width(_tile_x, _y, _dir, _secondary_layer, _quadrant);
	
	if _width == 0 || _width == TILE_SIZE
    {
		var _tile_x_prev = _tile_x;
		var _tile_step = _dir * TILE_SIZE;
		
		if _width == 0
		{
			_tile_x += _tile_step;
		}
		else
		{
			_tile_x -= _tile_step;
		}
		
		var _width_2 = _read_width(_tile_x, _y, _dir, _secondary_layer, _quadrant);
		
		if _tile_x == _tile_x_prev - _tile_step && _width_2 == 0
		{
			_tile_x = _tile_x_prev;
		}
		else
		{
			_width = _width_2;
		}
	}
	
	if _dir > 0
	{
	    return _tile_x + TILE_SIZE - _width - _x;
	}
	else
	{
	    return _x - _tile_x - _width + 1;
	}
}

function _read_width(_x, _y, _dir, _secondary_layer, _quadrant)
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
	var _width_data = global.tile_widths[? _tileset][? _index];
	
	if _width_data == undefined
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
		
	if !_is_valid
	{
		return 0;
	}
	
	var _width_index = _y % TILE_SIZE;
	
	if tile_get_flip(_tile)
	{
		_width_index = TILE_SIZE - 1 - _width_index;
	}
	
	return _width_data[_width_index];
}