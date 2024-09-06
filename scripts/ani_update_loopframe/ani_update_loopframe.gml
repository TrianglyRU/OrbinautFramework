/// @self c_object
/// @description Updates the index of the frame to which the object's current animation will loop back after playing the last frame in the sequence.
/// @param {Real} loop_frame The index of the frame to which the animation will return after playing the last frame. If a custom sequence is used, this will be the index of the frame in that sequence.
function ani_update_loopframe(_loop_frame)
{
	var _data_ani = data_ani;
	
	if _data_ani.loopframe != undefined
	{
		_data_ani.loopframe = _loop_frame;
	}
}
