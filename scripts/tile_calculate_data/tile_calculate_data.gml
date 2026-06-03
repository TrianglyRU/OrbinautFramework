/// @self
/// @description						Pre-calculates collision data for the tilemap associated with the specified sprite.
/// @param {Asset.GMTileset} _tileset	The tileset to calculate data for.
/// @param {Asset.GMSprite}  _sprite_id	The sprite used in the tileset to calculate data with.
/// @param {Array<Real>} _angle_map		Angle mapping array (default is empty array). Flat [angle, ...] assigns angles by position, nested [[tile, angle], ...] assigns explicit tile/angle pairs. Unspecified tiles are calculated at runtime.
function tile_calculate_data(_tileset, _sprite_id, _angle_map = [])
{
	sprite_set_offset(_sprite_id, 0, 0);
	
	var _height_data = ds_map_create();
	var _width_data = ds_map_create();
	var _angle_data = ds_map_create();
	
	var _w = sprite_get_width(_sprite_id);
	var _h = sprite_get_height(_sprite_id);
	
	var _rows = (_w / TILE_SIZE);
	var _columns = (_h / TILE_SIZE);
	var _tile_count = _rows * _columns;
	
	// Render tilemap sprite to a surface and cache its pixels (R G B A) in a buffer for fast alpha sampling
	var _surface = surface_create(_w, _h);
	var _buffer = buffer_create(_w * _h * 4, buffer_fixed, 1);
	
	surface_set_target(_surface);
	draw_clear_alpha(c_black, 0);
	draw_sprite(_sprite_id, 0, 0, 0);
	surface_reset_target();
	buffer_get_surface(_buffer, _surface, 0);
	surface_free(_surface);

	for (var _i = 1; _i < _tile_count; _i++)
	{
		var _x = TILE_SIZE * (_i % _rows);
		var _y = TILE_SIZE * floor(_i / _rows);
		
		var _height_array = array_create(TILE_SIZE);
		var _width_array = array_create(TILE_SIZE);
		var _solid_pixels = 0;
		
		for (var _m = 0; _m < TILE_SIZE; _m++)
		{
		    var _py = _y + _m;
		    var _offset = (_py * _w + _x) * 4;

		    for (var _n = 0; _n < TILE_SIZE; _n++)
		    {
		        if buffer_peek(_buffer, _offset + 3, buffer_u8) > 0
		        {
		            _height_array[_n]++;
		            _width_array[_m]++;
					_solid_pixels++;
		        }

		        _offset += 4;
		    }
		}
		
		if _solid_pixels != 0
		{
			_height_data[? _i] = _height_array;
			_width_data[? _i] = _width_array;
		}
	}
	
	buffer_delete(_buffer);
	
	var _entries = array_length(_angle_map);
	
	if _entries > 0
	{
		// Nested
		if is_array(_angle_map[0]) 
		{
			for (var _i = 0; _i < _entries; _i++)
			{
				_angle_data[? _angle_map[_i][0]] = math_get_angle_rounded(_angle_map[_i][1]);
			}
			
		}
		
		// Flat
		else for (var _i = 0; _i < _entries; _i++)
		{
			_angle_data[? _i + 1] = math_get_angle_rounded(_angle_map[_i]);
		}
	}
	
	global.tile_heights[? _tileset] = _height_data;	
	global.tile_widths[? _tileset] = _width_data;
	global.tile_angles[? _tileset] = _angle_data;
}

/// @self tile_calculate_data
function _correct_angle(_angle)
{
    if _angle == 0
    {
        return 0;
    }
	
    var _increment = ANGLE_INCREMENT;
	var _range = 28.125;
    var _k_min = 0.5625;
	
    if _angle <= _range
    {
        var _t = _angle / _range;
        var _t2 = _t * _t;
        var _k = _k_min + (1.0 - _k_min) * _t2;

        return round(_angle * _k / _increment) * _increment;
    }
    else if _angle >= 360 - _range
    {
        var _mirror = 360 - _angle;
		
        var _t = _mirror / _range;
        var _t2 = _t * _t;
        var _k = _k_min + (1.0 - _k_min) * _t2;

        return 360 - round(_mirror * _k / _increment) * _increment;
    }

    return round(_angle / _increment) * _increment;
}