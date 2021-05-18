/// @description Insert description here
// You can write your code in this editor
if !surface_exists(GameSurf)
{
	GameSurf = surface_create(Width + 16, Height);
	view_surface_id[0] = GameSurf;
}