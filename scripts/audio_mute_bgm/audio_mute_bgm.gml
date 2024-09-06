/// @self
/// @description Mutes the BGM on the specified channel.
/// @param {Real} time The duration over which the volume will decrease to 0, in seconds.
/// @param {Real} [channel_index] The index of the channel (optional, defaults to 0).
function audio_mute_bgm(_time, _channel_index = 0)
{
	var _audio = c_framework.audio;

	if _audio.current_bgm[_channel_index] == -1
	{
		exit;
	}
	
	// Update audio channel state and set sound gain
	if _audio.channel_state[_channel_index] != ENGINE_AUDIO_STATE_MUTE_BY_JINGLE
	{
		_audio.channel_state[_channel_index] = ENGINE_AUDIO_STATE_MUTE;
	}

	audio_sound_gain(_audio.current_bgm[_channel_index], 0, _time * 1000);

}
