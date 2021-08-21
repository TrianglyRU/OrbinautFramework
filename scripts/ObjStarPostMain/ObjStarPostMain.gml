function ObjStarPostMain()
{
	// Activate starpost on overlap
	if !Active 
	{
		if object_player_overlap(CollisionTriggerbox) 
		{
			// Save stage progress
			Game.StarpostID     = id;
			Game.PlayerPosition = [x, y + sprite_get_height(sprite_index) / 2 - Player.DefaultRadiusY];
			Game.Time		    = Stage.Time;
			Game.StageBoundary  = Stage.BottomBoundary;
			Game.Score          = Player.Score;
			
			// Activate all starposts with ID lower than ours
			var ThisID = ID;
			with StarPost 
			{
				if !Active and ID <= ThisID
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
		animation_play(spr_obj_starpost_active, 4, 1);
	}
}