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