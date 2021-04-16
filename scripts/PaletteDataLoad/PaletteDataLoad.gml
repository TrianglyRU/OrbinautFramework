function PaletteDataLoad()
{	
	// Check current room/scene
	switch room 
	{	
		// Load palettes for Moonlight Base
		case MBZ:
		case MBZ2:
			palette_load(PaletteSurface, pal_MMZ_Dynamic);
			palette_load(PaletteUnderwater, pal_MMZ_Wet);
		break;
		
		// Load palettes for Hilltop Heights
		case HHZ:
			palette_load(PaletteSurface, pal_MMZ_Dynamic);
			palette_load(PaletteUnderwater, false);
		break;
		
		// Disable palettes for other rooms
		default:
			palette_load(PaletteSurface, pal_MMZ_Dynamic);
			palette_load(PaletteUnderwater, false);
		break;
	}
}