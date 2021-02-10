/// @function audio_bgm_fadeout(musicID, fadeTime)
function audio_bgm_fadeout(musicID, fadeTime)
{
	// Fade to 0
	audio_sound_gain(musicID, 0, fadeTime * 100);
}