function GameAudioGroupsVolumeReset()
{
	audio_group_set_gain(GlobalSFX, Game.SoundVolume, 0);
	audio_group_set_gain(StageSFX, Game.SoundVolume, 0);
	audio_group_set_gain(BGM, Game.SoundVolume, 0);
}