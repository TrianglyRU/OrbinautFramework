/// @self
/// @description Plays a sound effect, stopping any currently playing instance of the same sound asset.
/// @param {Asset.GMSound} soundid The sound asset to be played as SFX.
/// @param {Array<Real>} [loop] An array of two values specifying the loop points of the sound, in seconds; if empty, the sound will not loop (defaults to []).
/// @returns {Id.Sound}
function audio_play_sfx(_soundid, _loop = [])
{	
	// Stop any currently playing instance of the same sound
	audio_stop_sound(_soundid);
	
	// Set up looping if specified
	var _do_loop = array_length(_loop) > 0;
	if _do_loop > 0
	{
		audio_sound_loop_start(_soundid, _loop[0]);
		audio_sound_loop_end(_soundid, _loop[1]);
	}
	
	// Play the sound effect
	return audio_play_sound_on(c_framework.audio.emitter_sfx, _soundid, _do_loop, 0);
}