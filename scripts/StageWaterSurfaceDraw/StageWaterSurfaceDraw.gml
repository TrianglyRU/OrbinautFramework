function StageWaterSurfaceDraw()
{
    // Check if we should exit
    if !WaterEnabled or Game.GlobalTime mod 2
    {
        exit;
    }
	
	// Render water surface
	if (WaterLevel - Camera.ViewY) > -16 and( WaterLevel - Camera.ViewY) < Game.Height + 16
	{
	    var Length = ceil(Game.Width / 32) + 2;
	    for (var i = -1; i < Length; i++)
	    {
			draw_animated_sprite(tex_water_surface, 16, true, (floor(Camera.ViewX / 32) + i) * 32, WaterLevel);
	    }
	}
}