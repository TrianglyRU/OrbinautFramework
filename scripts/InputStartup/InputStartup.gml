function InputStartup()
{	
	if gamepad_is_connected(0)
	{
		Type = "Gamepad";
		gamepad_set_axis_deadzone(0, 0.3);
	}
	else 
	{
		Type = "Keyboard";
	}
}