function StageDevModeProcess()
{
	// Check if we're in dev mode
	if !Game.DevMode
	{
		exit;
	}
	
	// Reset timer back to 9:00
	if Time >= 35999
	{
		Time = 32400;
	}
}