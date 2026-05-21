/// @self
/// @description					Unmutes BGM on the specified channel, gradually fading in the volume.
/// @param {Real} _fade_multiplier	Fade-in time multiplier, where 1 corresponds to a normal duration of 0.25 seconds.
/// @param {Real} [_index]			The channel index (default is 0).
function audio_bgm_unmute(_fade_multiplier, _index = 0)
{
	var _bgm_index = obj_game.audio_channel_bgms[_index];
	
    if _bgm_index != undefined
    {
        obj_game.audio_channel_states[_index] = CHANNEL_STATE.DEFAULT;
		
        audio_sound_gain(_bgm_index, 1, _fade_multiplier * 0.25 * 1000);
    }
}