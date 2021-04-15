function PaletteFadeReset()
{	
	// Enable fade and turn our screen into the black colour
	Palette.FadeEnabled = true;
	Palette.FadeMode	= 0;
	Palette.FadeColour	= 0;
	Palette.FadeStep	= 0;
	Palette.FadeTimer	= 0;
	Palette.FadePower	= 0;
	
	// Reset surface
	application_surface_draw_enable(false);
}