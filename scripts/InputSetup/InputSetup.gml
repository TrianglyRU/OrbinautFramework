function InputSetup()
{	
	// Use gamepad as input device if it is conneected, else use keyboard
	if gamepad_is_connected(0) 
	{
		Type = "Gamepad";
		gamepad_set_axis_deadzone(0, 0.3);
	} 
	else 
	{
		Type = "Keyboard";
	}
	
	// Reset all buttons
	Up			= false;
	Down		= false;
	Left		= false;
	Right		= false;
	A			= false;
	B			= false;
	C			= false;
	ABC			= false;
	UpPress		= false;
	DownPress	= false;
	LeftPress	= false;
	RightPress	= false;
	APress		= false;
	BPress		= false;
	CPress		= false;
	ABCPress	= false;
	StartPress  = false;
	
	// Allow input
	IgnoreInput = false;
	ResetInput  = false;
}