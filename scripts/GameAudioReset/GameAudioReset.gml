function GameAudioReset()
{
	// Stop all audio
	audio_stop_all();
	
	// Reset low priority track data
	Game.LowTrack[2]  = EventIdle;
	Game.LowTrack[0]  = 0;
	Game.LowTrack[1]  = 0;
	Game.LowTrack[3]  = 0;
	
	// Reset high priority track data
	Game.HighTrack[2]  = EventIdle;
	Game.HighTrack[0]  = 0;
	Game.HighTrack[1]  = 0;
	Game.HighTrack[3]  = 0;
}