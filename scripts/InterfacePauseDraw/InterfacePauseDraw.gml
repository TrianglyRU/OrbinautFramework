function InterfacePauseDraw()
{	
	if !Stage.IsPaused
	{
		exit;
	}
	
	// Get screen centre
	var MenuX = Game.Width / 2;
	var MenuY = Game.Height / 2;
	
	// Draw pause menu
	draw_sprite(gui_pause_menu,	   sign(PauseValue[1]),						MenuX,     MenuY);
	draw_sprite(gui_pause_options, PauseValue[0] + (PauseValue[1] ? 3 : 0), MenuX - 2, MenuY + 13);
}