function PaletteSetup()
{	
	switch room 
	{
		// Load basic palette for Test Stage
		case Stage_TZ:
		{
			palette_load(TypePrimary,   pal_default_dry);
			palette_load(TypeSecondary, pal_default_wet);
		}
		break;
		
		// Do not load any palettes by default
		default:
		{
			palette_load(TypePrimary,   noone);
			palette_load(TypeSecondary, noone);
		}
		break;
	}
}