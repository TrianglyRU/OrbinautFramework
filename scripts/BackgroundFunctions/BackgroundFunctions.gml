function BackgroundFunctions()
{
	/// @function background_layer_add(id,sprite)
	function background_layer_add(id,sprite)
	{
		BGSprites[id] = sprite;
	}
	
	/// @function background_layer_setup(id,x,y,scrollX,scrollY,scrollXAuto,[inclineHeight],[inclineStep],[inclineModeY])
	function background_layer_setup(id,x,y,scrollX,scrollY,scrollXAuto,inclineHeight,inclineStep,inclineModeY)
	{
		if inclineStep < 0
		{	
			sprite_set_offset(BGSprites[id], 0, sprite_get_height(BGSprites[id]));	
		}	
		else
		{
			sprite_set_offset(BGSprites[id], 0, 0);
		}
		BGValues[id] = [x, y, scrollX, scrollY, scrollXAuto, inclineHeight, inclineStep, inclineModeY];
	}
	
	/// @function background_colour_set(hex|in-built)
	function background_colour_set(colour)
	{
		BGColour = colour;
	}
}