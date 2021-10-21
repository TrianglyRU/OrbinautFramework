function ObjCountdownBubbleMain()
{
	// Handle wobble data
	if Direction == FlipRight
	{
		if WobbleOffset + 1 == array_length(Stage.WobbleData)
		{
			WobbleOffset = 0;
		}
		else
		{
			WobbleOffset++
		}
	}
	else if Direction = FlipLeft
	{
		if !WobbleOffset
		{
			WobbleOffset = array_length(Stage.WobbleData) - 1;
		}
		else
		{
			WobbleOffset--
		}
	}
	
	// Destroy object once animation reaches last frame
	if image_index == 12
	{
		instance_destroy();
	}
	
	// Move bubble
	if image_index < 4
	{
		FinalX = PosX + Stage.WobbleData[WobbleOffset];	
		PosY  += Ysp;
		
		// Update position
		x = floor(FinalX);
		y = floor(PosY);
	}
	else if !array_length(ScreenPosition)
	{
		ScreenPosition[0] = x - Camera.ViewX;
		ScreenPosition[1] = y - Camera.ViewY;
	}
}