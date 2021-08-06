function ScreenRendererHighProcess()
{
	if instance_exists(Palette)
	{
		surface_set_target(Palette.SurfaceHigh);
		draw_clear_alpha(c_white, 0);
	}
}