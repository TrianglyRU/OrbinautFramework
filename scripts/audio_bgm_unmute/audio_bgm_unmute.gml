/// @function audio_bgm_fadein(musicID, fadeTime)
function audio_bgm_fadein(musicID, fadeTime)
{
	// Get volume step
	var volumeStep = Game.MusicVolume / (fadeTime * 60);
	
	// Fade back to music volume if it is not on this volume level
	var volumeLevel = min(audio_sound_get_gain(musicID) + volumeStep, Game.MusicVolume);
	audio_sound_gain(musicID, volumeLevel, 0);	
}