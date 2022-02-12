function AudioEnd()
{
	ds_map_destroy(TrackLoop);	   TrackLoop = -1;
	ds_map_destroy(SecondChannel); SecondChannel = -1;
	
	audio_stop_all();
}