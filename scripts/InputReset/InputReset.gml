function InputReset()
{	
	// Ignore "double" input
	if Left and Right
	{
		Left       = false;
		LeftPress  = false;
		Right      = false;
		RightPress = false;
		
	}
	if Up and Down
	{
		Up        = false;
		Down      = false;
		UpPress   = false;
		DownPress = false;
	}	
	
	// Reset all buttons once input is ignored
	if IgnoreInput == true
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
		IgnoreInput = 2;
	}
}