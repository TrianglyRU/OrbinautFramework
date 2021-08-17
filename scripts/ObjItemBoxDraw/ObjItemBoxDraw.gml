function ObjItemBoxDraw()
{
	// Draw itembox
	draw_self();
	
	// Draw card
	if !Destroyed and CardTimer > 1
	{
		draw_sprite(spr_obj_itembox_powerup, CardSprite, x, y - 4);
	}
	else if Destroyed and CardTimer
	{
		draw_sprite(spr_obj_itembox_powerup, CardSprite, floor(CardPosX), floor(CardPosY));
	}
}