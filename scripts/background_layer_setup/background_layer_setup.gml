/// @function background_layer_setup(id,x,y,scrollX,scrollY,autoXSpeed,animDuration,[inclineHeight],[inclineStep],[inclineY])
function background_layer_setup(id,x,y,scrollX,scrollY,autoXSpeed,animDuration,inclineHeight,inclineStep,inclineY)
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
		BGValues[id][0]  = x;
		BGValues[id][1]  = y + (inclineStep < 0) * sprite_get_height(BGSprites[id]);
		BGValues[id][2]  = scrollX;
		BGValues[id][3]  = scrollY;
		BGValues[id][4]  = autoXSpeed;
		BGValues[id][5]  = inclineHeight;
		BGValues[id][6]  = inclineStep;
		BGValues[id][7]  = inclineY;
		BGValues[id][8]  = animDuration;
		
		// Set texel data
		BGValues[id][9]  = sprite_get_height(BGSprites[id]);
		BGValues[id][10] = sprite_get_width(BGSprites[id]);
		BGValues[id][11] = 1 / texture_get_texel_width(sprite_get_texture(BGSprites[id], 0));
		
		// Initialise autoscroll offset value
		BGValues[id][12] = 0;
	}
}