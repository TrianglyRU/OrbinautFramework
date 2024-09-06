// Disable the shader
if global.gfx_enabled
{
    shader_reset();
}

// DEBUG

if !global.dev_mode
{
	exit;
}

var _list_size, _list;
var _collision = collision;

switch global.debug_collision
{
	// Draw collision sensors
	case 1:
	
		_list = _collision.ds_sensors;
		_list_size = ds_list_size(_list);
		
		if _list_size == 0
		{
			break;
		}
		
		for (var i = 0; i < _list_size; i += 5)
		{
			var _line_col1 = _list[| i + 4];
			var _line_col2 = make_colour_hsv(colour_get_hue(_line_col1), colour_get_saturation(_line_col1) - 128, 255);
			
			draw_line_floored(_list[| i], _list[| i + 1], _list[| i + 2], _list[| i + 3], _line_col1, _line_col2);
		}
		
	break;
	
	// Draw hitboxes
	case 2:
	
		_list = _collision.ds_interact;
		_list_size = ds_list_size(_list);
		
		if _list_size == 0
		{
			break;
		}
		
		draw_set_alpha(0.5);
		
		for (var i = 0; i < _list_size; i += 6)
		{
			draw_rect_floored(_list[| i], _list[| i + 1], _list[| i + 2], _list[| i + 3], false, _list[| i + 4]);
		}
		
		draw_set_alpha(1.0);
		
	break;
	
	case 3:
		
		// Draw solids
		_list = _collision.ds_solid_size;
		_list_size = ds_list_size(_list);
		
		if _list_size == 0
		{
			break;
		}
		
		draw_set_alpha(0.75);
		
		for (var i = 0; i < _list_size; i += 6)
		{
			draw_rect_floored(_list[| i], _list[| i + 1], _list[| i + 2], _list[| i + 3], true, _list[| i + 4]);
		}
		
		// Draw solid checks
		_list = _collision.ds_solid_side;
		_list_size = ds_list_size(_list);
		
		if _list_size == 0
		{
			draw_set_alpha(1.0);
			break;
		}
		
		draw_set_alpha(0.5);
		
		for (var i = 0; i < _list_size; i += 6)
		{
			draw_rect_floored(_list[| i], _list[| i + 1], _list[| i + 2], _list[| i + 3], false, _list[| i + 4]);
		}
		
		// Draw push checks
		_list = _collision.ds_solid_push;
		_list_size = ds_list_size(_list);
		
		if _list_size == 0
		{
			draw_set_alpha(1.0);
			break;
		}
		
		for (var i = 0; i < _list_size; i += 10)
		{
			draw_rect_floored(_list[| i], _list[| i + 1], _list[| i + 2], _list[| i + 3], false, _list[| i + 8]);
			draw_rect_floored(_list[| i + 4], _list[| i + 5], _list[| i + 6], _list[| i + 7], false, _list[| i + 8]);
		}
		
		draw_set_alpha(1.0);
		
	break;
}

// Clear debug collision lists
ds_list_clear(_collision.ds_sensors);
ds_list_clear(_collision.ds_interact);
ds_list_clear(_collision.ds_solid_side);
ds_list_clear(_collision.ds_solid_size);
ds_list_clear(_collision.ds_solid_push);

if global.debug_collision > 0
{
	with c_object 
	{
		draw_point_floored(x, y, c_white);
	}
}