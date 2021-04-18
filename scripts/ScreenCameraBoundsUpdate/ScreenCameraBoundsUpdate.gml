function ScreenCameraBoundsUpdate()
{
	// Check if camera bottom limit is above stage bottom boundary
	if MaxRenderY < Stage.BottomBoundary 
	{
		// Shift bottom limit down with gived speed
		MaxRenderY = min(MaxRenderY + MinMaxSpeed, Stage.BottomBoundary);
	}
	
	// Check if camera bottom limit is below stage bottom boundary
	else
	{	
		// Shift bottom limit up with gived speed
		MaxRenderY = max(MaxRenderY - MinMaxSpeed, Stage.BottomBoundary);
	}
	
	// Check if camera top limit is above stage top boundary
	if MinRenderY < Stage.TopBoundary
	{
		// Shift top limit down with gived speed
		MinRenderY = min(MinRenderY + MinMaxSpeed, Stage.TopBoundary);
	}
	
	// Check if camera top limit is below stage top boundary
	else
	{
		// Shift top limit up with gived speed
		MinRenderY = min(MinRenderY - MinMaxSpeed, Stage.TopBoundary);
	}
}