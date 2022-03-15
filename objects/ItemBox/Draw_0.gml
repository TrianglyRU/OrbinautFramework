/// @description Draw
// You can write your code in this editor
	
	// Draw itembox
	draw_self();
	
	// Draw item card
	if !State and Timer > 1
	{
		if CardSprite != 11
		{
			draw_sprite(spr_obj_itembox_card, CardSprite, floor(CardX), floor(CardY));
		}
	}
	else if State and State < 3
	{
		draw_sprite(spr_obj_itembox_card, CardSprite, floor(CardX), floor(CardY));
	}