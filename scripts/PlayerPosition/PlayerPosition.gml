function PlayerPosition() 
{	
	if !AllowMovement
	{
		return;
	}
	
	PosX += Xsp;
	PosY += Ysp;
	
	if !Grounded
	{
		Ysp += Grv;
	}
	
	// Remember player's position for the previous 32 frames
	ds_list_delete(RecordedPosX, 31);
	ds_list_delete(RecordedPosY, 31);
	ds_list_insert(RecordedPosX, 0, PosX);
	ds_list_insert(RecordedPosY, 0, PosY);
}