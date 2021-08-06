function InputKeyboardProcess() 
{
	// Exit if we ignore input or gamepad input is active
	if IgnoreInput or Type == "Gamepad"
	{
		exit;
	}
	
	// Get keyboard mappings
	var Key = Game.KeyboardControl;
		
	// Process single press
	UpPress    = keyboard_check_pressed(Key[0]);
	DownPress  = keyboard_check_pressed(Key[1]);
	LeftPress  = keyboard_check_pressed(Key[2]);
	RightPress = keyboard_check_pressed(Key[3]);
	APress     = keyboard_check_pressed(Key[4]);
	BPress     = keyboard_check_pressed(Key[5]);
	CPress     = keyboard_check_pressed(Key[6]);	
	ModePress  = keyboard_check_pressed(Key[7]);
	StartPress = keyboard_check_pressed(Key[8]);	
	ABCPress   = APress or BPress or CPress;
		
	// Process hold
	Up    = keyboard_check(Key[0]);
	Down  = keyboard_check(Key[1]);
	Left  = keyboard_check(Key[2]);
	Right = keyboard_check(Key[3]);
	A     = keyboard_check(Key[4]);
	B     = keyboard_check(Key[5]);
	C     = keyboard_check(Key[6]);
	Mode  = keyboard_check(Key[7]);
	Start = keyboard_check(Key[8]);
	ABC   = A or B or C;
		
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
}