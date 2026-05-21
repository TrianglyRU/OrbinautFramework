/// @self
/// @description					Initialises a background parallax object with scaling effects, replacing the specified layer. This function requires the assigned sprite to have "Separate Texture Page" enabled, and the sprite's width must be a power of two.
/// @param {String} _layer			The name of the background layer to convert into an object.
/// @param {Real} _factor_x			Horizontal parallax factor.
/// @param {Real} _factor_y			Vertical parallax factor.
/// @param {Real} _scroll_x			Horizontal scrolling speed multiplier. The scroll is applied to the perspective itself and requires that _line_factor_x is not less than _factor_x.
/// @param {Real} _scroll_y			Vertical scrolling speed multiplier.
/// @param {Real} _line_factor_x	Target horizontal parallax factor at the bottom of the layer. Used to create a pseudo-3D effect by progressively changing the scroll factor per line.
/// @param {Real} _line_height		Height of each scrolling line in pixels. Set to a negative value to disable the line scroll effect.
/// @param {Real} _scale_target_y	Y position to scale the layer's bottom to. Set to a negative value to disable. If _factor_y is 0, the console will suggest a value for _factor_y. 
/// @param {Real} _frame_duration	Duration of each animation frame in game steps.
/// @returns {Id.Instance}
function bg_convert_scaled(_layer, _factor_x, _factor_y, _scroll_x, _scroll_y, _line_factor_x, _line_height, _scale_target_y, _frame_duration)
{
	var _object = bg_convert(_layer, _factor_x, _factor_y, _scroll_x, _scroll_y, _frame_duration);
	
	if _object != noone
	{
		_object.line_factor_x = _line_factor_x;
	    _object.line_height = _line_height;
		_object.scale_target_y = _scale_target_y;
		_object.scale_target_y_init = _scale_target_y;
	}
	
	return _object;
}