/// @self
/// @description					Initialises a background parallax effect. This function requires the assigned sprite to have "Separate Texture Page" enabled, and the sprite's width must be a power of two.
/// @param {String} _layer			The name of the background layer to apply parallax for.
/// @param {Real} _factor_x			Horizontal parallax factor.
/// @param {Real} _factor_y			Vertical parallax factor.
/// @param {Real} _scroll_x			Horizontal scrolling speed multiplier. The scroll is applied to the perspective itself and requires that _line_factor_x is not less than _factor_x.
/// @param {Real} _scroll_y			Vertical scrolling speed multiplier.
/// @param {Real} _line_factor_x	Target horizontal parallax factor at the bottom of the layer. Used to create a pseudo-3D effect by progressively changing the scroll factor per line.
/// @param {Real} _line_height		Height of each scrolling line in pixels. Set to 0 to disable.
/// @param {Real} _scale_target_y	Y position to scale the layer's bottom to. Set to a negative value to disable. If _factor_y is 0, the console will suggest a value for _factor_y. 
/// @param {Real} _frame_duration	Duration of each animation frame in game steps.
function bg_parallax_scaled(_layer, _factor_x, _factor_y, _scroll_x, _scroll_y, _line_factor_x, _line_height, _scale_target_y, _frame_duration)
{
	var _bg_layer_id = layer_background_get_id(_layer);
	var _sprite_id = layer_background_get_sprite(_bg_layer_id);
	var _height = sprite_get_height(_sprite_id);
	var _texture = sprite_get_texture(_sprite_id, 0)
	
	obj_game.bg_data[? _layer] =
	{
		base_x: layer_get_x(_layer),
		base_y: layer_get_y(_layer),
		bg_layer_id: layer_background_get_id(_layer),
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
		prev_shader: -1,
	}
	
	var _params = obj_game.bg_data[? _layer];
	
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
		var _scale_y;
		
		if scale_target_y != -1
		{
		    _scale_y = clamp((scale_target_y - _draw_y) / height, -1, 1);
		}
		else
		{
		    _scale_y = 1;
		}
		
	    layer_x(layer_id, _draw_x);
	    layer_y(layer_id, _draw_y);
		layer_background_yscale(bg_layer_id, _scale_y);
		
		if line_height <= 0
		{
			return;
		}
		
		if !surface_exists(obj_game.bg_surface) 
		{
			obj_game.bg_surface = surface_create(2, 2);
		}
		
		if surface_get_width(obj_game.bg_surface) != _rw || surface_get_height(obj_game.bg_surface) != _rh
		{
			surface_resize(obj_game.bg_surface, _rw, _rh);
		}
		
		prev_shader = shader_current();
		
		surface_set_target(obj_game.bg_surface);
		draw_clear_alpha(c_white, 0);
	
		// Views the same room area as the camera (draw in room coordinates)
		camera_apply(_c);
		shader_reset();
		shader_line_scroll(_cx, _draw_x, _draw_y, height, _scale_y, texture, line_factor_x - factor_x, line_height);
	}));
	
	layer_script_end(_layer, method(_params, function()
	{
		if event_type != ev_draw || event_number != ev_draw_normal
	    {
			return;
		}
		
		if line_height <= 0
		{
			return;
		}
		
		var _c = view_camera[view_current];
		
		shader_reset();
		surface_reset_target();
		
		if prev_shader != -1
		{
			shader_set(prev_shader);
		}
		
		draw_surface(obj_game.bg_surface, camera_get_view_x(_c), camera_get_view_y(_c));
	}));
}