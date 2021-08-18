function BackgroundStartup()
{
	// Get sprite and pixel width of each parallax piece
	var BackgroundParts = array_length(Background.BGSprites);
	for (var i = 0; i < BackgroundParts; i++)
	{
		Background.BGValues[i][9]  = sprite_get_height(Background.BGSprites[i]);
		Background.BGValues[i][10] = sprite_get_width(Background.BGSprites[i]);
		Background.BGValues[i][11] = texture_get_texel_width(sprite_get_texture(Background.BGSprites[i], 0));
	}
	
	// Draw background behind everything
	depth = 9999;
}