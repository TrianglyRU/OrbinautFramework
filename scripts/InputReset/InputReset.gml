function InputReset()
{	
	// Ignore double input
	if Left and Right
	{
		Left  = false;
		Right = false;
	}
	if Up and Down
	{
		Up   = false;
		Down = false;
	}
	if !Left and LeftPress
	{
		LeftPress = false;
	}
	if !Right and RightPress
	{
		RightPress = false;
	}
	if !Up and UpPress
	{
		UpPress = false;
	}
	if !Down and DownPress
	{
		DownPress = false;
	}
	
	// Reset all buttons if we ignore all input
	if IgnoreInput
	{
		Up			= false;
		Down		= false;
		Left		= false;
		Right		= false;
		A			= false;
		B			= false;
		C			= false;
		ABC			= false;
		Start       = false;
		Mode		= false;
		UpPress		= false;
		DownPress	= false;
		LeftPress	= false;
		RightPress	= false;
		APress		= false;
		BPress		= false;
		CPress		= false;
		ABCPress	= false;
		StartPress  = false;
		ModePress   = false;
	}
}