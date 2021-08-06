function ScreenRendererLowProcess()
{
	if instance_exists(Palette)
	{
		surface_set_target(Palette.SurfaceLow);
	}
}