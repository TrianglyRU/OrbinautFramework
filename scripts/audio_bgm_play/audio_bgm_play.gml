/// @function audio_bgm_play(musicID, endAt, returnTo)
function audio_bgm_play(musicID, endAt, returnTo)
{	
	// Exit the code if BGM volume is 0
	if !Game.MusicVolume
	{
		exit;
	}
	
	// Create a special BGM loop variable
	if !variable_instance_exists(id, "Game.PlayingTrackID[musicID]")
	{
		Game.PlayingTrackID[musicID] = 0;
	}
	
	// Play the BGM and assign its ID to a variable to loop it
	if !audio_is_playing(musicID)
	{
		Game.PlayingTrackID[musicID] = audio_play_sound(musicID, 0, false);
	}
	else if returnTo != -1 and endAt != -1
	{
		if audio_sound_get_track_position(Game.PlayingTrackID[musicID]) >= endAt
		{
			audio_sound_set_track_position(Game.PlayingTrackID[musicID], returnTo);
		}
	}
	else
	{
		if audio_sound_get_track_position(Game.PlayingTrackID[musicID]) >= audio_sound_length(Game.PlayingTrackID[musicID])
		{
			audio_sound_set_track_position(Game.PlayingTrackID[musicID], audio_sound_length(Game.PlayingTrackID[musicID]));
		}
	}
}