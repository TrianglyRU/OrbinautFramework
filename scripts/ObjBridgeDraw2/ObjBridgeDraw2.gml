function ObjBridgeDraw2()
{
	// Draw posts
	if GeneratePosts
	{
		draw_sprite(SpriteData[1],     0, x - BridgeLength / 2 * 16 - 18, NativeY - 15);
		draw_sprite_ext(SpriteData[1], 0, x + BridgeLength / 2 * 16 + 18, NativeY - 15, -1, 1, 0, c_white, 1);
	}
	
	// Update object depth
	object_set_depth(Player, 0);
}