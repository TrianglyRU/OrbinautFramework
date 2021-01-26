function InputKeyboardRead() 
{
	if !IgnoreInput and Type != "Gamepad"
	{	
		// Up
		UpPress = keyboard_check_pressed(vk_up);
		Up      = keyboard_check(vk_up);
	
		// Downs
		DownPress = keyboard_check_pressed(vk_down);
		Down      = keyboard_check(vk_down);
	
		// Left
		LeftPress = keyboard_check_pressed(vk_left);
		Left      = keyboard_check(vk_left);
	
		// Right
		RightPress = keyboard_check_pressed(vk_right);
		Right      = keyboard_check(vk_right);
	
		// A
		APress = keyboard_check_pressed(ord("A"));
		A      = keyboard_check(ord("A"));
	
		// B
		BPress = keyboard_check_pressed(ord("S"));
		B      = keyboard_check(ord("S"));
	
		// C
		CPress = keyboard_check_pressed(ord("D"));
		C      = keyboard_check(ord("D"));
	
		// ABC
		ABCPress = APress or BPress or CPress;
		ABC      = A or B or C;
		
		// Start
		StartPress = keyboard_check_pressed(vk_enter);
	}
}