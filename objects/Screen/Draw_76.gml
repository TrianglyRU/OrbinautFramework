/// @description Insert description here
// You can write your code in this editord

	if !surface_exists(Game.MainSurf)
	{
		Game.MainSurf = surface_create(Width + 16, Height);
		view_surface_id[0] = Game.MainSurf;
		GSTexel = texture_get_texel_width(surface_get_texture(Game.MainSurf));
	}

	if !surface_exists(Game.BGSurf)
	{
		Game.BGSurf = surface_create(Width, Height);
	}
	
	if !surface_exists(Game.CompleteSurf)
	{
		Game.CompleteSurf = surface_create(Width, Height);
	}