function AudioStartup()
{
	// Stop all audio
	audio_stop_all();
	
	// Set non-priority track data
	LowTrack[2]  = EventIdle;
	LowTrack[0]  = noone;
	LowTrack[1]  = 0;
	LowTrack[3]  = 0;
	
	// Set priority track data
	HighTrack[2]  = EventIdle;
	HighTrack[0]  = noone;
	HighTrack[1]  = 0;
	HighTrack[3]  = 0;
}