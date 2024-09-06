/// @self c_object
/// @description Updates the duration of the frames in the object's current animation. This can be provided as a single value for all frames or as an array of values representing the duration of each frame. If provided as an array, its length should match the number of frames in the asset or the number of frames in the custom playback sequence.
/// @param {Real|Array<Real>} duration The duration of one frame of the animation in game steps.
function ani_update_duration(_duration)
{
	var _data_ani = data_ani;
	
	if _data_ani.duration != undefined
	{
		_data_ani.duration = _duration;
	}
}
