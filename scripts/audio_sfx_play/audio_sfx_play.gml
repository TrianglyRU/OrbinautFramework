/// @function audio_sfx_play(soundid,doloop)
function audio_sfx_play(soundid, doloop)
{	
	// Stop the sound if it is already playing
	if audio_is_playing(soundid)
	{
		audio_stop_sound(soundid);
	}	
	
	// Play the sound
	audio_play_sound(soundid, 0, doloop);
}