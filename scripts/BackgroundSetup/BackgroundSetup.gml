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
			
			// Set default background colour (you can also use HEX colour, in $BBGGRR format)
			BGColour = c_gray;
		}
		break;
	}	
}