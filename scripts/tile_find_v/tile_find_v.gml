/// @self
/// @description Finds a tile along a vertical axis at the given position within a specified tile layer and returns an array containing two values: the distance to the tile's edge and its angle.
/// @param {Real} x The x-coordinate of the position.
/// @param {Real} y The y-coordinate of the position.
/// @param {Enum.DIRECTION} dir The direction in which to perform the search.
/// @param {Enum.TILELAYER} layer The index of the tile layer to search within.
/// @param {Enum.TILEBEHAVIOUR} [behaviour] The behaviour type of the tile (optional, defaults to DEFAULT).
/// @returns {Array<Real>}
function tile_find_v(_x, _y, _dir, _layer, _behaviour = TILEBEHAVIOUR.DEFAULT)
{
	var _collision = c_framework.collision;
	
	if array_length(_collision.tile_layer) == 0 || _layer == TILELAYER.NONE
	{
		return [ENGINE_TILE_SIZE * 2, ANGLE_EMPTY];
	}

	_x = floor(_x);
	_y = floor(_y);
	
	if _x < 0 || _x > room_width
	{
		return [ENGINE_TILE_SIZE * 2, ANGLE_EMPTY];
	}

	_layer = _collision.tile_layer[_layer];
	
	// Visualise collision if debugging
	if global.debug_collision == 1
	{
		ds_list_add(_collision.ds_sensors, _x, _y, _x, y, (_dir == DIRECTION.POSITIVE) ? $47EC6D : $E9AB4D);
	}

	// Initialise tile variables and iterate to find tile
	var _cell_id_x = floor(_x / ENGINE_TILE_SIZE);
	var _cell_id_y = floor(_y / ENGINE_TILE_SIZE);
	var _tiledata, _index, _height, _is_valid, _tile_buffer, _index_buffer, _height_buffer;

	for (var i = 0; i <= 2; i++)
	{
		_tiledata = tilemap_get(_layer, _cell_id_x, _cell_id_y);
		_index = tile_get_index(_tiledata);
		_height = tile_get_height(_tiledata, _x);
		_is_valid = tile_get_validity_v(_tiledata, _dir, _behaviour);
		
		// Initial tile check
		if i == 0
		{
			if _height == 0 || !_is_valid
			{
				_cell_id_y += _dir;
			}
			else if _height == ENGINE_TILE_SIZE
			{
				_tile_buffer = _tiledata;
				_index_buffer = _index;
				_height_buffer = _height;
				_cell_id_y -= _dir;
				
				// This will set i to 2
				i++;
			}
			else
			{
				break;
			}
		}
		
		// Further tile check
		else if i == 1
		{
			if !_is_valid
			{
				return [ENGINE_TILE_SIZE * 2, ANGLE_EMPTY];
			}
			
			break;
		}
		
		// Closer tile check
		else if i == 2 && (_height == 0 || !_is_valid)
		{
			_tiledata = _tile_buffer;
			_index = _index_buffer;
			_height = _height_buffer;
			_cell_id_y += _dir;
			
			break;
		}
	}

	// Calculate final distance and angle
	var _flip = tile_get_flip(_tiledata);
	var _mirror = tile_get_mirror(_tiledata);
	var _ang = tile_get_angle(_tiledata);

	if _ang != ANGLE_EMPTY
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
		}
		else
		{
			_ang = _dir == DIRECTION.POSITIVE ? 0 : 180;
			
			if _dir == _flip
			{
				_height = ENGINE_TILE_SIZE;
			}
		}
	}

	var _distance;
	
	if _dir == DIRECTION.POSITIVE
	{
		_distance = _cell_id_y * ENGINE_TILE_SIZE + ENGINE_TILE_SIZE - 1 - _height - _y;
	}
	else
	{
		_distance = _y - _cell_id_y * ENGINE_TILE_SIZE - _height;
	}

	return [_distance, _ang];
}