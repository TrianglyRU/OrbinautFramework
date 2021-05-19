/// @description Insert description here
// You can write your code in this editor
if !surface_exists(GameSurf)
{
	GameSurf = surface_create(Width + 16, Height);
	view_surface_id[0] = GameSurf;
	GSTexel = texture_get_texel_width(surface_get_texture(GameSurf));
}

if !surface_exists(BGSurf)
{
	BGSurf = surface_create(Width + 16, Height);
}