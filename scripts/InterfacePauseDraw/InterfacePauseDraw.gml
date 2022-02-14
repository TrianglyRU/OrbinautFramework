function InterfacePauseDraw()
{	
	if !Stage.IsPaused
	{
		return;
	}
	draw_sprite(gui_pause_menu,	PauseTimer > 7 ? 0 : PauseValue + 1, application_centre(0), application_centre(1));
}