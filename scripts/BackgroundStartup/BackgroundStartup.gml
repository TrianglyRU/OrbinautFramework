function BackgroundStartup()
{
	// Get background array
	var Length = array_length(BGSprites);
	for (var i = 0; i < Length; i++)
	{
		// Get sprite and pixel width of each parallax piece
		BGValues[i][8] = sprite_get_height(BGSprites[i]);
		BGValues[i][9] = sprite_get_width(BGSprites[i]);
		BGValues[i][10] = texture_get_texel_width(sprite_get_texture(BGSprites[i], 0));
		
		// Initialise autoscroll speed
		BGValues[i][11] = 0;
	}
	
	// Draw background behind everything
	depth = 9999;
}