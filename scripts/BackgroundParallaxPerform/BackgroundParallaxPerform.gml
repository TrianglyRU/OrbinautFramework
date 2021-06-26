function BackgroundParallaxPerform()
{
	// Draw gray background
	draw_rectangle_colour(Screen.CameraX, Screen.CameraY, Screen.CameraX + Screen.Width, Screen.CameraY + Screen.Height, c_gray, c_gray, c_gray, c_gray, false);
	
	shader_set(ShaderParallax);
	
	// Draw actual background
	var BGSprite, PositionX, PositionY, ScrollX, ScrollY, OffsetX,
	OffsetY, RenderTop, RenderBottom, InclineHeight, InclineForce;
	var len = array_length(BackgroundSprites);
	for (var i = 0; i < len; i++)
	{
		// Exit if no sprite assigned
		if BackgroundSprites[i] == noone
		{
			exit;
		}
		
		// Get values
		BGSprite      = BackgroundSprites[i];
		PositionX     = BackgroundValues[i][0];
		PositionY     = BackgroundValues[i][1];
		ScrollX       = BackgroundValues[i][2];
		ScrollY       = BackgroundValues[i][3];
		OffsetX       = BackgroundValues[i][4];
		OffsetY       = BackgroundValues[i][5];
		RenderTop     = BackgroundValues[i][6];
		RenderBottom  = BackgroundValues[i][7];
		InclineHeight = BackgroundValues[i][8];
		InclineForce  = BackgroundValues[i][9];

		// Apply a parallax shader to the object	
		shader_set_uniform_f(Palette.Prlx_Wid,   sprite_get_width(BGSprite));
		shader_set_uniform_f(Palette.Prlx_Texel, texture_get_texel_width(sprite_get_texture(BGSprite, 0)));
		
		// Do parallax
		bg_object_parallax(BGSprite, PositionX, PositionY, ScrollX, ScrollY, OffsetX, OffsetY, RenderTop, RenderBottom, InclineHeight, InclineForce);
	}
	
	// Reset parallax shader
	shader_reset();
}