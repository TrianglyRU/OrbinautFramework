function InterfaceGameOverDraw()
{
	if !Stage.RestartEvent
	{
		return;
	}
	
	var CentreX = global.Width  / 2 + global.ScreenBuffer;
	var CentreY = global.Height / 2;
	
	// Move assets
	GameOverValue[0] = min(GameOverValue[0] + 16 * (global.Width / 320), CentreX - 40);
	GameOverValue[1] = max(GameOverValue[1] - 16 * (global.Width / 320), CentreX + 40);
	
	// Draw assets
	draw_sprite(gui_gameover_gametime, Stage.Time == 36000 and Player.Lives, GameOverValue[0], CentreY);
	draw_sprite(gui_gameover_over,	   0,									 GameOverValue[1], CentreY);
}