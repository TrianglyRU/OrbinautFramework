/// @function draw_animated_sprite_ext(sprite,speed,timer,x,y,xscale,yscale)
function draw_animated_sprite_ext(sprite,speed,timer,x,y,xscale,yscale)
{
	// Animate sprite
	draw_sprite_ext(sprite, timer div speed mod sprite_get_number(sprite), x, y, xscale, yscale, 0, c_white, 1);
}