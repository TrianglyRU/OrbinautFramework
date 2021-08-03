function StageBoundariesUpdate()
{	
	// Exit
	if Player.Death or State != StageActive
	{
		exit;
	}

	// Update left boundary
	if LeftBoundary < TargetLeftBoundary
	{
		if Screen.CameraX >= TargetLeftBoundary
		{
			LeftBoundary = TargetLeftBoundary
		}
		else
		{
			if Screen.CameraX >= LeftBoundary
			{
				LeftBoundary = Screen.CameraX
			}
			LeftBoundary++;
		}
	}
	else if LeftBoundary > TargetLeftBoundary
	{
		LeftBoundary--;
	}
	
	// Update right boundary
	if RightBoundary < TargetRightBoundary
	{
		RightBoundary++;
	}
	else if RightBoundary > TargetRightBoundary
	{
		if Screen.CameraX + Screen.Width >= TargetRightBoundary
		{
			RightBoundary = Screen.CameraX + Screen.Width;
			RightBoundary--;
		}
		else if Screen.CameraX + Screen.Width <= TargetRightBoundary
		{
			RightBoundary = TargetRightBoundary
		}
	}
	
	// Update top boundary
	if TopBoundary < TargetTopBoundary
	{
		if Screen.CameraY >= TargetTopBoundary
		{
			TopBoundary = TargetTopBoundary
		}
		else
		{
			if Screen.CameraY > TopBoundary
			{
				TopBoundary = Screen.CameraY;
			}
			TopBoundary++;
		}
	}
	else if TopBoundary > TargetTopBoundary
	{
		TopBoundary--;
	}
	
	// Update bottom boundary
	if BottomBoundary < TargetBottomBoundary
	{
		BottomBoundary++;
		DeathBoundary = TargetBottomBoundary;
	}
	else if BottomBoundary > TargetBottomBoundary
	{
		if Screen.CameraY + Screen.Height >= TargetBottomBoundary
		{
			BottomBoundary = Screen.CameraY + Screen.Height
			BottomBoundary--;
		}
		else if Screen.CameraY + Screen.Height <= TargetBottomBoundary
		{
			BottomBoundary = TargetBottomBoundary;
		}
		DeathBoundary = BottomBoundary;
	}
}