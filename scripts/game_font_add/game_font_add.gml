/// @function game_font_add(spr,mapstring,prop,sep)
function game_font_add(spr,mapstring,prop,sep)
{
	global.Font[spr] = font_add_sprite_ext(spr, mapstring, prop, sep);
}