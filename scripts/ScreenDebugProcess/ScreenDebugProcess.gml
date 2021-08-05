function ScreenDebugProcess()
{
	// Exit the code if devmode is disabled
	if !Game.DevMode
	{
		exit;
	}
	
	// Activate general debugging
	if Stage.State != StageLoad and keyboard_check_pressed(ord("Q"))
	{
		DebugToggle = !DebugToggle;
	}
}