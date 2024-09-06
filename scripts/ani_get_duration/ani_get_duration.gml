/// @self c_object
/// @description Returns the duration of the current animation frame of the object, in game steps.
/// @returns {Real}
function ani_get_duration()
{
	var _data_ani = data_ani;
	
	return is_array(_data_ani.duration) ? _data_ani.duration[_data_ani.index] : _data_ani.duration;
}
