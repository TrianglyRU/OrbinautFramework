function ScreenPauseProcess()
{	
	if Stage.IsPaused
	{
		var MenuX = Width / 2;
		var MenuY = Height / 2;
		draw_sprite(spr_pause_menu, sign(PauseValue[1]), MenuX, MenuY);
		draw_sprite(spr_pause_buttons, PauseValue[0] + (PauseValue[1] ? 3 : 0), MenuX, MenuY);
	}
}