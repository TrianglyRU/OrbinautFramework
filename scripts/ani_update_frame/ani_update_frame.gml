/// @self c_object
/// @description Updates the current frame index of the object's animation.
/// @param {Real} frame The new frame index of the animation. If the animation is a custom sequence, this will be the index of the frame in that sequence.
/// @param {Bool} [reset_timer] If true, resets the current frame timer to its default value (optional, defaults to true).
function ani_update_frame(_frame, _reset_timer = true)
{
	var _data_ani = data_ani;
	
	if _data_ani.index == undefined
	{
		exit;
	}

	// Update index and timer
	_data_ani.index = _frame;

	if _reset_timer
	{
		_data_ani.timer = ani_get_duration();
	}

	// Set image_index based on order or index
	image_index = array_length(_data_ani.order) > 0 ? _data_ani.order[_data_ani.index] : _data_ani.index;

}
