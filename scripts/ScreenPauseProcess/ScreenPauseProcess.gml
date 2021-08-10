function ScreenPauseProcess()
{	
	if Stage.IsPaused
	{
		var MenuX = Width / 2;
		var MenuY = Height / 2;
		draw_sprite(spr_pause_menu, sign(Stage.PauseMode), MenuX, MenuY);
		draw_sprite(spr_pause_buttons, Stage.PauseButton + (Stage.PauseMode ? 3 : 0), MenuX, MenuY);
	}
}