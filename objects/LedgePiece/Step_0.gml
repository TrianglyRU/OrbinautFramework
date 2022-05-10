/// @description Main
// You can write your code in this editor
	
	if !(--Timer)
	{
		// Move and fall
		Ysp  += 0.21875;
		PosY += Ysp;
		y	  = floor(PosY);
	}