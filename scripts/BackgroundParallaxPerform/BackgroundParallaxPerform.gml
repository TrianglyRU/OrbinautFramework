function BackgroundParallaxPerform()
{
	// Draw gray background
	draw_clear(c_gray);
	
	// Use shader
	shader_set(ShaderParallax);
	
	// Draw actual background
	var ArLen = array_length(BackgroundSprites);
	for (var i = 0; i < ArLen; i++)
	{
		// Exit if no sprite assigned
		if BackgroundSprites[i] == noone break;

		// Do parallax
		bg_object_parallax(BackgroundSprites[i], BackgroundValues[i]);
	}
	
	// Reset shader
	shader_reset();
}