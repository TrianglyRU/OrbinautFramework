function AudioStartup()
{
	/* Array Pointers
	0 - Event
	1 - TrackID
	2 - EventTime
	3 - LoopData
	*/
	
	// Set non-priority track data
	LowTrack[0] = EventIdle;
	LowTrack[1] = noone;
	LowTrack[2] = 0;
	LowTrack[3] = [];
	
	// Set priority track data
	HighTrack[0] = EventIdle;
	HighTrack[1] = noone;
	HighTrack[2] = 0;
	
	// Create TrackLoop data structure
	TrackLoop = ds_map_create();
}