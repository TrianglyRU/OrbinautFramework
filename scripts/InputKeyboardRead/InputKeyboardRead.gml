function InputKeyboardRead() 
{
	if !IgnoreInput and Type != "Gamepad"
	{	
		var Control = Game.Control;
		
		// Up
		UpPress = keyboard_check_pressed(Control[0]);
		Up      = keyboard_check(Control[0]);
	
		// Downs
		DownPress = keyboard_check_pressed(Control[1]);
		Down      = keyboard_check(Control[1]);
	
		// Left
		LeftPress = keyboard_check_pressed(Control[2]);
		Left      = keyboard_check(Control[2]);
	
		// Right
		RightPress = keyboard_check_pressed(Control[3]);
		Right      = keyboard_check(Control[3]);
	
		// A
		APress = keyboard_check_pressed(Control[4]);
		A      = keyboard_check(Control[4]);
	
		// B
		BPress = keyboard_check_pressed(Control[5]);
		B      = keyboard_check(Control[5]);
	
		// C
		CPress = keyboard_check_pressed(Control[6]);
		C      = keyboard_check(Control[6]);
	
		// ABC
		ABCPress = APress or BPress or CPress;
		ABC      = A or B or C;
		
		// Start
		StartPress = keyboard_check_pressed(Control[8]);	
	}
}