function PaletteSetup()
{	
	switch room 
	{	
		// Load MQZ palette
		case MQZ0:
		{
			palette_load(PaletteDry, pal_mqz_dry);
			palette_load(PaletteWet, pal_mqz_wet);
		}
		break;
		
		// Load default palette
		default:
		{
			palette_load(PaletteDry, pal_default_dry);
			palette_load(PaletteWet, pal_default_wet);
		}
		break;
	}
}