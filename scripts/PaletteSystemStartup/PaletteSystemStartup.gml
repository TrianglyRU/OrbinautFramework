function PaletteSystemStartup()
{	
	// Initialise palette animation storage
	for (var i = 0; i < PaletteLimit; i++)
	{
		for (var j = 0; j < PaletteLimit; j++)
		{
			Duration[i, j] = noone;
			Sequence[i, j] = noone;
		}	
		IndexDry[i] = 1;
		IndexWet[i] = 1;
	}
	
	// Reset surfaces
	if surface_exists(SurfaceLow) 
	{
		surface_free(SurfaceLow);
	}
	if surface_exists(SurfaceHigh) 
	{
		surface_free(SurfaceHigh);	
	}
	SurfaceLow  = -1;
	SurfaceHigh = -1;
	
	// Setup fade and surfaces
	FadeMode    =  1;
	FadeStep    =  756;
	
	// Reset surface
	application_surface_draw_enable(false);
}