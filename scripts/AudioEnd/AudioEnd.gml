function AudioEnd()
{
	ds_map_destroy(TrackLoop);	   
	ds_map_destroy(SecondChannel); 
	
	TrackLoop	  = -1;
	SecondChannel = -1;
	
	audio_stop_all();
}