// Inherit the parent event
event_inherited();

if draw_card
{
	draw_sprite(spr_obj_itemcard, card_index, floor(x), floor(y - 3));
}