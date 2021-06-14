function StageBoundariesUpdate()
{	
	// Limit left boundary if we've loaded from the previous act
	if Game.StageTransitions and ActID != 0
	{
		TargetLeftBoundary = Spawnpoint.x - Screen.Width / 2;
		LeftBoundary       = TargetLeftBoundary;
	}
	
	// Update left boundary
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
	
	// Update right boundary
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
	
	// Update top boundary
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
	
	// Update bottom boundary
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
}