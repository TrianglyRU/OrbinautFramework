function InterfacePauseDraw()
{	
	if !Stage.IsPaused
	{
		return;
	}
	
	var CentreX = global.Width  / 2 + global.ScreenBuffer;
	var CentreY = global.Height / 2;
	
	draw_sprite(gui_pause_menu,	PauseTimer > 7 ? 0 : PauseValue + 1, CentreX, CentreY);
}