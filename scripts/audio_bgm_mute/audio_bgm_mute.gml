/// @self
/// @description					Mutes BGM on the specified channel, fading out the volume over a duration.
/// @param {Real} _fade_multiplier	Fade-out time multiplier, where 1 corresponds to a normal duration of 0.25 seconds.
/// @param {Real} [_index]			The channel index (default is 0).
function audio_bgm_mute(_fade_multiplier, _index = 0)
{
	var _bgm_index = obj_game.audio_channel_bgms[_index];
	
    if _bgm_index != undefined
	{
		var _channel_state = obj_game.audio_channel_states;
		
		if _channel_state[_index] != CHANNEL_STATE.TEMP_MUTE
	    {
	        _channel_state[_index] = CHANNEL_STATE.MUTE;
	    }
        
	    audio_sound_gain(_bgm_index, 0, _fade_multiplier * 0.25 * 1000);
	}
}