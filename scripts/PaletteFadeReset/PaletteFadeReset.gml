function PaletteFadeReset()
{	
	// Enabled palette fade
	Palette.FadeEnabled = true;
	
	// Turn the screen into black colour
	Palette.FadeMode	= 0;
	Palette.FadeColour	= 0;
	Palette.FadeStep	= 0;
	Palette.FadeTimer	= 0;
	Palette.FadePower	= 0;
	
	// Reset surface
	application_surface_draw_enable(false);
}