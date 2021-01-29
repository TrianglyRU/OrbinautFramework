function StageHorizontalBoundariesUpdate()
{	
	// Check for act end object
	if instance_exists(Signpost) 
	{
		var ActEndObject = Signpost;
	}
	else if instance_exists(Capsule) 
	{
		var ActEndObject = Capsule;
	}
	else 
	{
		var ActEndObject = noone;
	}
	
	// If we placed Signpost AND Capsule in the stage, show error message and close the game
	if instance_exists(Signpost) and instance_exists(Capsule)
	{	
		show_message("Both act end objects found in the room. Only one act end object is expected to be found.");
		game_end();
	}	
	
	// Perform code according to current stage state
	else switch State
	{
		// Set limits in normal stage state
		case ActStateDefault:
		{ 
			if ActEndObject != noone 
			{
				if floor(Player.PosX) >= (ActEndObject.x - Screen.Width * 1.5 + 64) + Screen.Width / 2 
				{
					if Screen.PlayerScreenX > Screen.Width / 2
					{
						LeftBoundary = floor(Player.PosX) - Screen.Width / 2;
					}
					RightBoundary = ActEndObject.x + Screen.Width / 2;
				}	
			} 
			else 
			{
				LeftBoundary  = 0;
				RightBoundary = room_width;
			}
		}
		break;
		
		// Set limits in "act finished" state
		case ActStateFinished:
		{
			if floor(Player.PosX) > ActEndObject.x
			{
				LeftBoundary = ActEndObject.x - Screen.Width / 2;
			}
		}
		break;
	
		// Set stage boundaries when fighting with a boss
		case ActStateBossfight:
		{
			LeftBoundary  = BossSpawner.x - Screen.Width / 2;
			RightBoundary = BossSpawner.x + Screen.Width / 2;
		}
		break;
	
		// Set stage boundaries after finished fighting a boss
		case ActStateAfterboss:
		{
			if ActEndObject != noone
			{
				if Screen.PlayerScreenX > Screen.Width / 2 
				{
					LeftBoundary = Player.PosX - Screen.Width / 2;
				}
				if RightBoundary < ActEndObject.x + Screen.Width / 2 
				{
					RightBoundary += 2;			
					if RightBoundary > ActEndObject.x + Screen.Width / 2 
					{
						RightBoundary = ActEndObject.x + Screen.Width / 2;
					}
				}
			}
			
			// ...but if no act end object has been found, return to normal state
			else
			{
				State = ActStateDefault;
			}
		}
		break;
	}
}