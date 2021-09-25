function PaletteSurfaceProcess()
{	
	// Re-enable surface rendering
	application_surface_draw_enable(true);
	
	// Render application surface (some post-processing can be added here)
	draw_surface(application_surface, 0, 0);
	
	// Disable surface rendering
	application_surface_draw_enable(false);
}