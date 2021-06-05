/// @function audio_bgm_mute(musicID, fadeTime)
function audio_bgm_mute(musicID, fadeTime)
{
	// Get the volume step
	var VolumeStep = Game.MusicVolume / (fadeTime * 60);
	
	// Set the target volume
	var VolumeLevel = max(audio_sound_get_gain(musicID) - VolumeStep, 0);
	
	// Update BGM volume
	audio_sound_gain(musicID, VolumeLevel, 0);	
}