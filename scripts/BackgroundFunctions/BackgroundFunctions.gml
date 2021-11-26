function BackgroundFunctions()
{
	/// @function background_layer_add(id,sprite)
	function background_layer_add(id,sprite)
	{
		BGSprites[id] = sprite;
	}
	
	/// @function background_layer_setup(id,x,y,scrollX,scrollY,autoscrollX,inclHeight*,inclForce*,inclMode*)
	function background_layer_setup(id,x,y,scrollX,scrollY,autoscrollX,inclHeight,inclForce,inclMode)
	{
		BGValues[id] = [x, y, scrollX, scrollY, autoscrollX, inclHeight, inclForce, inclMode];
	}
	
	/// @function background_colour_set(hex|in-built)
	function background_colour_set(colour)
	{
		BGColour = colour;
	}
}