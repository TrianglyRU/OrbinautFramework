function StageDrawWaterSurface()
{
	// Set temporary variables
	variable_set_temp("waterAngle");
	variable_set_temp("waterAngle2");
	variable_set_temp("waterPos");
	variable_set_temp("waterPos2");
	
	// Do water movement
	waterAngle  += 0.025;
	waterAngle2 += 0.05;
	waterPos     = sin(waterAngle) * 5;
	waterPos2    = -cos(waterAngle2) * 7;

	// Render waves
	if Stage.WaterLevel > Screen.CameraY - 16 and Stage.WaterLevel < Screen.CameraY + 224 + 16
	{
		for(var i = -1; i < ceil(Game.ResolutionWidth / 32) + 2; i++)
		{
			draw_set_alpha(0.85);
			draw_sprite(spr_water_surface, Stage.AnimationTime div 8 mod 2, (Screen.CameraX div 32 + i) * 32 + floor(waterPos2), Stage.WaterLevel + floor(waterPos));
			draw_set_alpha(1);
		}
	}
}