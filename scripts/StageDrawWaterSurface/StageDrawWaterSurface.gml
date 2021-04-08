function StageDrawWaterSurface()
{
	variable_init("waterAngle");
	variable_init("waterAngle2");
	variable_init("waterPos");
	variable_init("waterPos2");
	
	waterAngle  += 0.025
	waterAngle2 += 0.05
	waterPos     = sin(waterAngle) * 5;
	waterPos2    = -cos(waterAngle) * 7;
	
	//draw_sprite_ext(spr_water_tint, 0, Screen.RenderX, Stage.WaterLevel + floor(waterPos), Screen.RenderX + Screen.Width, Stage.BottomBoundary, false, c_white, 0.5);
	if Stage.WaterLevel > Screen.RenderY - 16 and Stage.WaterLevel < Screen.RenderY + 224 + 16
	{
		for(var i = 0; i < ceil(Game.ResolutionWidth / 32) + 1; i++)
		{
			draw_set_alpha(0.85);
			draw_sprite(spr_water_surface, Stage.AnimationTime div 8 mod 2, (Screen.RenderX div 32 + i) * 32 + floor(waterPos2), Stage.WaterLevel + floor(waterPos));
			draw_set_alpha(1);
		}
	}
}