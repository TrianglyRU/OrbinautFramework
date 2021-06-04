/// @function audio_bgm_unmute(musicID, fadeTime)
function audio_bgm_unmute(musicID, fadeTime)
{
	// Get the volume step
	var volumeStep = Game.MusicVolume / (fadeTime * 60);
	
	// Set the target volume
	var volumeLevel = min(audio_sound_get_gain(musicID) + volumeStep, Game.MusicVolume);
	
	// Update BGM volume
	audio_sound_gain(musicID, volumeLevel, 0);	
}