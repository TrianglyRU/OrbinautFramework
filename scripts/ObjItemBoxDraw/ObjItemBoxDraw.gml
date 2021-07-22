function ObjItemBoxDraw()
{
	x = floor(PosX);
	y = floor(PosY);
	
	draw_self();
	
	draw_sprite(spr_obj_itembox_powerup, CardSprite, floor(CardPosX), floor(CardPosY));
}