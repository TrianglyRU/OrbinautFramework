function InputReset()
{	
	// Ignore double input
	if Input.Left and Input.Right
	{
		Input.Left  = false;
		Input.Right = false;
	}
	if Input.Up and Input.Down
	{
		Input.Up   = false;
		Input.Down = false;
	}
	
	// Reset all buttons if we ignore all input
	if Input.IgnoreInput
	{
		Input.Up		 = false;
		Input.Down		 = false;
		Input.Left		 = false;
		Input.Right		 = false;
		Input.A			 = false;
		Input.B			 = false;
		Input.C			 = false;
		Input.ABC		 = false;
		Input.Start      = false;
		Input.Mode		 = false;
		Input.UpPress	 = false;
		Input.DownPress	 = false;
		Input.LeftPress	 = false;
		Input.RightPress = false;
		Input.APress	 = false;
		Input.BPress	 = false;
		Input.CPress     = false;
		Input.ABCPress	 = false;
		Input.StartPress = false;
		Input.ModePress  = false;
	}
}