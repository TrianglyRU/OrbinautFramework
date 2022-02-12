function PlayerEnd()
{
	// Destroy data structures
	ds_list_destroy(RecordedPosX); RecordedPosX = -1;
	ds_list_destroy(RecordedPosY); RecordedPosY = -1;
}