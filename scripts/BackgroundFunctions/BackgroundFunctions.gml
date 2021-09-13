function BackgroundFunctions()
{
	/// @function background_layer_add(id,sprite)
	function background_layer_add(id, sprite)
	{
		BGSprites[id] = sprite;
	}
	
	/// @function background_layer_setup(id,x,y,scrollx,scrolly,autoscrollx,incl_height*,incl_force*,incl_mode*)
	function background_layer_setup(id, x, y, scrollx, scrolly, autoscrollx, incl_height, incl_force, incl_mode)
	{
		BGValues[id] = [x, y, scrollx, scrolly, autoscrollx, incl_height, incl_force, incl_mode];
	}
	
	/// @function background_colour_set(hex|in-built)
	function background_colour_set(colour)
	{
		BGColour = colour;
	}
}