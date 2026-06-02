/// @self
/// @description					Stops BGM on the specified channel, fading out the volume over a duration.
/// @param {Real} _fade_multiplier	Fade-out time multiplier, where 1 corresponds to a normal duration of 0.5 seconds.
/// @param {Real} [_index]			The channel index (default is 0).
function audio_bgm_stop(_fade_multiplier, _index = 0)
{
	var _bgm_index = obj_game.audio_channel_bgms[_index];
	
    if _bgm_index != undefined
    {
		obj_game.audio_channel_states[_index] = CHANNEL_STATE.STOP;
		
        audio_sound_gain(_bgm_index, 0, _fade_multiplier * 500);
    }
}