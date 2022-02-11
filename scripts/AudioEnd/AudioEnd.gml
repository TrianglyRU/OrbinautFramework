function AudioEnd()
{
	ds_map_destroy(TrackLoop);
	ds_map_destroy(SecondChannel);
	
	audio_stop_all();
}