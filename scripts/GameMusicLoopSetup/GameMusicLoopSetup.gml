function GameMusicLoopSetup()
{
	/* The game will refer to data stored here if 'other' is set as a looppoint
	when calling audio_bgm_play() function */
	
	Game.TrackLoop[StarryNight] = 0;
	Game.TrackLoop[BossMusic]	= 0;
	Game.TrackLoop[SuperMusic]	= 0.6;
}