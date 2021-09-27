function ObjBossTriggerDraw()
{
	// Exit if not a template bossfight and boss isn't triggered
	if !(Template and Stage.IsBossfight)
	{
		exit;
	}
	
	// Draw text
	draw_set_font(Game.Font[font_default]);
	draw_set_halign(fa_center);
	
	draw_text(x, y, "*BOSSFIGHT TEMPLATE!*");
	draw_text(x, y + 16, "PRESS K ON THE KEYBOARD TO FINISH");
	draw_text(x, y + 26, "THE BOSSFIGHT");
}