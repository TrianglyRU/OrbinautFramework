function PaletteSetup()
{	
	switch room 
	{	
		// Load MQZ palette
		case MQZ0:
		{
			palette_load(PaletteSurface,    pal_surface);
			palette_load(PaletteUnderwater, pal_underwater);
		}
		break;
		
		// Load default palette
		default:
		{
			palette_load(PaletteSurface,    pal_surface);
			palette_load(PaletteUnderwater, pal_underwater);
		}
		break;
	}
}