/// @function audio_bgm_stop(musicID, fadeTime)
function audio_bgm_stop(musicID, fadeTime)
{	
	// Check if music is playing
	if audio_is_playing(musicID)
	{
		if fadeTime == 0
		{
			// Stop music if no fade time set
			audio_stop_sound(musicID);
		}
		else
		{
			// Fade to 0 if fade time set
			if audio_sound_get_gain(musicID) != 0
			{	
				audio_bgm_fadeout(musicID, fadeTime);
			}
			
			// Stop music
			else
			{
				audio_stop_sound(musicID);	
			}
		}
	}
}