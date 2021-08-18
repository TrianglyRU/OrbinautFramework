function StageWaterSurfaceDraw()
{
	// Exit if no water enabled in the stage
	if !WaterEnabled
	{
		exit;
	}
	
	// Render waves on-screen
    var ScrnWater = WaterLevel - Screen.CameraY;
    if  ScrnWater > -16 and ScrnWater < Screen.Height + 16
    {
		var Length = ceil(Screen.Width / 32) + 2;
        for (var i = -1; i < Length; i++)
        {
            draw_sprite(spr_water_surface, AnimationTime div 8 mod 3, (floor(Screen.CameraX / 32) + i) * 32, WaterLevel);
        }
    }
}