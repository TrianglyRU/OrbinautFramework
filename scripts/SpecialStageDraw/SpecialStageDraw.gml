function SpecialStageDraw()
{
	var CentreX = Game.Width / 2;
	var CentreY = Game.Height / 2;
	
	draw_set_font(Game.Font[Debug]);
	draw_set_halign(fa_center);
	
	draw_text(CentreX, CentreY - 16, "PRESS A B OR C TO GET 7 EMERALDS");
	draw_text(CentreX, CentreY,      "PRESS START TO LEAVE SPECIAL STAGE");
}