function CameraStartup() 
{
	// Enable room viewport 0 and make it visible
	view_enabled[0] = true;
	view_visible[0] = true;	
	
	// Adjust surfaces and camera view to game resolution	
	application_set_size(Game.Width, Game.Height);
	
	switch room
	{
		default:
		{
			// Set player as a default target
			Target = Player;
			
			// Set position on Star Post if its data exists
			if !array_equals(Game.StarPostData, [])
			{
				PosX = Game.StarPostData[0] - Game.Width  / 2;
				PosY = Game.StarPostData[1] - Game.Height / 2 + 16;
			}
	
			// Set position on Special Ring if its data exists
			if !array_equals(Game.SpecialRingData, [])
			{
				PosX = Game.SpecialRingData[0] - Game.Width  / 2;
				PosY = Game.SpecialRingData[1] - Game.Height / 2 + 16;
			}
	
			/* If none of positions above exist, the camera will spawn
			on checkpoint. It is handled from its side! */
		}
		break;
	}
}