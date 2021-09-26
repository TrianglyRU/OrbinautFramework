function AudioLooppointsSetup()
{
	/* The game will refer to data stored here if 'other' is set as a looppoint
	when calling audio_bgm_play() function */
	
	audio_bgm_setloop(TestStageMusic, 3.2);
	audio_bgm_setloop(BossMusic,    1.625);
	audio_bgm_setloop(SuperTheme,    0.63);
}