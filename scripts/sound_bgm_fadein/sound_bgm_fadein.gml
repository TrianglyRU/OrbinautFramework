function sound_bgm_fadein(musicID, fadeTime)
{
	// Fade back to music volume
	audio_sound_gain(musicID, Game.MusicVolume, fadeTime * 100);
}