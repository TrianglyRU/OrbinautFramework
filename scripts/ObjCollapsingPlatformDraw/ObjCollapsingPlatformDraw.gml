function ObjCollapsingPlatformDraw()
{
	// Display object until we spawn pieces
	if State < 2
	{
		draw_self();
	}
}