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
			BGSprites = [tex_tsz_bg0, tex_tsz_bg1];
			
			// Set background properties
			BGValues[0] = [0, 0,   0.15, 0.05, 0, 0, 0, 0];
			BGValues[1] = [0, 124, 0.25, 0.05, 0, 0, 0, 0];
			
			// Set background colour
			BGColour = c_gray;
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