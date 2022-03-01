function InterfaceRendererHighProcess()
{
	shader_set(ShaderMain);
	surface_set_target(Renderer.SurfaceHigh);
	
	draw_clear_alpha(c_white, 0);
}