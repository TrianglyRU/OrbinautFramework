/// @self
/// @description									Pre-calculates collision data for the tilemap associated with the specified sprite.
/// @param {Asset.GMSprite} _sprite_id				The sprite used in the tilemap.
/// @param {Array<Real>|Undefined} _raw_angle_data	An array of values representing a raw angle for each tile. Leave undefined to let the framework calculate it automatically.
/// @param {Real} _row_length						The amount of tiles in each row.
function tile_calculate_data(_sprite_id, _raw_angle_data, _row_length)
{
	var _w = sprite_get_width(_sprite_id);
	var _h = sprite_get_height(_sprite_id);
	var _surface = surface_create(_w, _h);
	
	var _tile_count = (_w / TILE_SIZE) * (_h / TILE_SIZE);
	var _height_data = ds_map_create();
	var _width_data = ds_map_create();
	var _angle_data = ds_map_create();
	var _angle_data_length = array_length(_raw_angle_data);
	
	sprite_set_offset(_sprite_id, 0, 0);
	surface_set_target(_surface);
	draw_clear_alpha(c_black, 0);
	draw_sprite(_sprite_id, 0, 0, 0);
	surface_reset_target();
	
	var _tile = instance_create(0, 0, obj_tile);
	
	for (var _i = 1; _i < _tile_count; _i++)
	{
		var _x = TILE_SIZE * (_i % _row_length);
		var _y = TILE_SIZE * floor(_i / _row_length);
		var _tile_sprite = sprite_create_from_surface(_surface, _x, _y, TILE_SIZE, TILE_SIZE, false, false, 0, 0);
		
		sprite_collision_mask(_tile_sprite, false, bboxmode_fullimage, 0, 0, TILE_SIZE, TILE_SIZE, bboxkind_precise, 0);
		
		var _height_array = array_create(TILE_SIZE);
		var _width_array = array_create(TILE_SIZE);
		var _solid_pixels = 0;
		
		with obj_tile
		{
			sprite_index = _tile_sprite;
			
			for (var _n = 0; _n < TILE_SIZE; _n++)
			{	
				for (var _m = 0; _m < TILE_SIZE; _m++)
				{
					if collision_point(x + _n, y + _m, obj_tile, true, false)
					{
						_height_array[_n]++;
						_width_array[_m]++;
						_solid_pixels++;
					}
				}
			}
		}
		
		if _solid_pixels == 0
		{
			sprite_delete(_tile_sprite);
			continue;
		}

		_height_data[? _i] = _height_array;
		_width_data[? _i] = _width_array;
		
		if _raw_angle_data != undefined
		{
			var _angle_index = _i - 1;
			
			// Force-round degree angle to the nearest angle from the 256-step raw system
			if _angle_index < _angle_data_length
			{
				_angle_data[? _i] = math_get_angle_rounded(_raw_angle_data[_angle_index]);
			}
		}
		else
		{
			#region ANGLE CALCULATION
			
			var _limit = TILE_SIZE - 1;
			
			var _top_dist_y = 0;
			var _bottom_dist_y = 0;
			var _top_dist_x = 0;
			var _bottom_dist_x = 0;
			
			var _x1 = _tile.x;
			var _y1 = _tile.y;
			var _x2 = _tile.x + _limit;
			var _y2 = _tile.y;
			var _x3 = _tile.x;
			var _y3 = _tile.y + _limit;
			var _x4 = _tile.x + _limit;
			var _y4 = _tile.y + _limit;
			
			// Move down top-left anchor
			while !collision_point(_x1, _y1, obj_tile, true, false) && _y1 < _limit
			{
				_y1++;
				_top_dist_y++;
			}
			
			// Move down top-right anchor
			while !collision_point(_x2, _y2, obj_tile, true, false) && _y2 < _limit
			{
				_y2++;
				_top_dist_y++;
			}
			
			// Align top anchors horizontally
			if _y1 < _y2
			{
				while collision_point(_x1 + 1, _y1, obj_tile, true, false) && _x1 < _limit
				{
					_x1++;
					_top_dist_x++;
				}
			
				while !collision_point(_x2, _y2, obj_tile, true, false) && _x2 > 0
				{
					_x2--;
					_top_dist_x++;
				}
			}
			else if _y1 > _y2
			{
				while !collision_point(_x1, _y1, obj_tile, true, false) && _x1 < _limit
				{
					_x1++;
					_top_dist_x++;
				}
				
				while collision_point(_x2 - 1, _y2, obj_tile, true, false) && _x2 > 0
				{
					_x2--;
					_top_dist_x++;
				}
			}
				
			// Move up bottom-left anchor
			while !collision_point(_x3, _y3, obj_tile, true, false) && _y3 > 0
			{
				_y3--;
				_bottom_dist_y++;
			}
			
			// Move up bottom-right anchor
			while !collision_point(_x4, _y4, obj_tile, true, false) && _y4 > 0
			{
				_y4--;
				_bottom_dist_y++;
			}
			
			// Align bottom anchors horizontally
			if _y3 < _y4
			{
				while !collision_point(_x3, _y3, obj_tile, true, false) && _x3 < _limit
				{
					_x3++;
					_bottom_dist_x++;
				}
			
				while collision_point(_x4 - 1, _y4, obj_tile, true, false) && _x4 > 0
				{
					_x4--;
					_bottom_dist_x++;
				}
			}
			else if _y3 > _y4
			{
				while collision_point(_x3 + 1, _y3, obj_tile, true, false) && _x3 < _limit
				{
					_x3++;
					_bottom_dist_x++;
				}
				
				while !collision_point(_x4, _y4, obj_tile, true, false) && _x4 > 0
				{
					_x4--;
					_bottom_dist_x++;
				}
			}
			
			var _is_upside_down;
			
			if _top_dist_y == _bottom_dist_y
			{
				_is_upside_down = _top_dist_x > _bottom_dist_x;
			}
			else
			{
				_is_upside_down = _bottom_dist_y > _top_dist_y;
			}
			
			var _angle;
			
			if _is_upside_down
			{
				_angle = point_direction(_x4, _y4, _x3, _y3);
			}
			else
			{
				_angle = point_direction(_x1, _y1, _x2, _y2);
			}
			
			_angle_data[? _i] = _correct_angle(_angle);
			
			#endregion
		}
		
		sprite_delete(_tile_sprite);
		
		// Detailed tile info
		// show_debug_message($"[INFO] {sprite_get_name(_sprite_id)} [{_i}]: H{_height_data[? _i]}, W{_width_data[? _i]}, A{_angle_data[? _i]}");
	}
	
	surface_free(_surface);
	instance_destroy(_tile);
	
	global.tile_heights[? _sprite_id] = _height_data;	
	global.tile_widths[? _sprite_id] = _width_data;
	global.tile_angles[? _sprite_id] = _angle_data;
	
	show_debug_message($"[INFO] Calculated collision data for {sprite_get_name(_sprite_id)}" + (_raw_angle_data != undefined ? " with predefined angle map" : ""));
}

/// @self tile_calculate_data
function _correct_angle(_angle)
{
    if _angle == 0
    {
        return 0;
    }
	
    var _increment = ANGLE_INCREMENT;
	var _range = 33.75;		// 24 * ANGLE_INCREMENT
    var _k_min = 0.5625;	// _range / 60

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