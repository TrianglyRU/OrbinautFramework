function PlayerPosition() 
{	
	// Exit if global movement is disabled
	if !AllowMovement exit;
	
	// Update position
	PosX += Xsp;
	PosY += Ysp;	
	
	// Add gravity if airborne
	if !Grounded
	{
		Ysp += Grv;
	}
	
	// Remember player's position for previous 32 frames
	ds_list_delete(RecordedPosX, 31);
	ds_list_delete(RecordedPosY, 31);
	ds_list_insert(RecordedPosX, 0, PosX);
	ds_list_insert(RecordedPosY, 0, PosY);
}