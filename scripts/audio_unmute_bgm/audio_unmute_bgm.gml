/// @self
/// @description Unmutes the BGM on the specified channel, gradually increasing the volume back to the standard level.
/// @param {Real} time The duration over which the volume will be increased to the standard level, in seconds.
/// @param {Real} [channel] The ID of the channel (optional, defaults to 0).
function audio_unmute_bgm(_time, _channel_id = 0)
{
	var _audio = c_framework.audio;
	
	if _audio.current_bgm[_channel_id] != -1
	{
		_audio.channel_state[_channel_id] = ENGINE_AUDIO_STATE_DEFAULT;
		audio_sound_gain(_audio.current_bgm[_channel_id], 1, _time * 1000);
	}
}
