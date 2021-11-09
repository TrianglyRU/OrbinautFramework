function AudioReset()
{
	// Destroy datastructure
	ds_map_destroy(TrackLoop);
	
	// Stop all sounds
	audio_stop_all();
}