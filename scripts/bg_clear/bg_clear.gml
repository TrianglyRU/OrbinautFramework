/// @self
/// @description Clears all current background layers with its distortion effects and optionally fills it with a new solid colour.
/// @param {Real} [colour] The colour to fill the background with. Pass `undefined` to retain the current colour (optional, defaults to undefined).
function bg_clear(_colour = undefined)
{
	var _background = c_framework.background;
	
	// Reset properties
	_background.layer_count = 0;
	_background.scroll_offset = 0;
	_background.min_factor_y = 0;
	_background.parallax_data = [];
	_background.perspective_y_data[3] = undefined;
	
	// Optionally set a new background color
	if _colour != undefined
	{
		bg_set_colour(_colour);
	}
	
	// Clear any distortion effects from the background
	dist_clear_bg();
}