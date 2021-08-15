function GameAudioStartup()
{
	// Reset low priority track data
	Game.LowTrack[2]  = EventIdle;
	Game.LowTrack[0]  = noone;
	Game.LowTrack[1]  = 0;
	Game.LowTrack[3]  = 0;
	
	// Reset high priority track data
	Game.HighTrack[2]  = EventIdle;
	Game.HighTrack[0]  = noone;
	Game.HighTrack[1]  = 0;
	Game.HighTrack[3]  = 0;
	
	/* The game will refer to data stored here if 'other' is set as a looppoint
	when calling audio_bgm_play() function */
	
	Game.TrackLoop[StarryNight] = 0;
	Game.TrackLoop[BossMusic]	= 0;
	Game.TrackLoop[SuperMusic]	= 0.6;
}