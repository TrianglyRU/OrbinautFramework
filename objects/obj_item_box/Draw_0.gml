// Inherit the parent event
event_inherited();

if state != ITEM_BOX_STATE.DESTROYED && itembox_type > 0
{
	if (image_index + 1) % 3 != 0
	{
		draw_sprite(spr_item_card, itembox_type, floor(x), floor(y) - 3 * sign(image_yscale));
	}
}