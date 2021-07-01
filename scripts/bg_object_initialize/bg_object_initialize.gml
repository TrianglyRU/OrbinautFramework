/// @function bg_objectisVariableialize() 
function bg_objectisVariableialize() 
{	
	// Apply a parallax shader to the object	
	shader_set(ShaderParallax);
	
	shader_set_uniform_f(Palette.Prlx_Wid,   sprite_get_width(tex_mqz_bg00));
	
	shader_set_uniform_f(Palette.Prlx_Texel, texture_get_texel_width(sprite_get_texture(tex_mqz_bg00, 0)));
}