function PaletteSetup()
{	
	switch room 
	{
		// Load basic palette for Test Stage
		case Stage_TZ:
		{
			palette_load(PaletteType1, pal_default_dry);
			palette_load(PaletteType2, pal_default_wet);
		}
		break;
		
		// Do not load any palettes by default
		default:
		{
			palette_load(PaletteType1, noone);
			palette_load(PaletteType2, noone);
		}
		break;
	}
}