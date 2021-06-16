/// @description Insert description here
// You can write your code in this editor
if (State == 2 or State == 4) and StateTimer div 4 mod 2
{
	shader_set(ShaderNegative);
	draw_sprite(sprite_index, image_index, x + irandom(4) - 2, y + irandom(4) - 2);
	shader_reset();
}
else
{
	draw_self();
}