function GameShaderPaletteSetLoad()
{	
	// Set palette sprite to load
	switch room 
	{	
		// Load palette set for Moonlight Base
		case MBZ:
		case MBZ2:
			Game.PaletteSet[0] = palette_data(pal_MMZ_Dynamic);
			Game.PaletteSet[1] = palette_data(pal_MMZ_Wet);
		break;
		
		// Load palette set for Hilltop Heights
		case HHZ:
			Game.PaletteSet[0] = palette_data(pal_MMZ_Dynamic);
			Game.PaletteSet[1] = false;
		break;
		
		// Disable palettes for other rooms
		default:
			Game.PaletteSet[0] = palette_data(pal_MMZ_Dynamic);
			Game.PaletteSet[1] = false;
		break;
	}
}