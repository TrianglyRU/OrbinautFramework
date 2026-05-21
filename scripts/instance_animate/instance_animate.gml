/// @self
/// @description					Plays the animation for the instance, directly updating the image_index based on the current timer value and the frame duration.
/// @param {Real} _timer			The timer value.
/// @param {Real} _duration			The duration of one frame of the animation, in game steps.
/// @param {ID.Instance} _inst_id	The instance to animate (default is the calling instance).
function instance_animate(_timer, _duration, _inst_id = id)
{
	_inst_id.image_index = floor(_timer / _duration) % _inst_id.image_number;
}