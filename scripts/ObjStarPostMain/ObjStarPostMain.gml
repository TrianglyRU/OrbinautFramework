function ObjStarPostMain()
{
	// Load as activated if ID is lower than the ID of activated one
	switch State
	{
		case 0:
		{
			if array_length(Game.StarPostData)
			{
				if instance_exists(Game.StarPostData[4]) and Game.StarPostData[4].ID >= ID
				{
					// Increment state by 2
					State = 2;
					Angle = 900;
					
					// Exit
					break;
				}
			}
			
			// Increment state
			State++;
		}
		break;
		case 1:
		{
			if object_check_overlap(Triggerbox) 
			{
				// Remember player and stage data
				Game.StarPostData[0] = x;
				Game.StarPostData[1] = y + sprite_get_height(sprite_index) div 2 - Player.DefaultRadiusY - 1;
				Game.StarPostData[2] = Stage.Time;
				Game.StarPostData[3] = Stage.TargetBottomBoundary;
				Game.StarPostData[4] = id;
			
				// Buffer player score into its global variable
				Game.Score = Player.Score;
			
				// Activate all starposts with ID lower than ours
				var ThisID = id;
				with StarPost 
				{
					if State == 1 and ID <= ThisID.ID
					{
						State       = 2;
						image_index = 1;
					}	
				}
			
				// Play sound
				audio_sfx_play(sfxStarPost, false);
			
				// Create Bonus Stage portal if we have more than 20 rings
				if Player.Rings >= 20
				{
					instance_create(x, y - sprite_get_height(sprite_index) div 2 - 10, StarPostPortal);
				}
			}
		}
		break;
		case 2:
		{
			// Rotate lamp
			if Angle < 900 
			{
				Angle += 22.5;
			}
			
			// Set animation
			else
			{
				animation_play(spr_obj_starpost_active, 4, 0, 0);
			}
		}
		break;
	}
}