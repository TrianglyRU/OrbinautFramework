/// @function game_font_add(spr,mapstring,sep)
function game_font_add(spr,mapstring,sep)
{
	Game.Font[spr] = font_add_sprite_ext(spr, mapstring, false, sep);
}