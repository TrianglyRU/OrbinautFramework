function RendererSurfaceSet()
{
    // Create surfaces
    if !surface_exists(SurfaceLow)
    {
        SurfaceLow = surface_create(global.Width + global.ScreenBufer * 2, global.Height);
        
        surface_set_target(SurfaceLow);
        draw_clear_alpha(c_black, 0);
        surface_reset_target();
        
        view_surface_id[0] = SurfaceLow;
    }
    if !surface_exists(SurfaceHigh)
    {
        SurfaceHigh = surface_create(global.Width, global.Height);
        
        surface_set_target(SurfaceHigh);
        draw_clear_alpha(c_black, 0);
        surface_reset_target();
    }
	
	// Call main shader
	shader_set(ShaderMain);
}