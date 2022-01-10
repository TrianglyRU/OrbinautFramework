/// @function audio_sfx_play(soundid,loops)
function audio_sfx_play(soundid,loops)
{	
	// Play sound
	if audio_sfx_is_playing(soundid)
	{
		audio_stop_sound(soundid);
	}
	audio_play_sound(soundid, 0, loops);	
	
	// Set its volume
	audio_sound_gain(soundid, Game.SoundVolume, 0);
}