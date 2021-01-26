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
		var ActEndObject = "Unidentified";
	}
	
	// Set limits in normal stage state
	if State = StateDefault
	{ 
		if ActEndObject != "Unidentified" 
		{
			if floor(Player.PosX) >= (ActEndObject.x - Screen.Width * 1.5 + 64) + Screen.Width / 2 
			{
				LeftBoundary  = ActEndObject.x - Screen.Width * 1.5 + 64;
				RightBoundary = ActEndObject.x + Screen.Width / 2;
			}	
		} 
		else 
		{
			LeftBoundary  = 0;
			RightBoundary = room_width;
		}
	}
	
	// Set limits in "act finished" state
	if State = StateFinished
	{
		LeftBoundary  = ActEndObject.x - Screen.Width / 2;
		RightBoundary = ActEndObject.x + Screen.Width / 2;
	}	
	
	// Set stage boundaries when fighting with a boss
	if State = StateBossfight
	{
		LeftBoundary  = BossSpawner.x - Screen.Width / 2;
		RightBoundary = BossSpawner.x + Screen.Width / 2;
	}
	
	// Set stage boundaries after finished fighting a boss
	if State = StateAfterboss
	{
		if ActEndObject != "Unidentified" 
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
			State = StateDefault;
		}
	}
}