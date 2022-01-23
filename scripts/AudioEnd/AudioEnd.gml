function AudioEnd()
{
	audio_stop_all(); 
	
	ds_map_destroy(TrackLoop);
	ds_map_destroy(SecondChannel);
}