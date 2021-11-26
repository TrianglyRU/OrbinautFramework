function AudioStartup()
{
	/* Array Pointers
	0 - Event
	1 - Track ID
	2 - Event Time
	3 - Loop Data
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