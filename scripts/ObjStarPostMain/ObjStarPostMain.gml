function ObjStarPostMain()
{
	// Load as activated if ID is lower than the ID of activated one
	if !ActiveCheck
	{
		if array_length(Game.StarPostData)
		{
			if instance_exists(Game.StarPostData[4]) and Game.StarPostData[4].ID >= ID
			{
				Active = true;
				Angle  = 900;
				
				// Set animation
				animation_set(spr_obj_starpost_active, 0);
			}
		}
		ActiveCheck = true;
	}
	
	// Activate starpost on overlap
	if !Active 
	{
		if object_check_overlap(Triggerbox) 
		{
			// Remember player and stage data
			Game.StarPostData[0] = x;
			Game.StarPostData[1] = y + sprite_get_height(sprite_index) / 2 - Player.DefaultRadiusY - 1;
			Game.StarPostData[2] = Stage.Time;
			Game.StarPostData[3] = Stage.BottomBoundary;
			Game.StarPostData[4] = id;
			
			// Buffer player score into its global variable
			Game.Score = Player.Score;
			
			// Activate all starposts with ID lower than ours
			var ThisID = id;
			with StarPost 
			{
				if !Active and ID <= ThisID.ID
				{
					Active      = true;
					image_index = 1;
				}	
			}
			
			// Play sound
			audio_sfx_play(sfxStarPost, false);
		}
	}
	
	// Rotate lamp
	else if Angle < 900 
	{
		Angle += 22.5;
	}
	
	// Play animation of activated starpost
	else
	{
		animation_play(spr_obj_starpost_active, 4, 0);
	}
}