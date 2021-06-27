function BackgroundParallaxPerform()
{
	// Draw gray background
	draw_rectangle_colour(Screen.CameraX, Screen.CameraY, Screen.CameraX + Screen.Width, Screen.CameraY + Screen.Height, c_gray, c_gray, c_gray, c_gray, false);
	
	// Use shader
	shader_set(ShaderParallax);
	
	// Draw actual background
	for (var i = 0; i < array_length(BackgroundSprites); i++)
	{
		// Exit if no sprite assigned
		if BackgroundSprites[i] == noone
		{
			exit;
		}
		
		// Get values
		var BGSprite      = BackgroundSprites[i];
		var PositionX     = BackgroundValues[i][0];
		var PositionY     = BackgroundValues[i][1];
		var ScrollX       = BackgroundValues[i][2];
		var ScrollY       = BackgroundValues[i][3];
		var OffsetX       = BackgroundValues[i][4];
		var OffsetY       = BackgroundValues[i][5];
		var RenderTop     = BackgroundValues[i][6];
		var RenderBottom  = BackgroundValues[i][7];
		var InclineHeight = BackgroundValues[i][8];
		var InclineForce  = BackgroundValues[i][9];

		// Apply a parallax shader to the object	
		shader_set_uniform_f(Parallax.Prlx_Wid,   sprite_get_width(BGSprite));
		shader_set_uniform_f(Parallax.Prlx_Texel, texture_get_texel_width(sprite_get_texture(BGSprite, 0)));
		
		// Do parallax
		bg_object_parallax(BGSprite, PositionX, PositionY, ScrollX, ScrollY, OffsetX, OffsetY, RenderTop, RenderBottom, InclineHeight, InclineForce);
	}
	
	// Reset shader
	shader_reset();
}