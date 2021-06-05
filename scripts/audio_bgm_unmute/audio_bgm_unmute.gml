/// @function audio_bgm_unmute(musicID, fadeTime)
function audio_bgm_unmute(musicID, fadeTime)
{
	// Get the volume step
	var VolumeStep = Game.MusicVolume / (fadeTime * 60);
	
	// Set the target volume
	var VolumeLevel = min(audio_sound_get_gain(musicID) + VolumeStep, Game.MusicVolume);
	
	// Update BGM volume
	audio_sound_gain(musicID, VolumeLevel, 0);	
}