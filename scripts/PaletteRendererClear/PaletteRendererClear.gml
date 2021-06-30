function PaletteRendererClear()
{
	// Clear main surface
	if surface_exists(SurfaceLow) 
	{
		surface_free(SurfaceLow);
		SurfaceLow = -1;
	}
	
	if surface_exists(SurfaceHigh) 
	{
		surface_free(SurfaceHigh);
		SurfaceHigh = -1;
	}
}