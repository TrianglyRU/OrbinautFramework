function PlayerEnd()
{
	// Destroy data structures
	ds_list_destroy(RecordedPosX);
	ds_list_destroy(RecordedPosY);
	
	RecordedPosX = -1;
	RecordedPosY = -1;
}