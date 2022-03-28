/// @description Startup / Setup
// You can call your scripts in this editor
	
	#region Startup
	{
		BGSprites = [];
		BGValues  = [];
		BGColour  = c_gray;
	
		// Create a background layer
		var Layer = layer_create(9999, "Background");
		depth	  = layer_get_depth(Layer);
		layer	  = Layer;
	}
	#endregion
	
	#region Setup
	{
		switch room
		{	
			// Test Stage
			case Stage_TSZ:
			{	
				// Add layers
				background_layer_add(0,  tex_tsz_bg00);
				background_layer_add(1,  tex_tsz_bg00);
				background_layer_add(2,  tex_tsz_bg00);
				background_layer_add(3,  tex_tsz_bg00);
				background_layer_add(4,  tex_tsz_bg00);
				background_layer_add(5,  tex_tsz_bg00);
				background_layer_add(6,  tex_tsz_bg00);
				background_layer_add(7,  tex_tsz_bg00);
				background_layer_add(8,  tex_tsz_bg01);
				background_layer_add(9,  tex_tsz_bg01);	
				background_layer_add(10, tex_tsz_bg02);
				background_layer_add(11, tex_tsz_bg02);
				background_layer_add(12, tex_tsz_bg03);
			
				// Calculate parallax
				var FactorY = (216 - global.Height / 2) / (1384 - global.Height / 2);
				var StepX   = (1 - 0.22) / sprite_get_height(tex_tsz_bg03);
			
				// Setup layers
				background_layer_setup(0,  0,   0,   112, 0, 0.005, FactorY, 0.01, 16, -0.04, false);
				background_layer_setup(1,  0,   112, 55,  0, 0.02,  FactorY, 0,    0,  0,	  false);
				background_layer_setup(2,  0,   167, 6,   0, 0.07,  FactorY, 0,    0,  0,	  false);
				background_layer_setup(3,  0,   173, 43,  0, 0.12,  FactorY, 0,    0,  0,	  false);
				background_layer_setup(4,  0,   216, 9,   0, 0.19,  FactorY, 0,    0,  0,     false);
				background_layer_setup(5,  0,   225, 28,  0, 0.14,  FactorY, 0,    0,  0,     false);
				background_layer_setup(6,  0,   253, 21,  0, 0.16,  FactorY, 0,    0,  0,     false);
				background_layer_setup(7,  0,   274, 101, 0, 0.2,   FactorY, 0,    0,  0,     false);
				background_layer_setup(8,  113, 0,   103, 0, 0.12,  FactorY, 0,    0,  0,     false);
				background_layer_setup(9,  113, 175, 40,  0, 0.28,  FactorY, 0,    0,  0,     false);
				background_layer_setup(10, 170, 0,   46,  0, 0.22,  FactorY, 0,    0,  0,	  false);
				background_layer_setup(11, 170, 147, 72,  0, 0.34,  FactorY, 0,    0,  0,     false);
				background_layer_setup(12, 216, 0,  -1,   0, 0.22,  FactorY, 0,    1,  StepX, true);
			
				// Set colour
				background_colour_set($244800);
			}
			break;
		}	
	}
	#endregion