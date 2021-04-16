function GameAudioGroupsLoad()
{
	// Load audiogroups
	audio_group_load(GlobalSFX);
	audio_group_load(BGM);
	
	// Create a system variable we will use to loop tracks
	variable_set_temp("Game.loopTrack");

	// Set groups volume to game volume
	audio_group_set_gain(GlobalSFX, Game.SoundVolume, 0);
	audio_group_set_gain(BGM,	    Game.MusicVolume, 0);
}