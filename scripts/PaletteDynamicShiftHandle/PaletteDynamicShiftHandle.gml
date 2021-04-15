function PaletteDynamicShiftHandle()
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
				for (var i = 4; i < 7; i++) 
				{
					palette_handle(i, 3, 4);
				}
			}
			break;
			case CharKnuckles:
			{
				for (var i = 7; i < 10; i++) 
				{
					palette_handle(i, 10, 4);
				}
			}
			break;
		}
	}	
	
	// Stage palette shift
	switch room
	{
		case MBZ:
		case MBZ2:
		{
			palette_handle(10, 6, 8);
		}
	}
}