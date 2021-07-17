function PaletteHandleStatic()
{
	switch room
	{
		case MQZ0:
		case MQZ1:
		case MQZ2:
		{		
			// General underwater
			for (var i = 11; i <= 18; i++)
			{
				palette_handle(PaletteUnderwater, i, 1, 1, 1);
			}
			
			// Underwater swap
			for (var i = 22; i <= 50; i++)
			{
				palette_handle(PaletteUnderwater, i, 1, 1, 1);
			}
		}
		break;
		default: break;
	}
}