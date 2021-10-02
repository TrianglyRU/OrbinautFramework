function InputStartup()
{	
	// Set blank values
	IgnoreInput	= 0;
	Up			= 0;
	Down		= 0;
	Left		= 0;
	Right		= 0;
	A			= 0;
	B			= 0;
	C			= 0;
	ABC			= 0;
	Start		= 0;
	Mode		= 0;
	UpPress		= 0;
	DownPress	= 0;
	LeftPress	= 0;
	RightPress	= 0;
	APress		= 0;
	BPress		= 0;
	CPress		= 0;
	ABCPress	= 0;
	StartPress  = 0;
	ModePress   = 0;
	
	// Set deadzone for gamepad
	gamepad_set_axis_deadzone(0, 0.3);
	
	// Set default input method
	Type = gamepad_is_connected(0) ? "Gamepad" : "Keyboard";
}