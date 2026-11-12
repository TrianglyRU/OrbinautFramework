/// @self
/// @description					Initialises a simple background parallax effect.
/// @param {String} _layer			The name of the background layer to apply parallax for.
/// @param {Real} _factor_x			Horizontal parallax factor.
/// @param {Real} _factor_y			Vertical parallax factor.
/// @param {Real} _scroll_x			Horizontal scrolling speed multiplier.
/// @param {Real} _scroll_y			Vertical scrolling speed multiplier.
/// @param {Real} _frame_duration	Duration of each animation frame in game steps.
function bg_parallax(_layer, _factor_x, _factor_y, _scroll_x, _scroll_y, _frame_duration)
{
	// If you want the vertical scrolling to perfectly align the background's bottom edge with the room's bottom edge,
	// use the following formula to calculate factor_y:
	// (background height - camera height) / (room height - camera height)
	
	obj_game.bg_data[? _layer] =
	{
		base_x: layer_get_x(_layer),
		base_y: layer_get_y(_layer),
		bg_layer_id: layer_background_get_id(_layer),
	    factor_x: _factor_x,
	    factor_y: _factor_y,
		scroll_mult_x: _scroll_x,
		scroll_mult_y: _scroll_y,
		layer_id: _layer
	};
	
	var _params = obj_game.bg_data[? _layer];
	
	layer_script_begin(_layer, method(_params, function()
	{
		if event_type != ev_draw || event_number != ev_draw_normal
	    {
			return;
		}
		
		var _cx = camera_get_x(view_current);
		var _cy = camera_get_y(view_current);
		
		var _draw_x = floor((_cx + obj_game.bg_distance_x) * (1 - factor_x)) + base_x - obj_game.bg_distance_x + floor(obj_game.bg_scroll_x * scroll_mult_x);
		var _draw_y = floor((_cy + obj_game.bg_distance_y) * (1 - factor_y)) + base_y - obj_game.bg_distance_y + floor(obj_game.bg_scroll_y * scroll_mult_y);
		
	    layer_x(layer_id, _draw_x);
	    layer_y(layer_id, _draw_y);
	}));
}