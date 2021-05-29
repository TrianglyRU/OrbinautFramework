function PlayerSpeedToPos() 
{	
	// Update position
	PosX += Xsp;
	PosY += Ysp;	
	
	// Update recorded positions
	ds_list_delete(RecordedPosX, 31);
	ds_list_delete(RecordedPosY, 31);
	ds_list_insert(RecordedPosX, 0, PosX);
	ds_list_insert(RecordedPosY, 0, PosY);
}