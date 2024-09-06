/// @self
/// @description Stops the BGM on the specified channel, fading out the volume over a given duration.
/// @param {Real} time The duration over which the volume will decrease to 0, in seconds.
/// @param {Real} [channel_id] The ID of the channel (optional, defaults to 0).
function audio_stop_bgm(_time, _channel_id = 0)
{
	var _audio = c_framework.audio;
	
	if _audio.current_bgm[_channel_id] != -1
	{
		_audio.channel_state[_channel_id] = ENGINE_AUDIO_STATE_STOP;
		audio_sound_gain(_audio.current_bgm[_channel_id], 0, _time * 1000);
	}
}