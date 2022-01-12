function PaletteSurfaceProcess()
{	
	// Draw surface
	application_surface_draw_enable(true);
	draw_surface(application_surface, 0, 0);
	application_surface_draw_enable(false);
}