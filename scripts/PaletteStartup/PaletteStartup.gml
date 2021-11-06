function PaletteStartup()
{	
	// Set blank values
	ColourSet = [];
	Duration  = [];
	SwapTime  = [];
	Sequence  = [];
	
	// Initialise palette animation storage
	for (var i = 0; i < PaletteLimit; i++)
	{
		for (var j = 0; j < PaletteLimit; j++)
		{
			Duration[i, j] = noone;
			Sequence[i, j] = noone;
			SwapTime[i, j] = noone;
		}	
		IndexType1[i] = 1;
		IndexType2[i] = 1;
	}
	
	// Setup surfaces
	SurfaceLow  = noone;
	SurfaceHigh = noone;
	DoReset		= false;

	// Setup fade
	FadeMode   = 1;
	FadeStep   = 756;
	FadeBlend = 0;
	FadeSpeed  = 0;
	
	// Enable surface draw
	application_surface_draw_enable(false);
}