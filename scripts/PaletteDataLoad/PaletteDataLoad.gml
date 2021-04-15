function PaletteDataLoad()
{	
	// Set palette sprite to load
	switch room 
	{	
		// Load palette set for Moonlight Base
		case MBZ:
		case MBZ2:
			palette_load(PaletteSurface, pal_MMZ_Dynamic);
			palette_load(PaletteUnderwater, pal_MMZ_Wet);
		break;
		
		// Load palette set for Hilltop Heights
		case HHZ:
			//Game.PaletteSet[0] = palette_load(pal_MMZ_Dynamic);
			//Game.PaletteSet[1] = false;
		break;
		
		// Disable palettes for other rooms
		default:
			palette_load(PaletteSurface, false);
			palette_load(PaletteUnderwater, false);
		break;
	}
}