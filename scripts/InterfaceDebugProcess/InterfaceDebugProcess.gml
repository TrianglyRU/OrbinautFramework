function InterfaceDebugProcess()
{
	// Exit if not allowed to toggle
	if !Game.DevMode or !Stage.DoUpdate
	{
		exit;
	}
	
	// Activate debug
	if keyboard_check_pressed(ord("Q"))
	{
		DebugToggle = !DebugToggle;
	}
}