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
	}
}