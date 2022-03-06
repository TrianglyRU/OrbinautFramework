function BackgroundSetup()
{
	switch room
	{	
		// Test Stage
		case Stage_TSZ:
		{	
			// Add layers
			background_layer_add(0,  tex_tsz_bg00);
			background_layer_add(1,  tex_tsz_bg01);
			background_layer_add(2,  tex_tsz_bg01);
			background_layer_add(3,  tex_tsz_bg01);
			background_layer_add(4,  tex_tsz_bg01);
			background_layer_add(5,  tex_tsz_bg01);
			background_layer_add(6,  tex_tsz_bg01);
			background_layer_add(7,  tex_tsz_bg01);
			background_layer_add(8,  tex_tsz_bg02);
			background_layer_add(9,  tex_tsz_bg02);	
			background_layer_add(10, tex_tsz_bg03);
			background_layer_add(11, tex_tsz_bg03);
			background_layer_add(12, tex_tsz_bg04);
			
			// Calculate parallax
			var ScrollY = (216 - global.Height / 2) / (1384 - global.Height / 2);
			var IncStep = (1 - 0.22) / sprite_get_height(tex_tsz_bg04);
			
			// Setup layers
			background_layer_setup(0,  0,   0,  -1,   0.005, ScrollY, -0.01, 0, 16, -0.04,  false);
			background_layer_setup(1,  112, 0,   90,  0.02,  ScrollY, 0,     0, 0,  0,	   false);
			background_layer_setup(2,  112, 55,  6,   0.07,  ScrollY, 0,     0, 0,  0,	   false);
			background_layer_setup(3,  112, 61,  43,  0.12,  ScrollY, 0,     0, 0,  0,	   false);
			background_layer_setup(4,  112, 90,  23,  0.19,  ScrollY, 0,     0, 0,  0,      false);
			background_layer_setup(5,  112, 113, 28,  0.14,  ScrollY, 0,     0, 0,  0,      false);
			background_layer_setup(6,  112, 141, 21,  0.16,  ScrollY, 0,     0, 0,  0,      false);
			background_layer_setup(7,  112, 162, 101, 0.2,   ScrollY, 0,     0, 0,  0,      false);
			background_layer_setup(8,  113, 0,   103, 0.12,  ScrollY, 0,     0, 0,  0,      false);
			background_layer_setup(9,  113, 175, 40,  0.28,  ScrollY, 0,     0, 0,  0,      false);
			background_layer_setup(10, 170, 0,   46,  0.22,  ScrollY, 0,     0, 0,  0,	   false);
			background_layer_setup(11, 170, 147, 72,  0.34,  ScrollY, 0,     0, 0,  0,      false);
			background_layer_setup(12, 216, 0,  -1,   0.22,  ScrollY, 0,     0, 1,  IncStep, true);
			
			// Set colour
			background_colour_set($244800);
		}
		break;
	}	
}