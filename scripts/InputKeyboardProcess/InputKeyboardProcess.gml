function InputKeyboardProcess() 
{
	// Check if we should exit
	if IgnoreInput or Type != "Keyboard"
	{
		return;
	}
	var Key = global.KeyboardControl;
		
	// Key Pressed
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
		
	// Key Down
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
}