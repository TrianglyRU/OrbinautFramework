function background_use_parallax() 
{	
	// Apply a parallax shader to the object
	shader_set(ShaderParallax);
	shader_set_uniform_f(Prlx_Wid,   sprite_width);
	shader_set_uniform_f(Prlx_Texel, texture_get_texel_width(sprite_get_texture(sprite_index, 0)));
}