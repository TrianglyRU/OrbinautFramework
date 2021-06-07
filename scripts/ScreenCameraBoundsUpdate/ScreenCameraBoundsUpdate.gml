function ScreenCameraBoundsUpdate()
{
	// Check if camera bottom limit is above stage bottom boundary
	if MaxRenderY < Stage.BottomBoundary 
	{
		// Shift bottom limit down with gived speed
		MaxRenderY = min(MaxRenderY + LimitScrollY, Stage.BottomBoundary);
	}
	
	// Check if camera bottom limit is below stage bottom boundary
	else
	{	
		// Shift bottom limit up with gived speed
		MaxRenderY = max(MaxRenderY - LimitScrollY, Stage.BottomBoundary);
	}
	
	// Check if camera top limit is above stage top boundary
	if MinRenderY < Stage.TopBoundary
	{
		// Shift top limit down with gived speed
		MinRenderY = min(MinRenderY + LimitScrollY, Stage.TopBoundary);
	}
	
	// Check if camera top limit is below stage top boundary
	else
	{
		// Shift top limit up with gived speed
		MinRenderY = min(MinRenderY - LimitScrollY, Stage.TopBoundary);
	}
	
	
	if MaxRenderX > Stage.RightBoundary
	{
		MaxRenderX = Stage.RightBoundary;
	}
	else
	{
		MaxRenderX = min(MaxRenderX + LimitScrollX, Stage.RightBoundary);
	}
	
	if MinRenderX < Stage.LeftBoundary
	{
		MinRenderX = Stage.LeftBoundary;
	}
	else
	{
		MinRenderX = max(MinRenderX - LimitScrollX, Stage.LeftBoundary);
	}
}