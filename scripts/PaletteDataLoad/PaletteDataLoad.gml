function PaletteDataLoad()
{	
	// Check current room/scene
	switch room 
	{	
		// Disable palettes for other rooms
		default:
		{
			palette_load(PaletteSurface, false);
			palette_load(PaletteUnderwater, false);
		}
		break;
		
		// Load palette for GVZ
		case GVZ:
		{
			palette_load(PaletteSurface, pal_GVZ_Dynamic);
			palette_load(PaletteUnderwater, false);
		}
	}
}