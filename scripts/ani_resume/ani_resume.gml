/// @self c_object
/// @description Resumes playback of the object's current animation from the current frame, resetting the frame timer to its default value.
function ani_resume()
{
	data_ani.timer = ani_get_duration();
}
