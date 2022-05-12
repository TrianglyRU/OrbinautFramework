/// @description Unload
// You can write your code in this editor

	ds_map_destroy(TrackLoopData);	   
	ds_map_destroy(SubTrackData); 
	
	TrackLoopData = -1;
	SubTrackData  = -1;
	
	audio_stop_all();