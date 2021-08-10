function PaletteSystemStartup()
{	
	// Initialize palette animation storage
	for (var i = 0; i < PaletteLimit; i++)
	{
		for (var j = 0; j < PaletteLimit; j++)
		{
			PaletteDuration[i, j] = noone;
			PaletteSequence[i, j] = noone;
		}	
		PaletteIndexDry[i] = 1;
		PaletteIndexWet[i] = 1;
	}
	
	// Setup fade and surface state
	SurfaceHigh = -1;
	SurfaceLow  = -1;
	FadeMode    =  1;
	FadeStep    =  756;
	
	// Reset surface
	application_surface_draw_enable(false);
}