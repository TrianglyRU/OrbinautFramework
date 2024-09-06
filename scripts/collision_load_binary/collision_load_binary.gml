/// @self
/// @description Loads collision data from binary files located in `/datafiles/collision`. This function does not associate the data with any specific tilemap, so ensure you are loading data for the tilemap you are using.
/// @param {String} width_data The filename (without extension) containing width data.
/// @param {String} height_data The filename (without extension) containing height data.
/// @param {String} angle_data The filename (without extension) containing angle data.
/// @param {String} layer_a The name of the primary layer in the room.
/// @param {String} layer_b The name of the secondary layer in the room.
function collision_load_binary(_width_data, _height_data, _angle_data, _layer_a, _layer_b)
{
	var _collision = c_framework.collision;
	var _data;

	for (var k = 0; k < 3; k++)
	{
		// Determine which data set to process based on the loop index
		switch k
		{
			case 0:
				_data = _width_data;
			break;
		
			case 1:
				_data = _height_data;
			break;
		
			case 2:
				_data = _angle_data;
			break;
		}

		var _file_name = $"collision/{_data}.bin";
		var _file = file_bin_open(_file_name, 0);	
		var _size = file_bin_size(_file);

		// Continue to the next data set if the file is not found
		if !_file
		{
			continue;
		}

		// Read and assign the collision data from the binary file
		for (var i = 0; i < ENGINE_TILE_COUNT; i++) 
		{
			switch _data
			{
				case _width_data:
				
					for (var j = 0; j < ENGINE_TILE_SIZE; j++) 
					{
						_collision.tile_width[i][j] = i * ENGINE_TILE_SIZE < _size ? file_bin_read_byte(_file) : 0;	 
					}
					
				break;
			
				case _height_data:
				
					for (var j = 0; j < ENGINE_TILE_SIZE; j++) 
					{
						_collision.tile_height[i][j] = i * ENGINE_TILE_SIZE < _size ? file_bin_read_byte(_file) : 0;
					}
					
				break;
			
				case _angle_data:
					_collision.tile_angle[i] = i < _size ? math_get_angle_degree(file_bin_read_byte(_file)) : 0;
				break;
			}
		}

		file_bin_close(_file);									 
	}

	// Set the tile layers for collision
	_collision.tile_layer =
	[
		layer_tilemap_get_id(_layer_a), 
		layer_tilemap_get_id(_layer_b)
	];
}
