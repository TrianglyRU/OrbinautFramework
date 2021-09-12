function BackgroundSetup()
{
	/* HOW TO SETUP A BACKGROUND */
	/*
		// Set background sprites
		BGSprites = [sprite1, sprite2, sprite3...]
	
		// sprite1
		BGValues[0] = [x, y, scrollx, scrolly, autoscrollx, 2.5d_height, 2.5d_force, 2.5d_mode];
	
		// sprite2
		BGValues[1] = [...];
		...
		
		Refer to documemtation for more detailed information!
	*/
	
	switch room
	{	
		// Test Stage
		case TestStage:
		{
			// Set background sprites
			BGSprites = [tex_tsz_bg00, tex_tsz_bg01, tex_tsz_bg02, tex_tsz_bg03, tex_tsz_bg04, tex_tsz_bg05, tex_tsz_bg06];
			
			// Set background properties
			BGValues[0] = [0, 0,   0.45, 0.05, -0.5, 0, 0,   0];
			BGValues[1] = [0, 20,  0.35, 0.05, -0.3, 0, 0,   0];
			BGValues[2] = [0, 41,  0.25, 0.05, -0.1, 0, 0,   0];
			BGValues[3] = [0, 59,  0.15, 0.05, 0,    0, 0,   0];
			BGValues[4] = [0, 116, 0.19, 0.05, 0,    0, 0,   0];
			BGValues[5] = [0, 164, 0.19, 0.05, 0,    1, 0.3, 0];
			BGValues[6] = [0, 189, 0.6, 0.05,  0,    0, 0,   0];
			
			// Set background colour
			BGColour = $004400;
		}
		break;
		
		// Default
		default: 
		{
			// Set background sprites
			BGSprites = [];
			
			// Set background properties
			/*
			BGValues[0] = [...];
			BGValues[1] = [...];
			BGValues[2] = [...];
			*/
			
			// Set background colour
			BGColour = c_gray;
		}
		break;
	}	
}