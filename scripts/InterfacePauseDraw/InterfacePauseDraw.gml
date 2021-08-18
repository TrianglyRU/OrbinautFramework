function InterfacePauseDraw()
{	
	// Exit if stage is not paused
	if !Stage.IsPaused
	{
		exit;
	}
	
	// Get pause position
	var MenuX = Game.Width / 2;
	var MenuY = Game.Height / 2;
	
	// Draw pause menu
	draw_sprite(spr_pause_menu,	   sign(PauseValue[1]),						MenuX, MenuY);
	draw_sprite(spr_pause_buttons, PauseValue[0] + (PauseValue[1] ? 3 : 0), MenuX, MenuY);
}