function ObjItemBoxDraw()
{
	// Draw itembox
	draw_self();
	
	// Draw item card
	if (!State and Timer > 1) or (State and State < 3)
	{
		draw_sprite(spr_obj_itembox_powerup, CardSprite, floor(CardX), floor(CardY));
	}
}