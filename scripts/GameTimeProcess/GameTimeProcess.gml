function GameTimeProcess()
{
	// Count global timer
	if !fade_check(FadeActive) and !variable_check(Stage, "IsPaused")
	{
		Game.GlobalTime++;
	}
}