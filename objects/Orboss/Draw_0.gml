/// @description Insert description here
// You can write your code in this editor
	
	if HurtFlash
	{
		shader_set(ShaderNegative);
		draw_self();
		shader_reset();
	}
	else
	{
		draw_self();
	}