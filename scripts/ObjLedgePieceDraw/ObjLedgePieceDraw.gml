function ObjLedgePieceDraw()
{
	// Draw piece
	draw_sprite_part_ext(sprite_index, 0, DrawX, DrawY, 16, 16, x, y + 1, image_xscale, 1, c_white, 1);
}