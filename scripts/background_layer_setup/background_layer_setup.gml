/// @function background_layer_setup(id,ofstY,nodeY,heightY,animDuration,factorX,factorY,scrollX,scaleXHeight,scaleXStep,scaleY)
function background_layer_setup(id,ofstY,nodeY,heightY,animDuration,factorX,factorY,scrollX,scaleXHeight,scaleXStep,scaleY)
{
	with Background
	{
		// Force-offset the background
		sprite_set_offset(BGSprites[id], 0, 0);
		
		// Get values
		BGValues[id][0] = ofstY + nodeY;
		BGValues[id][1] = nodeY;
		BGValues[id][2] = heightY;
		BGValues[id][3] = factorX;
		BGValues[id][4] = factorY;
		BGValues[id][5] = scrollX;
		BGValues[id][6] = scaleXHeight;
		BGValues[id][7] = scaleXStep;
		BGValues[id][8] = scaleY;
		BGValues[id][9] = animDuration;
		
		// Get texel data
		BGValues[id][10] = sprite_get_height(BGSprites[id]);
		BGValues[id][11] = sprite_get_width(BGSprites[id]);
		BGValues[id][12] = 1 / texture_get_texel_width(sprite_get_texture(BGSprites[id], 0));
		
		// Initialise autoscroll offset value
		BGValues[id][13] = 0;
		
		// We don't know how to describe that, but that thing has to be done!
		if heightY == -1
		{
			BGValues[id][2] = -BGValues[id][10];
		}
	}
}