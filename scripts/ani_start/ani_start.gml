/// @self c_object
/// @description Registers a new animation for the object and immediately starts playing it.
/// @param {Asset.GMSprite} sprite_id The sprite asset.
/// @param {Real|Array<Real>} [duration] The duration of the frames in the object's current animation (optional, defaults to 0). Refer to ani_update_duration() function for more information.
/// @param {Real} [start_frame] The index of the starting frame of the animation. If a custom sequence is provided, this will be the index of the frame in that sequence (optional, defaults to 0).
/// @param {Real} [loop_frame] The index of the frame to which the animation will loop back after playing the last frame in the sequence. If a custom sequence is provided, this will be the index of the frame in that sequence (optional, defaults to 0).
/// @param {Array<Real>} [order] The custom frame playback sequence (optional, defaults to []).
function ani_start(_spriteid, _duration = 0, _startframe = 0, _loopframe = 0, _order = [])
{
	var _data_ani = data_ani;

	// Exit if the sprite is already playing the desired animation
	if sprite_index == _spriteid && _data_ani.index != undefined
	{
		exit;
	}

	// Set animation properties
	_data_ani.order = _order;
	_data_ani.loopframe = _loopframe;
	_data_ani.duration = _duration;
	_data_ani.index = _startframe;
	_data_ani.timer = is_array(_duration) ? _duration[_startframe] : _duration;

	// Initialise animation state
	image_speed = 0;
	sprite_index = _spriteid;
	image_index = array_length(_order) > 0 ? _order[_startframe] : _startframe;
}