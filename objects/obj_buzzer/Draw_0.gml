// Inherit the parent event
event_inherited();

if turn_timer <= 0
{
	draw_sprite_ext(spr_buzzer_flame, flame_timer % 3, floor(x), floor(y), image_xscale, image_yscale, image_angle, draw_colour, image_alpha);
}