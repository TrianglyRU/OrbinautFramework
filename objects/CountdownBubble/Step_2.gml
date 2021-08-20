/// @description
// You can write your code in this editor
	
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
	var Frame = animation_get_frame(id);
	if  Frame < 5
	{
		var Duration = 7;
	}
	else if Frame < 7
	{
		var Duration = 6;
	}
	else
	{
		var Duration = 8;
	}
	if Frame < 13 and Player.IsUnderwater
	{
		animation_play(sprite_index, Duration, 13);
	}
	else
	{
		instance_destroy();
	}
		
	// Move bubble
	if animation_get_frame(id) < 5
	{
		FinalX = PosX + Stage.WobbleData[WobbleOffset];	
		PosY  += Ysp;
		
		FinalY = PosY;
	}
	else 
	{
		FinalX += Player.Xsp;
		PosY   += Player.Ysp;
		
		FinalY = PosY - 5;
	}
	
	// Update position
	object_update_position(FinalX, FinalY);