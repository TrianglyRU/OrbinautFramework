function StageActDynamicPaletteHandle()
{	
	// Perform super palette cycle
	if Player.isSuper
	{
		switch Player.CharacterID
		{
			case CharSonic:
			{
				for (var i = 0; i < 8; i++) 
				{
					palette_handle(i, 9, 4);
				}
			}
			break;
			case CharTails:
			{
				for (var i = 8; i < 14; i++) 
				{
					palette_handle(i, 3, 4);
				}
			}
			break;
			case CharKnuckles:
			{
				for (var i = 14; i < 20; i++) 
				{
					palette_handle(i, 10, 4);
				}
			}
			break;
		}
	}	
}