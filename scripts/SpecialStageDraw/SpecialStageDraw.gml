function SpecialStageDraw()
{
	var CentreX = Game.ResolutionWidth / 2;
	var CentreY = Game.ResolutionHeight / 2;
	
	draw_sprite(spr_spst_lose, 0, CentreX, CentreY - 16);
	draw_sprite(spr_spst_win,  0, CentreX, CentreY + 16);
}