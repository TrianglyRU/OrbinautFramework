/// @self
/// @description						Plays BGM on the specified channel if not already playing.
/// @param {Asset.GMSound} _sound_id	The sound asset to play.
/// @param {Real} [_index]				The channel index (default is 0).
/// @returns {Id.Sound}
function audio_bgm_play(_sound_id, _index = 0)
{
	var _do_loop = ds_list_find_index(global.looped_bgm, _sound_id) != -1; 
	
	var _channel_state = obj_game.audio_channel_states;
	var _bgm = obj_game.audio_channel_bgms;
	
    if _channel_state[_index] == CHANNEL_STATE.STOP
    {
        if _bgm[AUDIO_CHANNEL_JINGLE] == undefined
        {
            _channel_state[_index] = CHANNEL_STATE.DEFAULT;
        }
        else
        {
            _channel_state[_index] = CHANNEL_STATE.TEMP_MUTE;
        }
    }
	
	var _current_bgm = _bgm[_index];
	
	if _current_bgm != undefined
	{
		audio_stop_sound(_current_bgm);
	}
	
	var _gain = _channel_state[_index] == CHANNEL_STATE.TEMP_MUTE ? 0 : 1;
	var _emitter = obj_game.audio_emitter_bgm[_index];
	
	if _sound_id != undefined
	{
		_bgm[_index] = audio_play_sound_on(_emitter, _sound_id, _do_loop, 0, _gain);
	}
   
    return _bgm[_index];
}