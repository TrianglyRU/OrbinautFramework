if sprite_index < 0
{
	exit;
}
	
// Draw at floored position
draw_sprite_ext
(
	sprite_index, image_index, floor(x), floor(y), image_xscale, image_yscale, image_angle, draw_get_colour(), image_alpha
);