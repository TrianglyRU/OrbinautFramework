/// @self scr_fw_collision_setup
/// @description Generates collision data for the tilemap associated with the specified sprite.
/// @param {Asset.GMSprite} sprite_id The sprite used in the tilemap.
/// @param {Array<Real>} angle_data An array of values representing the angles for each tile.
/// @param {Real} off_x The horizontal offset of the sprite on the tilemap.
/// @param {Real} off_y The vertical offset of the sprite on the tilemap.
/// @param {Real} sep_x The horizontal spacing between tiles on the tilemap.
/// @param {Real} sep_y The vertical spacing between tiles on the tilemap.
function collision_generate(_sprite_id, _angle_data, _off_x = 0, _off_y = 0, _sep_x = 0, _sep_y = 0)
{
    // Initialise arrays and variables for collision data
	var _height_arr = array_create(ENGINE_TILE_COUNT, 0);
	var _width_arr = array_create(ENGINE_TILE_COUNT, 0);
	var _angle_arr = array_create(ENGINE_TILE_COUNT, 0);
	var _angle_data_length = array_length(_angle_data);
	var _xcell_size = ENGINE_TILE_SIZE + _sep_x;
	var _ycell_size = ENGINE_TILE_SIZE + _sep_y;

	// Set up the sprite and create the surface
	sprite_set_offset(_sprite_id, 0, 0);
	instance_create(0, 0, obj_tile);
	
	var _surface = surface_create(sprite_get_width(_sprite_id), sprite_get_height(_sprite_id));
	surface_set_target(_surface);
	draw_clear_alpha(c_black, 0);
	draw_sprite(_sprite_id, 0, 0, 0);
	surface_reset_target();

	// Initialise the first tile's height and width arrays
	for (var j = 0; j < ENGINE_TILE_SIZE; j++)
	{
		_height_arr[0][j] = 0;
		_width_arr[0][j] = 0;
	}
	
	_angle_arr[0] = 0;
	
	// Generate collision data for each tile
	for (var i = 1; i < ENGINE_TILE_COUNT; i++)
	{
		var _tile = sprite_create_from_surface
		(
			_surface, _off_x + _xcell_size * (i % ENGINE_TILE_SIZE), _off_y + _ycell_size * floor(i / ENGINE_TILE_SIZE), ENGINE_TILE_SIZE, ENGINE_TILE_SIZE, false, false, 0, 0
		);

		_height_arr[i] = array_create(ENGINE_TILE_SIZE);
		_width_arr[i] = array_create(ENGINE_TILE_SIZE);

		sprite_collision_mask(_tile, true, 1, 0, 0, 0, 0, 0, 0);
		obj_tile.sprite_index = _tile;

		for (var m = 0; m < ENGINE_TILE_SIZE; m++)
		{	
			for (var n = 0; n < ENGINE_TILE_SIZE; n++)
			{
				if collision_point(obj_tile.x + m, obj_tile.y + n, obj_tile, true, false)
				{
					_height_arr[i][m]++;
					_width_arr[i][n]++;
				}
			}
		}

		sprite_delete(_tile);
	}
	
	// Set angle data based on input array or default to zero
	if _angle_data_length == 0
	{
		for (var i = 1; i < ENGINE_TILE_COUNT; i++)
		{
			_angle_arr[i] = 0;
		}
	}
	else
	{
		var i = 1;
		
		for (; i <= _angle_data_length; i++)
		{
			_angle_arr[i] = math_get_angle_degree(_angle_data[i - 1]);
		}
		
		for (; i < ENGINE_TILE_COUNT; i++)
		{
			_angle_arr[i] = 0;
		}
	}
		
	// Clean up
	surface_free(_surface);
	instance_destroy(obj_tile);
	
	// Store the generated data
	if !global.tools_binary_collision
	{
		global.generated_tile_height_data[? _sprite_id] = _height_arr;
		global.generated_tile_width_data[? _sprite_id] = _width_arr;
		global.generated_tile_angle_data[? _sprite_id] = _angle_arr;
	}
	
	// Save the generated data into the binary format
	else
	{
		var _prefix = sprite_get_name(_sprite_id);
		
		show_debug_message(
		"=============================================================================================================\n"
		+ $"GENERATED COLLISION FOR {_prefix} IS SAVED INTO THE BINARY FILES. IT IS NOT REGISTERED IN THE GAME!\n"
		+ "============================================================================================================="
		);
		
	    var _width_filename = _prefix + "_widths.bin";
	    var _height_filename = _prefix + "_heights.bin";
	    var _angle_filename = _prefix + "_angles.bin";
		
	    var _width_file = file_bin_open(_width_filename, 1);
		
	    // Write width data
	    for (var i = 0; i < ENGINE_TILE_COUNT; i++)
	    {
	        for (var j = 0; j < ENGINE_TILE_SIZE; j++)
	        {
	            file_bin_write_byte(_width_file, _width_arr[i][j]);
	        }
	    }
    
	    file_bin_close(_width_file);
		
	    var _height_file = file_bin_open(_height_filename, 1);
    
	    // Write height data
	    for (var i = 0; i < ENGINE_TILE_COUNT; i++)
	    {
	        for (var j = 0; j < ENGINE_TILE_SIZE; j++)
	        {
	            file_bin_write_byte(_height_file, _height_arr[i][j]);
	        }
	    }
		
	    file_bin_close(_height_file);
    
	    var _angle_file = file_bin_open(_angle_filename, 1);
		
	    // Write angle data
		for (var i = 0; i < ENGINE_TILE_COUNT; i++)
		{
		    file_bin_write_byte(_angle_file, math_get_angle_raw(_angle_arr[i]));
		}
		
	    file_bin_close(_angle_file);
	}
}