function PaletteReset()
{
	// Reset low surface
	if surface_exists(SurfaceLow) 
	{
		surface_free(SurfaceLow);
		SurfaceLow = -1;
	}
	
	// Reset high surface
	if surface_exists(SurfaceHigh) 
	{
		surface_free(SurfaceHigh);
		SurfaceHigh = -1;
	}
}