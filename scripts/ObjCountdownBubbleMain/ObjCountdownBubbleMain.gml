function ObjCountdownBubbleMain()
{
	// Handle wobble data
	if Direction = FlipRight
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
	
	// Play animation
	var Frame = image_index;
	if  Frame < 4
	{
		var Duration = 7;
	}
	else if Frame < 6
	{
		var Duration = 6;
	}
	else
	{
		var Duration = 8;
	}
	if Frame < 12 and Player.IsUnderwater
	{
		animation_play(sprite_index, Duration, 12);
	}
	else
	{
		instance_destroy();
	}
		
	// Move bubble
	if image_index < 4
	{
		FinalX = PosX + Stage.WobbleData[WobbleOffset];	
		PosY  += Ysp;
		
		// Update position
		object_update_position(FinalX, PosY);
	}
	else if array_equals(ScreenPosition, [])
	{
		ScreenPosition[0] = x - Camera.ViewX;
		ScreenPosition[1] = y - Camera.ViewY;
	}
}