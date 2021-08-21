function ObjCountdownBubbleDraw()
{
	// If showing a countdown number, fix position
	if !array_equals(ScreenPosition, [])
	{
		x = Camera.ViewX + ScreenPosition[0];
		y = Camera.ViewY + ScreenPosition[1] - 5;
	}
	
	// Draw object
	draw_self();
}