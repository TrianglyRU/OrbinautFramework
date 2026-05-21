/// @self
/// @description							Plays a sound effect, stopping any current instance of the same sound asset.
/// @param {Asset.GMSound} _sound_id		The sound asset to play.
/// @param {Array<Real>|Undefined} [_loop]	The loop points for the sound (default is undefined).
/// @returns {Id.Sound}
function audio_sfx_play(_sound_id, _loop = undefined)
{   
	var _do_loop = _loop != undefined;
	
    if _do_loop
    {
        audio_sound_loop_start(_sound_id, _loop[0]);
        audio_sound_loop_end(_sound_id, _loop[1]);
    }
    
	audio_stop_sound(_sound_id);
	
    return audio_play_sound_on(obj_game.audio_emitter_sfx, _sound_id, _do_loop, 0);
}