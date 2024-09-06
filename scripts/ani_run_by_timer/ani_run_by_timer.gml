/// @description Plays the animation for the object without using the Animator module, directly updating the object's `image_index` based on the current timer value and the frame duration.
/// @param {Real} timer The timer value.
/// @param {Real} duration The duration of one frame of the animation, in game steps.
function ani_run_by_timer(_timer, _duration)
{
	image_index = floor(_timer / _duration) % image_number;
}
