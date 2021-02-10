function PlayerSpeedToPos() 
{	
	// Update real position
	RealPosX += Xsp;
	RealPosY += Ysp;	
	
	// Update floored position (the one we use in objects and stuff)
	PosX = floor(RealPosX);
	PosY = floor(RealPosY);
}
