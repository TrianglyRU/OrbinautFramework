function InputStartup()
{	
	// Set deadzone for gamepad
	gamepad_set_axis_deadzone(0, 0.3);
	
	// Set default input method
	if gamepad_is_connected(0)
	{
		Type = "Gamepad";
	}
	else 
	{
		Type = "Keyboard";
	}
}