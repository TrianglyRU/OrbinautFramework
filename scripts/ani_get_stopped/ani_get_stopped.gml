/// @self c_object
/// @description Checks if the playback of the object's current animation has been manually stopped.
/// @returns {Bool}
function ani_get_stopped()
{
	return data_ani.timer == -4;
}
