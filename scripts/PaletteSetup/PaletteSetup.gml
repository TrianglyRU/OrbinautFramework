/// @ Called in Palette Controller -> Create Event
function PaletteSetup()
{
	switch room 
	{
		case Stage_TSZ:
		{
			palette_load(PalPrimary,   pal_tz_type1);
			palette_load(PalSecondary, pal_tz_type2);
		}
		break;
		default:
		{
			palette_load(PalPrimary,   noone);
			palette_load(PalSecondary, noone);
		}
	}
}