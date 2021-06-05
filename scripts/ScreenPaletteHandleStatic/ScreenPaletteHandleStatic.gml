function ScreenPaletteHandleStatic()
{
	switch room
	{
		case MQZ1:
		case MQZ2:
		{
			// Wet palette
			for (var i = 0; i <= 35; i++)
			{
				palette_handle(true, i, 1, 1);
			}
		}
		break;
	}
}