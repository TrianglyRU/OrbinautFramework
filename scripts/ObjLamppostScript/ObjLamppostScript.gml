function ObjLamppostScript()
{	
	// Init lamppost
	if !Init
	{
		// Default values
		Active = false;
		Angle  = 180;
	
		// Load as activated if its ID number is lower than activated one
		if Game.SavedCheckpoint != 0 and Game.SavedCheckpoint.LamppostID >= LamppostID
		{
			image_index = 2;
			Active      = true;
			Angle		= 900;
		}
		
		// Finish initialization
		Init = true;
	}
	else
	{
		// If not active, activate
		if !Active 
		{
			if hitbox_collision(Player, self) 
			{
				// Set last used checkpoint ID to our ID
				Game.SavedCheckpoint = id;
				Game.SavedPosition = [x, y];
			
				// Activate all inactive checkpoints with ID lower than ours
				var tempValue = LamppostID;
				with Lamppost if !Active and LamppostID <= tempValue 
				{
					Active      = 1;
					image_index = 1;
				}
			
				// Play sound
				audio_sfx_play(sfxLamppost, false);
			}
		}
	
		// Else rotate the lamp and stop it after 2 loops
		else if Angle < 900 
		{
			Angle += 22.5;
			if (Angle == 900) image_index = 2;
		}
	}
}