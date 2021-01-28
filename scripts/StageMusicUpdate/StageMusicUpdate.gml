function StageMusicUpdate()
{	
	// Play stage music
	sound_bgm_play(BackgroundMusic, 125.120, 69.490);
	
	// Stop stage music when act is finished
	if State = ActStateFinished
	{
		sound_bgm_stop(BackgroundMusic, 3);
	}
}