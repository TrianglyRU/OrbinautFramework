function GameAudioGroupsVolumeReset()
{	
	// Reset all sounds and music volume
	audio_group_set_gain(GlobalSFX, Game.SoundVolume, 0);
	audio_group_set_gain(BGM,	    Game.MusicVolume, 0);
}