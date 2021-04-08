function StageDrawWaterSurface()
{
	draw_sprite_ext(spr_water_tint, 0, Screen.RenderX, Stage.WaterLevel, Screen.RenderX + Screen.Width, Stage.BottomBoundary, false, c_white, 0.5);
	if Stage.WaterLevel > Screen.RenderY - 16 and Stage.WaterLevel < Screen.RenderY + 224 + 16
	{
		for(var i = 0; i < ceil(Game.ResolutionWidth / 32) + 1; i++)
		{
			draw_set_alpha(0.75);
			draw_sprite(spr_water_surface, Stage.Time div 8 mod 2, (Screen.RenderX div 32 + i) * 32, Stage.WaterLevel);
			draw_set_alpha(1);
		}
	}
}