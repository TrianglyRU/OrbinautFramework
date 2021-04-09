function StageActDynamicPalette()
{	
	switch ZoneID
	{	
		// Moonlight Base
		case 0:
		{
			// Update dynamic lights
			for (var i = 8; i < 10; i++)
			{
				palette_handle(i, 7, 6); 
			}
			
			// Update underwater
			for (var i = 10; i < 33; i++)
			{
				palette_handle(i, 1, 1);
			}		
		}
		break;
	}
}