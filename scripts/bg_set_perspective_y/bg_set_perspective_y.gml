/// @self
/// @description Applies a vertical perspective effect to the most recently added background layer. Only one layer with a vertical perspective is supported.
/// @param {Real} target_y The y position within the room from which the layer will be scaled.
function bg_set_perspective_y(_target_y)
{
	// Access the most recently added background layer's parallax data
	var _background = c_framework.background;
	var _index = _background.layer_count - 1;
	var _pd = _background.parallax_data[_index];
	
	// Set vertical perspective effect parameters
	_background.perspective_y_data = [_target_y, _target_y, _pd.offset_y + _pd.node_y, _index, false];
}