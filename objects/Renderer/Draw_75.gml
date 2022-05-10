/// @description Free Surfaces
// You can write your code in this editor
	
	/* This event is performed on room end */
	if !SurfaceReset
	{
		return;
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