/// @description Insert description here
// You can write your code in this editor

	surface_set_target(application_surface);
	if (surface_exists(Game.MainSurf)) draw_surface(Game.MainSurf, -8, 0);
	surface_reset_target();
	
	application_surface_draw_enable(true);
	draw_surface(application_surface, 0, 0);
	application_surface_draw_enable(false);