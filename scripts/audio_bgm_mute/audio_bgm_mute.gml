/// @function audio_bgm_mute(musicID, fadeTime)
function audio_bgm_mute(musicID, fadeTime)
{
	// Get volume step
	var volumeStep = Game.MusicVolume / (fadeTime * 60);
	
	// Set target volume
	var volumeLevel = max(audio_sound_get_gain(musicID) - volumeStep, 0);
	
	// Fade volume
	audio_sound_gain(musicID, volumeLevel, 0);	
}