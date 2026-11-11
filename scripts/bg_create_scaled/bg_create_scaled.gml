function bg_create_scaled(_layer, _factor_x, _factor_y, _scroll_x, _scroll_y, _line_factor_x, _line_height, _scale_target_y, _frame_duration)
{
	var _bg_layer_id = layer_background_get_id(_layer);
	var _sprite_id = layer_background_get_sprite(_bg_layer_id);
	var _height = sprite_get_height(_sprite_id);
	var _texture = sprite_get_texture(_sprite_id, 0)
	
	var _params =
	{
		base_x: layer_get_x(_layer),
		base_y: layer_get_y(_layer),
	    factor_x: _factor_x,
	    factor_y: _factor_y,
		scroll_mult_x: _scroll_x,
		scroll_mult_y: _scroll_y,
		layer_id: _layer,
		line_factor_x: _line_factor_x,
		line_height: _line_height,
		scale_target_y: _scale_target_y,
		height: _height,
		texture: _texture,
		shader: -1,
	}
	
	layer_script_begin(_layer, method(_params, function()
	{
		if event_type != ev_draw || event_number != ev_draw_normal
	    {
			return;
		}
		
		var _c = view_camera[view_current];
		var _cx = camera_get_x(view_current);
		var _cy = camera_get_y(view_current);
		var _rw = camera_get_view_width(_c);
		var _rh = camera_get_view_height(_c);
		
		var _draw_x = floor((_cx + obj_game.bg_distance_x) * (1 - factor_x)) + base_x - obj_game.bg_distance_x + floor(obj_game.bg_scroll_x * scroll_mult_x);
		var _draw_y = floor((_cy + obj_game.bg_distance_y) * (1 - factor_y)) + base_y - obj_game.bg_distance_y + floor(obj_game.bg_scroll_y * scroll_mult_y);
		
	    layer_x(layer_id, _draw_x);
	    layer_y(layer_id, _draw_y);
		
		if !surface_exists(obj_game.bg_surface) 
		{
			obj_game.bg_surface = surface_create(2, 2);
		}
		
		if surface_get_width(obj_game.bg_surface) != _rw || surface_get_height(obj_game.bg_surface) != _rh
		{
			surface_resize(obj_game.bg_surface, _rw, _rh);
		}
		
		shader = shader_current();
		
		surface_set_target(obj_game.bg_surface);
		draw_clear_alpha(c_white, 0);
	
		// Views the same room area as the camera (draw in room coordinates)
		camera_apply(_c);
		shader_reset();
		shader_line_scroll(_cx, _draw_x, _draw_y, height, 1.0, texture, line_factor_x - factor_x, line_height);
	}));
	
	layer_script_end(_layer, method(_params, function()
	{
		if event_type != ev_draw || event_number != ev_draw_normal
	    {
			return;
		}
		
		var _c = view_camera[view_current];
		
		shader_reset();
		surface_reset_target();
		
		if shader != -1
		{
			shader_set(shader);
		}
		
		draw_surface(obj_game.bg_surface, camera_get_view_x(_c), camera_get_view_y(_c));
	}));
}