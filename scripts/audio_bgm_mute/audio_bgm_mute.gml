/// @function audio_bgm_fadeout(musicID, fadeTime)
function audio_bgm_fadeout(musicID, fadeTime)
{
	// Get volume step
	var volumeStep = Game.MusicVolume / (fadeTime * 60);
	
	// Fade to 0
	var volumeLevel = max(audio_sound_get_gain(musicID) - volumeStep, 0);
	audio_sound_gain(musicID, volumeLevel, 0);	
}