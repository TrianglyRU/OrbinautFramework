function InputKeyboardProcess() 
{
	// Exit if we ignore input or gamepad input is active
	if Input.IgnoreInput or Input.Type == "Gamepad"
	{
		exit;
	}
	
	// Get keyboard mappings
	var Key = Game.KeyboardControl;
		
	// Process single press
	Input.UpPress    = keyboard_check_pressed(Key[0]);
	Input.DownPress  = keyboard_check_pressed(Key[1]);
	Input.LeftPress  = keyboard_check_pressed(Key[2]);
	Input.RightPress = keyboard_check_pressed(Key[3]);
	Input.APress     = keyboard_check_pressed(Key[4]);
	Input.BPress     = keyboard_check_pressed(Key[5]);
	Input.CPress     = keyboard_check_pressed(Key[6]);	
	Input.ModePress  = keyboard_check_pressed(Key[7]);
	Input.StartPress = keyboard_check_pressed(Key[8]);	
	Input.ABCPress   = Input.APress or Input.BPress or Input.CPress;
		
	// Process hold
	Input.Up    = keyboard_check(Key[0]);
	Input.Down  = keyboard_check(Key[1]);
	Input.Left  = keyboard_check(Key[2]);
	Input.Right = keyboard_check(Key[3]);
	Input.A     = keyboard_check(Key[4]);
	Input.B     = keyboard_check(Key[5]);
	Input.C     = keyboard_check(Key[6]);
	Input.Mode  = keyboard_check(Key[7]);
	Input.Start = keyboard_check(Key[8]);
	Input.ABC   = Input.A or Input.B or Input.C;
		
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
}