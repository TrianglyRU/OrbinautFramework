function BackgroundStartup()
{
	// Get sprite and pixel width of each parallax piece
	var BackgroundParts = array_length(BackgroundSprites);
	for (var i = 0; i < BackgroundParts; i++)
	{
		BackgroundValues[i][9] = sprite_get_height(BackgroundSprites[i]);
		BackgroundValues[i][10] = sprite_get_width(BackgroundSprites[i]);
		BackgroundValues[i][11] = texture_get_texel_width(sprite_get_texture(BackgroundSprites[i], 0));
	}
	
	// Draw background behind everything
	depth = 9999;
}