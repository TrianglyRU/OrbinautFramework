function InterfaceGameOverDraw()
{
	if !Stage.RestartEvent
	{
		return;
	}
	
	// Move assets
	GameOverValue[0] = min(GameOverValue[0] + 16 * (Game.Width / 320), Game.Width / 2 - 40);
	GameOverValue[1] = max(GameOverValue[1] - 16 * (Game.Width / 320), Game.Width / 2 + 40);
	
	// Draw assets
	draw_sprite(gui_gameover_gametime, Stage.Time == 36000 and Player.Lives, GameOverValue[0], Game.Height / 2);
	draw_sprite(gui_gameover_over,	   0,									 GameOverValue[1], Game.Height / 2);
}