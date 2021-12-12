/// @function background_layer_setup(id,x,y,scrollX,scrollY,scrollXAuto,[inclineHeight],[inclineStep],[inclineModeY])
function background_layer_setup(id,x,y,scrollX,scrollY,scrollXAuto,inclineHeight,inclineStep,inclineModeY)
{
	with Background
	{
		if inclineStep < 0
		{	
			sprite_set_offset(BGSprites[id], 0, sprite_get_height(BGSprites[id]));	
		}	
		else
		{
			sprite_set_offset(BGSprites[id], 0, 0);
		}
		BGValues[id] = [x, y + (inclineStep < 0) * sprite_get_height(BGSprites[id]), scrollX, scrollY, scrollXAuto, inclineHeight, inclineStep, inclineModeY];
		
		// Get sprite and pixel width of each parallax piece
		BGValues[id][8]  = sprite_get_height(BGSprites[id]);
		BGValues[id][9]  = sprite_get_width(BGSprites[id]);
		BGValues[id][10] = 1 / texture_get_texel_width(sprite_get_texture(BGSprites[id], 0));
		
		// Initialise autoscroll speed
		BGValues[id][11] = 0;
	}
}