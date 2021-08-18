function PaletteReset()
{
	// Reset low surface
	if surface_exists(Palette.SurfaceLow) 
	{
		surface_free(Palette.SurfaceLow);
		Palette.SurfaceLow = -1;
	}
	
	// Reset high surface
	if surface_exists(Palette.SurfaceHigh) 
	{
		surface_free(Palette.SurfaceHigh);
		Palette.SurfaceHigh = -1;
	}
}