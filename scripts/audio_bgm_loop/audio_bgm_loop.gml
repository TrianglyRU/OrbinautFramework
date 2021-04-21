/// @function audio_bgm_loop(musicID, endAt, returnTo)
function audio_bgm_loop(musicID, endAt, returnTo)
{	
	if audio_sound_get_track_position(Game.loopTrack[musicID]) > endAt
	{
		audio_sound_set_track_position(Game.loopTrack[musicID], returnTo);
	}
}