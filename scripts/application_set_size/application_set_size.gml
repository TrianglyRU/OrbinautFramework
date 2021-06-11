/// @function application_set_size(appWidth, appHeight)
function application_set_size(appWidth, appHeight)
{	
	// Set camera size
	camera_set_view_size(view_camera[0], appWidth + 16, appHeight);
	
	// Set application surface/viewport size
	surface_resize(application_surface,  appWidth, appHeight);
	
	// Resize main and background surfaces 
	if surface_exists(Game.MainSurf)
	{
		surface_resize(Game.MainSurf, appWidth + 16, appHeight);
	}
	if surface_exists(Game.BGSurf)
	{
		surface_resize(Game.BGSurf, appWidth, appHeight);
	}
	if surface_exists(Game.CompleteSurf)
	{
		surface_resize(Game.CompleteSurf, appWidth, appHeight);
	}
	
	// Enable surface rendering in case it was disabled
	application_surface_draw_enable(true);
}