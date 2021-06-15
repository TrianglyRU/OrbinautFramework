function ScreenStagePauseRender()
{
	if Stage.GamePaused
	{
		surface_set_target(application_surface);
		draw_sprite(PauseScreen, 0, 0, 0);
		var MenuX = Width / 2;
		var MenuY = Height / 2;
		draw_sprite(spr_pause_menu, sign(Stage.PauseMode), MenuX, MenuY);
		draw_sprite(spr_pause_buttons, Stage.PauseButton + (Stage.PauseMode ? 3 : 0), MenuX, MenuY);
		
		surface_reset_target();
		application_surface_draw_enable(true);
		draw_surface(application_surface, 0, 0);
		application_surface_draw_enable(false);
		
		//ScreenRendererHighUpdate();
		
		return true;
	}
}