/// @function audio_bgm_play(musicID, endAt, returnTo)
function audio_bgm_play(musicID, endAt, returnTo)
{	
	// Loop the track if it is playing
	if audio_is_playing(musicID)
	{
		if endAt != -1 and returnTo != -1
		{
			if audio_sound_get_track_position(Game.loopTrack[musicID]) > endAt
			{
				audio_sound_set_track_position(Game.loopTrack[musicID], returnTo);
			}
		}
	}
	
	// if not, play it
	else
	{
		Game.loopTrack[musicID] = audio_play_sound(musicID, 0, false);
	}
}