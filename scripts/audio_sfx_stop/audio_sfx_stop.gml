/// @function audio_sfx_stop(soundID)
function audio_sfx_stop(soundID)
{	
	// Stop the sound if it is playing
	if audio_is_playing(soundID)
	{	
		audio_stop_sound(soundID);
	}
}