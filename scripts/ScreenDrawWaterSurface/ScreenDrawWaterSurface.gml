function ScreenDrawWaterSurface()
{
	// Render waves
	var ScrnWater = Stage.WaterLevel - CameraY;
	if ScrnWater > -16 and ScrnWater < 224 + 16
	{
		var ScrnWater = clamp(ScrnWater, 0, Game.ResolutionHeight);
		for(var i = -1; i < ceil(Game.ResolutionWidth / 32) + 2; i++)
		{
			draw_set_alpha(0.85);
			draw_sprite(spr_water_surface, Stage.AnimationTime div 8 mod 2, i * 32 - CameraX mod 32, ScrnWater);
			draw_set_alpha(1);
		}
	}
}