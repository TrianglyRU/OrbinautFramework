/// @description
// You can write your code in this editor
	
	// Handle wobble data
	if WobbleOffset + 1 == array_length(Stage.WobbleData)
	{
		WobbleOffset = 0;
	}
	else
	{
		WobbleOffset++
	}
	
	// Update position
	PosX  = OriginPosX + Stage.WobbleData[WobbleOffset];	
	PosY += Ysp;
	
	if floor(PosY) < Stage.WaterLevel
	{
		instance_destroy();
	}