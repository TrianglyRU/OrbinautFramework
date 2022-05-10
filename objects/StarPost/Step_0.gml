/// @description Main
// You can write your code in this editor

	switch State
	{
		case 0:
		{		
			if array_length(global.StarPostData) and global.StarPostData[4] >= ID
			{
				// Instantly activate if ID of this starpost is lower than the ID of activated one
				State = 2;
				Angle = 900;
				
				animation_play(sprite_index, 4, 1);
			}
			else if object_check_player(ColTrigger) 
			{
				// Remember data
				global.StarPostData[0] = x;
				global.StarPostData[1] = y + sprite_get_height(sprite_index) div 2 - Player.DefaultRadiusY - 1;
				global.StarPostData[2] = Stage.Time;
				global.StarPostData[3] = Stage.TargetBottomBoundary;
				global.StarPostData[4] = ID;
				global.Score		   = Player.Score;
				
				// Increment state
				State       = 1;
				image_index = 0;
				
				audio_sfx_play(sfxStarPost, false);
			
				// Create Bonus Stage portal
				if Player.Rings >= 20
				{
					var  ThisObject = id;
					var  NewObject  = instance_create(x, y - sprite_get_height(sprite_index) div 2 - 10, StarPostPortal);
					with NewObject
					{
						object_set_depth(ThisObject, 1);
					}
				}
			}
		}
		break;
		case 1:
		{
			// Rotate lamp, then update animation
			if Angle < 900 
			{
				Angle += 22.5;
			}
			if Angle == 900
			{
				image_index = 1;
				animation_play(sprite_index, 4, 1);
				
				// Increment state
				State += 1;
			}
		}
		break;
	}