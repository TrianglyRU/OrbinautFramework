function PaletteSonicSans()
{
	shader_set(ShaderPalette);
	
	// Define a render boundary between type 1 and type 2 palettes
	if instance_exists(Stage) and Stage.WaterEnabled
	{
		var Boundary = Game.Height - clamp(Camera.ViewY - Stage.WaterLevel + Game.Height, 0, Game.Height);
	}
	else
	{
		var Boundary = Game.Height;
	}
	
	// Transfer boundary data into the shader
	shader_set_uniform_f(Shader.PalBoundary, Boundary);
		
	// Render palette type 1
	if Boundary > 0 and Palette.ColourSet[TypePrimary] != false
	{
		shader_set_uniform_f_array(Shader.PalIndex1, Palette.IndexType1);
		texture_set_stage(Shader.PalTex1,			 Palette.ColourSet[0][0]);
		shader_set_uniform_f(Shader.PalTexelSize1,   Palette.ColourSet[0][1], Palette.ColourSet[0][2]);
		shader_set_uniform_f(Shader.PalUVs1,		 Palette.ColourSet[0][3], Palette.ColourSet[0][4], Palette.ColourSet[0][5]);
	}
		
	// Render palette type 2
	if Boundary < Game.Height and Palette.ColourSet[TypeSecondary] != false
	{
		texture_set_stage(Shader.PalTex2,			 Palette.ColourSet[1][0]);
		shader_set_uniform_f_array(Shader.PalIndex2, Palette.IndexType2);
		shader_set_uniform_f(Shader.PalTexelSize2,   Palette.ColourSet[1][1], Palette.ColourSet[1][2]);
		shader_set_uniform_f(Shader.PalUVs2,		 Palette.ColourSet[1][3], Palette.ColourSet[1][4], Palette.ColourSet[1][5]);
	}
}