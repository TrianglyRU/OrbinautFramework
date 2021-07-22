function PaletteDataLoad()
{	
	// Check current room/scene
	switch room 
	{	
		// Load palettes for MQZ
		case MQZ0:
		case MQZ1:
		case MQZ2:
		{
			palette_load(PaletteSurface,    pal_surface);
			palette_load(PaletteUnderwater, pal_underwater);
		}
		break;
		
		// Disable palettes for other rooms
		default:
		{
			palette_load(PaletteSurface,    false);
			palette_load(PaletteUnderwater, false);
		}
		break;
	}
}