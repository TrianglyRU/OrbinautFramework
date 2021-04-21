/// @function audio_bgm_play(musicID)
function audio_bgm_play(musicID)
{	
	// Play audio and assign it to loopTrack variable, so we can loop it
	if !audio_is_playing(musicID)
	{
		Game.loopTrack[musicID] = audio_play_sound(musicID, 0, false);
	}
}