function ScreenPaletteHandleStatic()
{
	switch room
	{
		case MQZ1:
		case MQZ2:
		{		
			// MQZ underwater palette swap
			for (var i = 0; i < 20; i++)
			{
				palette_handle(PaletteUnderwater, i, 1, 1);
			}
		}
		break;
		default:
		{
			// Default underwater palette swap
			for (var i = 0; i < 20; i++)
			{
				palette_handle(PaletteUnderwater, i, 1, 1);
			}
		}
		break;
	}
}