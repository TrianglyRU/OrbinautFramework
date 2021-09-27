function AudioLooppointsSetup()
{
	/* The game will refer to data stored here if 'other' is set as a looppoint
	when calling audio_bgm_play() function */
	
	audio_bgm_setloop(TestZone,   0.05, 43.15);
	audio_bgm_setloop(SuperTheme, 0,    54.38);
	audio_bgm_setloop(Boss,       3.25, 28.84);
}