function StageWaterSurfaceDraw()
{
    // Exit if no water enabled in the stage
    if !WaterEnabled
    {
        exit;
    }
    
    // Render waves on-screen
    var ScrnWater = WaterLevel - Camera.ViewY;
    if  ScrnWater > -16 and ScrnWater < Game.Height + 16
    {
        var Length = ceil(Game.Width / 32) + 2;
        for (var i = -1; i < Length; i++)
        {
            draw_sprite(spr_water_surface, animate_sprite(3, 8), (floor(Camera.ViewX / 32) + i) * 32, WaterLevel);
        }
    }
}