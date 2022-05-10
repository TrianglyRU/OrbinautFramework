/// @description Main
// You can write your code in this editor
	
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
	
	// Destroy on animation end
	if image_index == 12
	{
		instance_destroy();
	}
	
	// Move bubble
	if image_index < 4
	{
		FinalX = PosX + Stage.WobbleData[WobbleOffset];	
		PosY  += Ysp;

		x = floor(FinalX);
		y = floor(PosY);
	}
	else if !array_length(ScreenPosition)
	{
		// Lock position on-screen
		ScreenPosition[0] = x - Camera.ViewX;
		ScreenPosition[1] = y - Camera.ViewY;
	}