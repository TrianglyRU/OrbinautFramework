function InterfaceGameOverDraw()
{
	// Exit if it is not game/time over event
	if !Stage.IsGameOver
	{
		exit;
	}
	
	// Move sprites
	GameOverValue[0] = min(GameOverValue[0] + 16, Game.Width / 2 - 9);
	GameOverValue[1] = max(GameOverValue[1] - 16, Game.Width / 2 + 9);
	
	// Draw sprites
	draw_sprite(gui_gameover_gametime, Stage.Time == 36000 and Player.Lives, GameOverValue[0], Game.Height / 2);
	draw_sprite(gui_gameover_over,	   0,									 GameOverValue[1], Game.Height / 2);
}