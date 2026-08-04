// Inherit the parent event
event_inherited();

if state != ITEM_BOX_STATE.DESTROYED && item_box_type > 0
{
	if (image_index + 1) % 3 != 0
	{
		if item_box_type >= 9
		{
			pal_draw(PALETTE_MAP_PLAYER);
			draw_sprite(spr_item_card, item_box_type, floor(x), floor(y) - 3 * sign(image_yscale));
			pal_draw_previous();
		}
		else
		{
			draw_sprite(spr_item_card, item_box_type, floor(x), floor(y) - 3 * sign(image_yscale));
		}
	}
}