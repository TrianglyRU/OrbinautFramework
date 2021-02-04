/// @function sound_sfx_play(soundID, doLoop)
function sound_sfx_play(soundID, doLoop)
{	
	// Stop the sound if it is playing already
	if audio_is_playing(soundID)
	{
		audio_stop_sound(soundID);
	}	
	
	// Play the sound
	audio_play_sound(soundID, 0, doLoop);
}