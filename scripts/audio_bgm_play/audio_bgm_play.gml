/// @function audio_bgm_play(musicID, endAt, returnTo)
function audio_bgm_play(musicID, endAt, returnTo)
{	
	// Exit the code if BGM volume is 0
	if Game.MusicVolume == 0
	{
		exit;
	}
	// Play the BGM and assign its ID to a variable to loop it
	if !audio_is_playing(musicID)
	{
		id.CurrentBGM = audio_play_sound(musicID, 0, false);
		exit;
	}
	else
	{
		var MusicLength = audio_sound_length(musicID);
		if endAt != -1
		{
			if audio_sound_get_track_position(id.CurrentBGM) >= endAt
			{
				if returnTo != -1
				{
					audio_sound_set_track_position(id.CurrentBGM, returnTo);
				}
				else
				{
					audio_pause_sound(musicID);
				}
			}
		}
		else if audio_sound_get_track_position(id.CurrentBGM) >= MusicLength
		{
			audio_pause_sound(musicID);;
		}
	}
}