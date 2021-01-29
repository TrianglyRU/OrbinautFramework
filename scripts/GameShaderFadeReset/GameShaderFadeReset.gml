function GameShaderFadeReset()
{	
	// Enable fade and turn our screen into the black colour
	Game.FadeEnabled = true;
	Game.FadeMode	 = 0;
	Game.FadeColour	 = 0;
	Game.FadeStep	 = 0;
	Game.FadeTimer	 = 0;
	Game.FadePower	 = 0;
	application_surface_draw_enable(false);
}