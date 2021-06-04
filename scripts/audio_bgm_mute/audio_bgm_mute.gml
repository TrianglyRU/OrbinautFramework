/// @function audio_bgm_mute(musicID, fadeTime)
function audio_bgm_mute(musicID, fadeTime)
{
	// Get the volume step
	var volumeStep = Game.MusicVolume / (fadeTime * 60);
	
	// Set the target volume
	var volumeLevel = max(audio_sound_get_gain(musicID) - volumeStep, 0);
	
	// Update BGM volume
	audio_sound_gain(musicID, volumeLevel, 0);	
}