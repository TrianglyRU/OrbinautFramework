function BackgroundStartup()
{
	// Initialise variables
	BGSprites = [];
	BGValues  = [];
	BGColour  = c_black;
	
	// Create a background layer
	var Layer = layer_create(9999, "Background");
	depth	  = layer_get_depth(Layer);
	layer	  = Layer;
}