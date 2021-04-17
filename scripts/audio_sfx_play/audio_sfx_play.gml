/// @function audio_sfx_play(soundID, doLoop, doInterupt)
function audio_sfx_play(soundID, doLoop, doInterupt)
{	
	// Stop the sound if it is playing already
	if audio_is_playing(soundID) and doInterupt
	{
		audio_stop_sound(soundID);
	}	
	
	// Play the sound
	audio_play_sound(soundID, 0, doLoop);
}