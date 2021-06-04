/// @description Insert description here
// You can write your code in this editor
if HurtTimer div 4 mod 2 = 1
{
	shader_set(ShaderNegative);
	draw_self();
	shader_reset();
}
else
{
	draw_self();
}