/// @description Renderer & Interface
// You can write your code in this editor
	
	// TODO: all
	
	surface_set_target(application_surface);
	
	if surface_exists(BGSurf)
	{
		draw_surface(BGSurf, -8, 0);
	}
	
	if surface_exists(GameSurf) 
	{
		shader_set(ShaderWave);
		var stg = instance_exists(Stage);
		shader_set_uniform_f(Uniform.Wave_Texel, GSTexel);
		shader_set_uniform_f(Uniform.Wave_Time,  stg ? Stage.Time div 2 : 0);
		shader_set_uniform_f(Uniform.Wave_Water, stg ? clamp(CameraY - Stage.WaterLevel + Game.ResolutionHeight, 0, Game.ResolutionHeight) : 0);
		draw_surface(GameSurf, -8, 0);
		shader_reset();
	}

	// Draw water surface
	ScreenDrawWaterSurface();
	
	// Start rendering our application
	ScreenRendererPerform();
	
	// Display HUD
	ScreenInterfaceDisplay();
	
	// Display results screen
	ScreenResultsDisplay();
	
	// Display title card
	ScreenTitleCardDisplay();
	
	// Update our application renderer
	ScreenRendererUpdate();
	
	/* Everything after this line will render ABOVE the fade and 
	   will use current window resolution instead of game one    */
	
	// Display debug screen
	ScreenDebugScreenDisplay();