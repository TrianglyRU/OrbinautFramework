function PaletteSetup()
{	
	switch room 
	{
		// Load basic palette for Test Stage
		case Stage_TZ:
		{
			palette_load(TypePrimary,   pal_default_type1);
			palette_load(TypeSecondary, pal_tz_type2);
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