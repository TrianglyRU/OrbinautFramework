function ObjItemBoxDraw()
{
	// Use floored position
	x = floor(PosX);
	y = floor(PosY);
	
	// Draw itembox
	draw_self();
	
	// Draw card
	if !Destroyed and CardTimer > 1
	or  Destroyed and CardTimer
	{
		draw_sprite(spr_obj_itembox_powerup, CardSprite, floor(CardPosX), floor(CardPosY));
	}
}