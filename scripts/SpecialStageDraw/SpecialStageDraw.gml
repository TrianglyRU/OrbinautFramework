function SpecialStageDraw()
{
	// Get screen centre
	var CentreX = Game.Width / 2;
	var CentreY = Game.Height / 2;
	
	// Set font
	draw_set_font(Game.Font[font_default]);
	draw_set_halign(fa_center);
	
	// Draw text
	draw_text(CentreX, CentreY - 74, "* SPECIAL STAGE *");
	draw_text(CentreX, CentreY - 64, "TEMPLATE");
	
	draw_text(CentreX, CentreY - 24, "PRESS JUMP TO GET AN EMERALD");
	draw_text(CentreX, CentreY - 14, "I.E. LIKE YOU CLEARED THE STAGE");
	
	draw_text(CentreX, CentreY + 24, "PRESS START TO LEAVE SPECIAL STAGE");
	draw_text(CentreX, CentreY + 34, "WITHOUT GETTING AN EMERALD");
}