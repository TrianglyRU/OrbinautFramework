/// @description Insert description here
// You can write your code in this editor
if !surface_exists(Game.MainSurf)
{
	Game.MainSurf = surface_create(Game.ResolutionWidth + 16, Game.ResolutionHeight);
	view_surface_id[0] = Game.MainSurf;
}