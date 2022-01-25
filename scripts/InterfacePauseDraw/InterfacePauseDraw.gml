function InterfacePauseDraw()
{	
	if !Stage.IsPaused
	{
		return;
	}
	draw_sprite(gui_pause_menu,	PauseTimer > 7 ? 0 : PauseValue + 1, Game.Width / 2, Game.Height / 2);
}