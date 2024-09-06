/// @self
/// @description Starts playing BGM on the specified channel. If the same BGM is already playing on the channel, no action is taken. 
/// @param {Asset.GMSound} sound_id The sound asset to be played as BGM.
/// @param {Real} [channel_index] The index of the channel_index (optional, defaults to 0).
/// @returns {Id.Sound}
function audio_play_bgm(_sound_id, _channel_index = 0)
{
	var _audio = c_framework.audio;
	var _current_bgm = _audio.current_bgm[_channel_index];
	var _state = _audio.channel_state[_channel_index];
	var _gain_buffer = 1.0;
	var _do_loop = array_contains(_audio.loop_array, _sound_id);

	// Handle audio channel state based on current state and BGM
	if _state == ENGINE_AUDIO_STATE_STOP
	{
		if _audio.current_bgm[AUDIO_CHANNEL_JINGLE] != -1
		{
			_audio.channel_state[_channel_index] = ENGINE_AUDIO_STATE_MUTE_BY_JINGLE;
			_gain_buffer = 0;
		}
		else
		{
			_audio.channel_state[_channel_index] = ENGINE_AUDIO_STATE_DEFAULT;
		}
	}
	else if _current_bgm != -1
	{
		_gain_buffer = audio_sound_get_gain(_current_bgm);
	}

	// Stop current sound and play new sound
	audio_stop_sound(_current_bgm);
	_audio.current_bgm[_channel_index] = audio_play_sound_on(_audio.emitter_bgm[_channel_index], _sound_id, _do_loop, 0, _gain_buffer);

	return _audio.current_bgm[_channel_index];
}
