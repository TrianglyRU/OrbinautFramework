function StageActDynamicPalette()
{	
	switch ZoneID
	{	
		// Moonlight Base
		case 0:
		{	
			for (var i = 4; i < 36; i++)
			{
				palette_handle(i, 1, 1);
			}
		}
		break;
	}
}