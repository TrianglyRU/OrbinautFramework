function StageActDynamicPaletteHandle()
{	
	// Perform super palette cycle
	if Player.isSuper
	{
		switch Player.CharacterID
		{
			case CharSonic:
			{
				for (var i = 0; i < 4; i++) 
				{
					palette_handle(i, 9, 4);
				}
			}
			break;
			case CharTails:
			{
				for (var i = 0; i < 4; i++) 
				{
					palette_handle(i, 9, 4);
				}
			}
			break;
		}
	}	
}