function PlayerSpeedToPos() 
{	
	// Update position
	PosX += Xsp;
	PosY += Ysp;	
	
	ds_list_delete(PlayerPositionX, 31);
	ds_list_delete(PlayerPositionY, 31);
	ds_list_insert(PlayerPositionX, 0, PosX);
	ds_list_insert(PlayerPositionY, 0, PosY);
}