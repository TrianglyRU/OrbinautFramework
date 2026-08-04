// Inherit the parent event
if image_index >= 9
{
	pal_draw(PALETTE_MAP_PLAYER);
	event_inherited();
	pal_draw_previous();
}
else
{
	event_inherited();
}