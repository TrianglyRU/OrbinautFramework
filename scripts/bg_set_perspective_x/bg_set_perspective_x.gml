/// @self
/// @description Applies a horizontal perspective effect to the most recently added background layer.
/// @param {Real} target_x The target horizontal parallax factor for the bottom edge of the layer.
/// @param {Real} line_height The height of one line of the perspective.
function bg_set_perspective_x(_target_x, _line_height)
{
	// Access the most recently added background layer's parallax data
	var _background = c_framework.background;
	var _pd = _background.parallax_data[_background.layer_count - 1];
	
	// Calculate perspective effect parameters and apply them
	_pd.field_line_step = (_target_x - _pd.factor_x) / (round(_pd.height_y / _line_height) - 1) / _target_x;
	_pd.field_line_height = _line_height;
	_pd.factor_x = _target_x;
}