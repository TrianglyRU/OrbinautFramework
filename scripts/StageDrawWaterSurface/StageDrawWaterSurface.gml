function StageDrawWaterSurface()
{
    // Render waves
    var ScrnWater = Stage.WaterLevel - Screen.CameraY;
    if  ScrnWater > -16 and ScrnWater < Screen.Height + 16
    {
        for(var i = -1; i < ceil(Screen.Width / 32) + 2; i++)
        {
            draw_sprite(spr_water_surface, Stage.AnimationTime div 8 mod 3, i * 32 - Screen.CameraX mod 32, ScrnWater);
        }
    }
}