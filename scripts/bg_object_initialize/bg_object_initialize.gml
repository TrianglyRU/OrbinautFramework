/// @function bg_object_initialize() 
function bg_object_initialize() 
{	
	// Apply a parallax shader to the object
	surface_set_target(Screen.BGSurf);
	shader_set(ShaderParallax);
	shader_set_uniform_f(Palette.Prlx_Wid,   sprite_width);
	shader_set_uniform_f(Palette.Prlx_Texel, texture_get_texel_width(sprite_get_texture(sprite_index, 0)));
}