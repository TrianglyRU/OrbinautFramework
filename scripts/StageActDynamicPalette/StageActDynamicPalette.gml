function StageActDynamicPalette()
{	
	switch ZoneID
	{	
		// Moonlight Base
		case 0:
		{
			for (var i = 8; i < 10; i++)
			{
				palette_cycle_perform(i, 7, 6); 
			}
			for (var i = 10; i < 33; i++)
			{
				palette_cycle_perform(i, 1, 1);
			}		
		}
		break;
	}
}