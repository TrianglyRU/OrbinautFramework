function ObjPlatformPieceMain()
{
	if !(--Timer)
	{
		// Fall
		Ysp  += 0.21875;
		PosY += Ysp;
		
		// Update position
		y = floor(PosY);
	}
}