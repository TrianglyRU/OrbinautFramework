function PaletteSetup()
{	
	switch room 
	{	
		// Load basic palette for Test Stage
		case Stage_TZ:
		{
			palette_load(PaletteDry, pal_default_dry);
			palette_load(PaletteWet, pal_default_wet);
		}
		break;
		
		// Do not load any palettes by default
		default:
		{
			palette_load(PaletteDry, noone);
			palette_load(PaletteWet, noone);
		}
		break;
	}
}