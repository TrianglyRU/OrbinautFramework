/// @function sound_bgm_fadein(musicID, fadeTime)
function sound_bgm_fadein(musicID, fadeTime)
{
	// Fade back to music volume if it is not on this volume level
	if audio_sound_get_gain(musicID) != Game.MusicVolume
	{
		audio_sound_gain(musicID, Game.MusicVolume, fadeTime * 100);
	}
}