function StageActStaticPaletteHandle()
{
	switch ZoneID
	{	
		// Moonlight Base
		case 0:
		{	
			for (var i = 5; i < 33; i++) 
			{ 
				Game.PalIndex[i] = 1; 
			}
		}
		break;
	}
}