/// @description Insert description here
// You can write your code in this editord

	if !surface_exists(Game.MainSurf)
	{
		Game.MainSurf = surface_create(Width, Height);
		view_surface_id[0] = Game.MainSurf;
	}