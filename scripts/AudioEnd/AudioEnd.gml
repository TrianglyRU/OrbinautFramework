function AudioEnd()
{
	// Stop all audio and destroy datastructure
	audio_stop_all(); ds_map_destroy(TrackLoop);
}