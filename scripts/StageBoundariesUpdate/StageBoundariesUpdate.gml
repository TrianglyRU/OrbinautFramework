function StageBoundariesUpdate()
{	
	// Limit left boundary if we've loaded from the previous act
	if Game.StageTransitions and Stage.ActID != 0
	{
		TargetLeftBoundary = Spawnpoint.x - Screen.Width / 2;
		LeftBoundary       = TargetLeftBoundary;
	}
	
	// Update horizontal boundaries
	if LeftBoundary < TargetLeftBoundary
	{
		if Screen.CameraX > TargetLeftBoundary
		{
			LeftBoundary = TargetLeftBoundary
		}
		else
		{
			if Screen.CameraX > LeftBoundary
			{
				LeftBoundary = Screen.CameraX
			}
			LeftBoundary = min(LeftBoundary + max(1, Player.Xsp), TargetLeftBoundary);
		}
	}
	else if LeftBoundary > TargetLeftBoundary
	{
		LeftBoundary--;
	}
	
	if RightBoundary < TargetRightBoundary
	{
		RightBoundary = min(RightBoundary + max(1, Player.Xsp), TargetRightBoundary);
	}
	else if RightBoundary > TargetRightBoundary
	{
		if Screen.CameraX + Screen.Width < RightBoundary
		{
			RightBoundary = Screen.CameraX + Screen.Width;
		}
		RightBoundary--;
	}
	
	// Update vertical boundaries
	if TopBoundary < TargetTopBoundary
	{
		if Screen.CameraY > TargetTopBoundary
		{
			TopBoundary = TargetTopBoundary
		}
		else
		{
			if Screen.CameraY > TopBoundary
			{
				TopBoundary = Screen.CameraY;
			}
			TopBoundary = min(TopBoundary + max(1, Player.Ysp), TargetTopBoundary);
		}
	}
	else if TopBoundary > TargetTopBoundary
	{
		TopBoundary--;
	}
	
	if BottomBoundary < TargetBottomBoundary
	{
		BottomBoundary = min(BottomBoundary + max(1, Player.Ysp), TargetBottomBoundary);
		DeathBoundary  = TargetBottomBoundary;
	}
	else if BottomBoundary > TargetBottomBoundary
	{
		if Screen.CameraY + Screen.Height < BottomBoundary
		{
			BottomBoundary = Screen.CameraY + Screen.Height
		}
		BottomBoundary--;
		DeathBoundary = BottomBoundary;
	}
	/*
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

	// Variables list
	if ActEndObject != noone
	{
		var FinishX = ActEndObject.x;
	}
	var PlayerX		  = floor(Player.PosX);
	var CameraX       = floor(Screen.CameraX);
	var CameraCentreX = floor(Screen.CameraX + Screen.Width / 2);
	var HalvedWidth   = Screen.Width / 2;
	
	// Adjust horizontal boundaries
	switch State
	{
		// Set stage boundaries during normal play
		case ActStateDefault:
		{
			if ActEndObject != noone 
			{
				if CameraX >= FinishX - Screen.Width * 1.5 + 64
				{
					if PlayerX >= CameraX + HalvedWidth
					{				
						LeftBoundary = CameraX;	
					}
					if FinishX + HalvedWidth <= RightBoundary
					{
						RightBoundary = FinishX + HalvedWidth;
					}
				}
			} 
		}
		break;
		
		// Set stage boundaries on act finish
		case ActStateFinished:
		{		
			LeftBoundary  = FinishX - HalvedWidth;
			RightBoundary = FinishX + HalvedWidth;
		}
		break;
		
		// Set stage boundaries during bossfight
		case ActStateBossfight:
		{
			if instance_exists(BossController)
			{
				LeftBoundary   = BossController.x - BossController.ArenaWidth  / 2 + BossController.ArenaXShift;
				RightBoundary  = BossController.x + BossController.ArenaWidth  / 2 + BossController.ArenaXShift;
				TopBoundary    = BossController.y - BossController.ArenaHeight / 2 + BossController.ArenaYShift;
				BottomBoundary = BossController.y + BossController.ArenaHeight / 2 + BossController.ArenaYShift;
			}
			else
			{
				if ActEndObject != noone
				{
					if floor(Player.PosX) == Screen.CameraX + Screen.Width / 2
					{
						LeftBoundary = Screen.CameraX;
					}
					else if floor(Player.PosX) > Screen.CameraX + Screen.Width / 2
					{
						LeftBoundary = min(LeftBoundary + 4, floor(Player.PosX) - Screen.Width / 2);
					}
					RightBoundary = min(RightBoundary + 4, FinishX + HalvedWidth)
				}
				else
				{
					RightBoundary = room_width;
					State		  = ActStateDefault;
				}
			}
		}
		break;
	}
	show_debug_message(BottomBoundary);*/
}