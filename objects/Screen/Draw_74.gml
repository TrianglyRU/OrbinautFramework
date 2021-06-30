/// @description Renderer & Interface
// You can write your code in this editor
	
	// Render pause and exit the futher code if it is active
	if ScreenPauseDisplay() exit;
	
	// Start rendering our application
	if surface_perform(Palette.SurfaceLow)
	{
		
		// Display HUD
		ScreenInterfaceDisplay();
	
		// Display results screen
		ScreenResultsDisplay();
		
		surface_reset_target();
	}
	
	if surface_perform(Palette.SurfaceHigh)
	{	
		draw_clear_alpha(c_white, 0);
		// Display title card
		ScreenTitleCardDisplay();
		
		surface_reset_target();
	}