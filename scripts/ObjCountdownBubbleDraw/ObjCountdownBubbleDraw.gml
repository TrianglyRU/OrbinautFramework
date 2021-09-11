function ObjCountdownBubbleDraw()
{
	// If displaying a countdown number, keep the same position on-screen
	if array_length(ScreenPosition)
	{
		x = Camera.ViewX + ScreenPosition[0];
		y = Camera.ViewY + ScreenPosition[1] - 5;
	}
	
	// Draw object
	draw_self();
}