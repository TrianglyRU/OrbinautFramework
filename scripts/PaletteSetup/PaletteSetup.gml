function PaletteSetup()
{	
	switch room 
	{
		case Stage_TZ:
		{
			palette_load(TypePrimary,   pal_tz_type1);
			palette_load(TypeSecondary, pal_tz_type2);
		}
		break;
		default:
		{
			palette_load(TypePrimary,   noone);
			palette_load(TypeSecondary, noone);
		}
		break;
	}
}