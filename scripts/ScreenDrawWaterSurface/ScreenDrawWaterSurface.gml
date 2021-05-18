function ScreenDrawWaterSurface()
{
	// Render waves
	/*
	if Stage.WaterLevel > Screen.CameraY - 16 and Stage.WaterLevel < Screen.CameraY + 224 + 16
	{
		for(var i = -1; i < ceil(Game.ResolutionWidth / 32) + 2; i++)
		{
			draw_set_alpha(0.85);
			draw_sprite(spr_water_surface, Stage.AnimationTime div 8 mod 2, (Screen.CameraX div 32 + i) * 32, Stage.WaterLevel);
			draw_set_alpha(1);
		}
	}
	*/
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