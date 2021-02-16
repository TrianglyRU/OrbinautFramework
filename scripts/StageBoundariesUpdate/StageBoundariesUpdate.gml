function StageBoundariesUpdate()
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
	
	// Variables list
	if ActEndObject != noone
	{
		var FinishX = ActEndObject.x;
	}
	var PlayerX		= floor(Player.PosX);
	var HalvedWidth = Screen.Width / 2;
	var PlayerScrnX = floor(Screen.PlayerScreenX);
	
	// Adjust horizontal boundaries
	switch State
	{
		// Set stage boundaries during normal play
		case ActStateDefault:
		{
			if ActEndObject != noone 
			{
				if PlayerX >= (FinishX - Screen.Width * 1.5 + 64) + HalvedWidth
				{
					if PlayerScrnX > HalvedWidth
					{
						LeftBoundary = PlayerX - HalvedWidth;
					}
					RightBoundary = FinishX + HalvedWidth;
				}
				if PlayerX > FinishX
				{
					if floor(Screen.ViewX) >= FinishX - HalvedWidth 
					{
						LeftBoundary = FinishX - HalvedWidth;
					}
				}
			} 
		}
		break;
		
		// Set stage boundaries during bossfight
		case ActStateBossfight:
		{
			if instance_exists(BossController)
			{
				LeftBoundary  = BossController.x - HalvedWidth;
				RightBoundary = BossController.x + HalvedWidth;
			}
			else
			{
				if ActEndObject != noone
				{
					if PlayerScrnX > HalvedWidth 
					{
						LeftBoundary = PlayerX - HalvedWidth;
					}
					if RightBoundary < FinishX + HalvedWidth 
					{
						RightBoundary += 2;			
						if RightBoundary > FinishX + HalvedWidth
						{
							RightBoundary = FinishX + HalvedWidth;
						}
					}
				}
				else
				{
					State = ActStateDefault;
				}
			}
		}
		break;
	}
}