function ObjStarPostMain()
{
	// Load as activated if ID is lower than the ID of activated one
	if !ActiveCheck
	{
		if array_length(Game.StarPostData) and instance_exists(Game.StarPostData[2])
		{
			if Game.StarPostData[2].ID >= ID
			{
				sprite_index = spr_obj_starpost_active;
				image_index  = 0;
				Active		 = true;
				Angle		 = 900;
			}
		}
		ActiveCheck = true;
	}
	
	// Activate starpost on overlap
	if !Active 
	{
		if object_check_overlap(Triggerbox) 
		{
			// Save stage progress
			Game.StarPostData  = [x, y + sprite_get_height(sprite_index) / 2 - Player.DefaultRadiusY, id];
			Game.Time		   = Stage.Time;
			Game.StageBoundary = Stage.BottomBoundary;
			Game.Score         = Player.Score;
			
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