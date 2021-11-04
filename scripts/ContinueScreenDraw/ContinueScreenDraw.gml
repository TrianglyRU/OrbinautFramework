function ContinueScreenDraw()
{
	// Draw textures
	draw_sprite(tex_continue_text,      0,			RoomX - 2, RoomY - 49);
	draw_sprite(tex_continue_stars,     0,		    RoomX - 1, RoomY + 12);
	draw_sprite(tex_continue_countdown, CountFrame, RoomX,     RoomY + 12);
}