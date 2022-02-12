function StageBoundariesProcess()
{	
	if !Stage.UpdateObjects
	{
		return;
	}
	
	// Update left boundary
	if LeftBoundary < TargetLeftBoundary
	{
		if Camera.ViewX >= TargetLeftBoundary
		{
			LeftBoundary = TargetLeftBoundary
		}
		else
		{
			if Camera.ViewX >= LeftBoundary
			{
				LeftBoundary = Camera.ViewX
			}
			LeftBoundary = min(LeftBoundary + 2, TargetLeftBoundary);
		}
	}
	else if LeftBoundary > TargetLeftBoundary
	{
		LeftBoundary = max(TargetLeftBoundary, LeftBoundary - 2);
	}
	
	// Update right boundary
	if RightBoundary < TargetRightBoundary
	{
		RightBoundary = min(RightBoundary + 2, TargetRightBoundary)
	}
	else if RightBoundary > TargetRightBoundary
	{
		if Camera.ViewX + global.Width >= TargetRightBoundary
		{
			RightBoundary = Camera.ViewX + global.Width;
			RightBoundary = max(TargetRightBoundary, RightBoundary - 2);
		}
		else if Camera.ViewX + global.Width <= TargetRightBoundary
		{
			RightBoundary = TargetRightBoundary
		}
	}
	
	// Update top boundary
	if TopBoundary < TargetTopBoundary
	{
		if Camera.ViewY >= TargetTopBoundary
		{
			TopBoundary = TargetTopBoundary
		}
		else
		{
			if Camera.ViewY > TopBoundary
			{
				TopBoundary = Camera.ViewY;
			}
			TopBoundary = min(TopBoundary + 2, TargetTopBoundary);
		}
	}
	else if TopBoundary > TargetTopBoundary
	{
		TopBoundary = max(TargetTopBoundary, TargetTopBoundary - 2);
	}
	
	// Update bottom boundary
	if BottomBoundary < TargetBottomBoundary
	{
		BottomBoundary = min(BottomBoundary + 2, TargetBottomBoundary);
		DeathBoundary  = TargetBottomBoundary;
	}
	else if BottomBoundary > TargetBottomBoundary
	{
		if Camera.ViewY + global.Height >= TargetBottomBoundary
		{
			BottomBoundary = Camera.ViewY + global.Height
			BottomBoundary = max(TargetBottomBoundary, BottomBoundary - 2);
		}
		else if Camera.ViewY + global.Height <= TargetBottomBoundary
		{
			BottomBoundary = TargetBottomBoundary;
		}
		DeathBoundary = BottomBoundary;
	}
	
	// Keep boundaries within the room size
	TopBoundary    = max(0,			  TopBoundary);
	LeftBoundary   = max(0,			  LeftBoundary);
	RightBoundary  = min(room_width,  RightBoundary);
	BottomBoundary = min(room_height, BottomBoundary);
	DeathBoundary  = min(room_height, DeathBoundary);
}