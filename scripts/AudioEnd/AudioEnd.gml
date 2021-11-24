function AudioEnd()
{
	// Destroy data structure
	ds_map_destroy(TrackLoop);
	
	// Stop all sounds
	audio_stop_all();
}