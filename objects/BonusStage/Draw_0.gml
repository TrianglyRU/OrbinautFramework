/// @description Draw
// You can call your scripts in this editor
	
	var CentreX = global.Width / 2;
	var CentreY = global.Height / 2;
	
	// Set font
	draw_set_font(Font.FontDefault);
	draw_set_halign(fa_center);
	
	// Draw text
	draw_text(CentreX, CentreY - 74, "* BONUS STAGE *");
	draw_text(CentreX, CentreY - 64, "TEMPLATE");
	draw_text(CentreX, CentreY - 24, "PRESS A TO GET 10 RINGS");
	draw_text(CentreX, CentreY - 14, "PRESS B TO GET A RANDOM BARRIER");
	draw_text(CentreX, CentreY + 24, "PRESS START TO LEAVE BONUS STAGE");