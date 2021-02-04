function PlayerSpeedToPos() 
{	
	// Update previous position
	PosXPrev = PosX;
	PosYPrev = PosY;
	
	// Update current position
	PosX += Xsp;
	PosY += Ysp;
}
