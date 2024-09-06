/// @self c_object
/// @description Checks if the frame of the object's current animation has changed.
/// @returns {Bool}
function ani_get_frame_change()
{
	var _data_ani = data_ani;
	
	return _data_ani.sprite_previous == sprite_index && _data_ani.timer == ani_get_duration();
}
