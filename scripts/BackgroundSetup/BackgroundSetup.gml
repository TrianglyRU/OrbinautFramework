function BackgroundSetup()
{
	switch room
	{	
		// Test Stage
		case Stage_TVZ:
		{	
			// Add layers
			background_layer_add(0, tex_tvz_bg00);
			background_layer_add(1, tex_tvz_bg00);
			background_layer_add(2, tex_tvz_bg00);
			background_layer_add(3, tex_tvz_bg00);
			background_layer_add(4, tex_tvz_bg01);
			background_layer_add(5, tex_tvz_bg02);
			
			// Setup layers
			background_layer_setup(0, 0,   0,   117, 0.13, 0.05,  0,   0, 0,   0,     false);
			background_layer_setup(1, 0,   117, 28,  0.15, 0.05,  0,   0, 0,   0,     false);
			background_layer_setup(2, 0,   145, 46,  0.19, 0.05,  0,   0, 0,   0,     false);
			background_layer_setup(3, 0,   191, 121, 0.6,  0.05,  0,   0, 0,   0,	  false);
			background_layer_setup(4, 0,   0,   0,   0.13, 0.05, -0.1, 0, 20, -0.05,  false);
			background_layer_setup(5, 166, 0,   0,   0.19, 0.05,  0,   0, 1,   0.008, false);
			
			// Set colour
			background_colour_set($004400);
		}
		break;
	}	
}