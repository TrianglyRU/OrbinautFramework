function sound_bgm_play(musicID, endAt, returnTo)
{	
	// Play music
	if !audio_is_playing(musicID)
	{
		loopTrack[musicID] = audio_play_sound(musicID, 0, false);	
	}
	
	// Loop it
	else if endAt != -1 and returnTo != -1
	{
		if audio_sound_get_track_position(loopTrack[musicID]) > endAt
		{
			audio_sound_set_track_position(loopTrack[musicID], returnTo);
		}
	}
	
	if keyboard_check_pressed(vk_f7)
	{
		audio_sound_set_track_position(loopTrack[musicID], endAt - 2);
	}	
}