function stop_sound(soundID)
{
	if audio_is_playing(soundID)
	{
		audio_stop_sound(soundID);
	}
}