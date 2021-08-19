function AudioLooppointsSetup()
{
	/* The game will refer to data stored here if 'other' is set as a looppoint
	when calling audio_bgm_play() function */
	
	TrackLoop[StarryNight] = 0;
	TrackLoop[BossMusic]   = 0;
	TrackLoop[SuperMusic]  = 0.6;
}