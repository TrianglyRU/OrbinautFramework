function ObjLedgePieceMain()
{
	if !(--Timer)
	{
		// Move and fall
		Ysp  += 0.21875;
		PosY += Ysp;
		y	  = floor(PosY);
	}
}