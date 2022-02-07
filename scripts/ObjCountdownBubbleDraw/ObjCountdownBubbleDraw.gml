function ObjCountdownBubbleDraw()
{
	if array_length(ScreenPosition)
	{
		x = Camera.ViewX + ScreenPosition[0];
		y = Camera.ViewY + ScreenPosition[1] - 5;
	}
	draw_self();
}