/// @function background_layer_setup(id,ofstY,nodeY,heightY,scrollX,scrollY,autoXSpeed,animDuration,inclineHeight,inclineStep,inclineY)
function background_layer_setup(id,ofstY,nodeY,heightY,scrollX,scrollY,autoXSpeed,animDuration,inclineHeight,inclineStep,inclineY)
{
	with Background
	{
		// Offset the background
		if inclineStep < 0
		{	
			sprite_set_offset(BGSprites[id], 0, sprite_get_height(BGSprites[id]));	
		}	
		else
		{
			sprite_set_offset(BGSprites[id], 0, 0);
		}
		
		// Get values
		BGValues[id][0] = ofstY + nodeY + (inclineStep < 0) * sprite_get_height(BGSprites[id]);
		BGValues[id][1] = nodeY;
		BGValues[id][2] = heightY;
		BGValues[id][3] = scrollX;
		BGValues[id][4] = scrollY;
		BGValues[id][5] = autoXSpeed;
		BGValues[id][6] = inclineHeight;
		BGValues[id][7] = inclineStep;
		BGValues[id][8] = inclineY;
		BGValues[id][9] = animDuration;
		
		// Get texel data
		BGValues[id][10] = sprite_get_height(BGSprites[id]);
		BGValues[id][11] = sprite_get_width(BGSprites[id]);
		BGValues[id][12] = 1 / texture_get_texel_width(sprite_get_texture(BGSprites[id], 0));
		
		// Initialise autoscroll offset value
		BGValues[id][13] = 0;
	}
}