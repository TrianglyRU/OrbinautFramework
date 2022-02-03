function StageWaterSurfaceDraw()
{
	if !WaterEnabled
    {
        return;
    }
	
	// Calculate offsets
	var XOffset = dcos((Game.AnimationTime[? GlobalTime] + 90) / 2 mod 360) * 32;
	var YOffset = dsin( Game.AnimationTime[? GlobalTime]		   mod 360) / 6.75;
	
	if Game.UpdateAnimations
	{
		WaterLevel -= YOffset;
	}
	var Width = sprite_get_width(tex_water_surface);

	// Render water surface
	if (WaterLevel - Camera.ViewY) > -16 and( WaterLevel - Camera.ViewY) < Game.Height + 16
	{
	    var Length = ceil(Game.Width / Width) + 2;
	    for (var i = -1; i < Length; i++)
	    {
			draw_animated_sprite(tex_water_surface, 8, true, (floor(Camera.ViewX / Width) + i) * Width + XOffset, WaterLevel);
	    }
	}
}