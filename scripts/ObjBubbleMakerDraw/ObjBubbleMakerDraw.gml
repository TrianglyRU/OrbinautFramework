function ObjBubbleMakerDraw()
{
	// Exit if above water
	if !Stage.WaterEnabled or y < Stage.WaterLevel
	{
		exit;
	}
	
	// Draw
	draw_self();
}