function StageWaterSurfaceDraw()
{
    // Exit if no water enabled in the stage
    if !WaterEnabled
    {
        exit;
    }
	
	// Render only each second frame
	if Game.GlobalTime mod 2
	{
		exit;
	}
    
    // Render waves on-screen
	var LevelY = WaterLevel - Camera.ViewY;
	if  LevelY > -16 and LevelY < Game.Height + 16
	{
	    var Length = ceil(Game.Width / 32) + 2;
	    for (var i = -1; i < Length; i++)
	    {
			draw_animated_sprite(tex_water_surface, 16, true, (floor(Camera.ViewX / 32) + i) * 32, WaterLevel);
	    }
	}
}