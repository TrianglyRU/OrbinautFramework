function ScreenPaletteDataLoad()
{	
	// Check current room/scene
	switch room 
	{	
		// Load palettes for MQZ
		case MQZ1:
		case MQZ2:
		{
			palette_load(PaletteSurface,    pal_surface_mqz);
			palette_load(PaletteUnderwater, pal_underwater_template);
		}
		break;
		
		// Disable palettes for other rooms
		default:
		{
			palette_load(PaletteSurface,    pal_surface_template);
			palette_load(PaletteUnderwater, pal_underwater_template);
		}
		break;
	}
}