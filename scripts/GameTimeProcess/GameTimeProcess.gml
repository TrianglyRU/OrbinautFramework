function GameTimeProcess()
{
	// Process global timer
	if !fade_check(StateActive) and !variable_check(Stage, "IsPaused")
	{
		Game.GlobalTime++;
	}
}