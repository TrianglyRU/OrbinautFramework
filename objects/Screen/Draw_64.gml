/// @description Renderer & Interface
// You can write your code in this editor
	
	if Stage.GamePaused
	{
		surface_set_target(application_surface);
		draw_sprite(PauseScreen, 0, 0, 0);
		var MenuX = Width / 2;
		var MenuY = Height / 2;
		draw_sprite(spr_pause_menu, sign(Stage.PauseMode), MenuX, MenuY);
		draw_sprite(spr_pause_buttons, Stage.PauseButton + (Stage.PauseMode ? 3 : 0), MenuX, MenuY);
		
		ScreenRendererUpdate();
		exit;
	}
	
	// TODO: all
	if surface_exists(Game.CompleteSurf)
	{
		surface_set_target(Game.CompleteSurf);
	
		if surface_exists(Game.BGSurf)
		{
			draw_surface(Game.BGSurf, 0, 0);
		}
	
		if surface_exists(Game.MainSurf) 
		{
			shader_set(ShaderWave);
			var stg = instance_exists(Stage) and Stage.WaterEnabled;
			shader_set_uniform_f(Uniform.Wave_Texel, GSTexel);
			shader_set_uniform_f(Uniform.Wave_Time,  stg ? Stage.Time div 2 : 0);
			shader_set_uniform_f(Uniform.Wave_Water, stg ? clamp(CameraY - Stage.WaterLevel + Height, 0, Height) : 0);
			shader_set_uniform_f(Uniform.Wave_CamY, CameraY);
			shader_set_uniform_f(Uniform.Wave_ScrnHeight, Height);
			draw_surface(Game.MainSurf, -8, 0);
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
		
		surface_reset_target();
		
		surface_set_target(application_surface);
		draw_surface(Game.CompleteSurf, 0, 0);
		shader_reset();
	
		/* Everything after this line will render ABOVE the fade */
	
		// Display title card
		ScreenTitleCardDisplay();
	
		// Update our application renderer
		ScreenRendererUpdate();
	}
	
	/* Everything after this line will use current 
		  window resolution instead of game one    */
	
	// Display debug screen
	ScreenDebugScreenDisplay();