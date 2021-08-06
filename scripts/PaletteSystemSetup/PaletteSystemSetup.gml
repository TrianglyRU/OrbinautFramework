function PaletteSystemSetup()
{	
	// Initialize palette animation storage
	for (var i = 0; i < 64; i++)
	{
		for (var j = 0; j < 64; j++)
		{
			PaletteDuration[i, j] = noone;
			PaletteSequence[i, j] = noone;
		}	
		PaletteIndexDry[i] = 1;
		PaletteIndexWet[i] = 1;
	}
	
	FadeMode   = 1;
	FadeColour = 0;
	FadeStep   = 756;
	FadeTimer  = 0;
	FadePower  = 0;
	
	// Reset surface
	application_surface_draw_enable(false);
}