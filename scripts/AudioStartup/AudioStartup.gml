function AudioStartup()
{
	/* Array Pointers
	0 - Event
	1 - TrackID
	2 - EventTime
	3 - LoopData
	*/
	
	// Set primary track data
	PrimaryTrack[0] = EventIdle;
	PrimaryTrack[1] = noone;
	PrimaryTrack[2] = 0;
	PrimaryTrack[3] = [];
	
	// Set secondary track data
	SecondaryTrack[0] = EventIdle;
	SecondaryTrack[1] = noone;
	SecondaryTrack[2] = 0;
	
	// Create TrackLoop data structure
	TrackLoop = ds_map_create();
}