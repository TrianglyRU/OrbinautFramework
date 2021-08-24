function AudioLooppointsSetup()
{
	/* The game will refer to data stored here if 'other' is set as a looppoint
	when calling audio_bgm_play() function */
	
	TrackLoop[TestStageMusic] = 3.2;
	TrackLoop[BossMusic]      = 1.625;
	TrackLoop[SuperMusic]     = 0.6;
}