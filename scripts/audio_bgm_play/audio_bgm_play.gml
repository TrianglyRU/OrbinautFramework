/// @function audio_bgm_play(musicID, endAt, returnTo)
function audio_bgm_play(musicID, endAt, returnTo)
{	
	// Play audio and assign it to loopTrack variable, so we can loop it
	if !audio_is_playing(musicID)
	{
		Game.loopTrack[musicID] = audio_play_sound(musicID, 0, false);
	}
	else if returnTo != -1
	{
		if audio_sound_get_track_position(Game.loopTrack[musicID]) > endAt
		{
			audio_sound_set_track_position(Game.loopTrack[musicID], returnTo);
		}
	}
}