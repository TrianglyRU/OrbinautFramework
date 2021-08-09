/// @description
// You can write your code in this editor
	
	// Exit if above water
	if !Stage.WaterEnabled or y < Stage.WaterLevel
	{
		exit;
	}
	
	// Draw
	draw_self();