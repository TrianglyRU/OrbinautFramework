if state == PLAYER_STATE.DEBUG_MODE
{
	scr_player_draw_debug_mode();
}
else
{
	pal_draw(PALETTE_MAP_PLAYER);
	scr_player_draw();
	pal_draw_previous();
}