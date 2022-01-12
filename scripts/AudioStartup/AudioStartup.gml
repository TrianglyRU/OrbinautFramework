function AudioStartup()
{
	/* Value Table Reference
	------------------------
	[0] - Event
	[1] - Track ID
	[2] - Event Time
	[3] - Loop Data
	------------------------
	*/
	
	// Set channels data
	PrimaryTrack[0]   = EventIdle;
	PrimaryTrack[1]   = noone;
	PrimaryTrack[2]   = 0;
	PrimaryTrack[3]   = [];
	SecondaryTrack[0] = EventIdle;
	SecondaryTrack[1] = noone;
	SecondaryTrack[2] = 0;
	
	// Create data structure to store loopdata
	TrackLoop = ds_map_create();
}