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
}