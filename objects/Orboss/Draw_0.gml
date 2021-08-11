/// @description Insert description here
// You can write your code in this editor
	
	if DamageFlash
	{
		shader_set(ShaderBossFlash);
		shader_set_uniform_i(Shader.BossFlashType, 1);
		draw_self();
		shader_reset();
	}
	else
	{
		draw_self();
	}