function GameAudioGroupsLoad()
{
	// Load audiogroups
	audio_group_load(GlobalSFX);
	audio_group_load(BGM);
	
	// Init system looptrack variable
	variable_instance_set(self, "Game.loopTrack", 0);

	// Set volume
	audio_group_set_gain(GlobalSFX, Game.SoundVolume, 0);
	audio_group_set_gain(BGM,	    Game.MusicVolume, 0);
}