/// @function audio_sfx_stop(soundid)
function audio_sfx_stop(soundid)
{	
	// Stop sound
	if audio_sfx_is_playing(soundid)
	{	
		audio_stop_sound(soundid);
	}
}