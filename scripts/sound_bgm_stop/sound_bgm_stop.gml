function sound_bgm_stop(musicID, fadeTime)
{	
	// Check if music is playing
	if audio_is_playing(musicID)
	{
		if !fadeTime
		{
			// Stop music if no fade time set
			audio_stop_sound(musicID);
		}
		else
		{
			// Fade to 0 if fade time set
			audio_sound_gain(musicID, 0, fadeTime * 100);
		
			// Stop music if its volume is 0
			if audio_sound_get_gain(musicID) = 0
			{
				audio_stop_sound(musicID);
			}
		}
	}
}