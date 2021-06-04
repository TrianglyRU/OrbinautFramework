/// @function audio_bgm_stop(musicID, fadeTime)
function audio_bgm_stop(musicID, fadeTime)
{	
	// Check if the BGM is playing
	if audio_is_playing(musicID)
	{
		// Stop the BGM if no fade time is specified
		if fadeTime == 0
		{
			audio_stop_sound(musicID);
		}		
		else
		{
			// Fade out the BGM if the fade time is set and its volume is not 0
			if audio_sound_get_gain(musicID) != 0
			{	
				audio_bgm_mute(musicID, fadeTime);
			}
			
			// If BGM volume equals zero, stop it
			else
			{
				audio_stop_sound(musicID);	
			}
		}
	}
}