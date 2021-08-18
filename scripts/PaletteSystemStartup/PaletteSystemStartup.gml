function PaletteSystemStartup()
{	
	// Initialize palette animation storage
	for (var i = 0; i < PaletteLimit; i++)
	{
		for (var j = 0; j < PaletteLimit; j++)
		{
			PaletteStruct.Duration[i, j] = noone;
			PaletteStruct.Sequence[i, j] = noone;
		}	
		PaletteStruct.IndexDry[i] = 1;
		PaletteStruct.IndexWet[i] = 1;
	}
	
	// Setup fade and surface state
	PaletteStruct.SurfaceHigh = -1;
	PaletteStruct.SurfaceLow  = -1;
	PaletteStruct.FadeMode    =  1;
	PaletteStruct.FadeStep    =  756;
	
	// Reset surface
	application_surface_draw_enable(false);
}