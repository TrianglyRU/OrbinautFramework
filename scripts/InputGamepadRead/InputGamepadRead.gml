function InputGamepadRead() 
{
	if IgnoreInput == false and Type != "Keyboard" 
	{
		// Up
		UpPress = gamepad_button_check_pressed(0, gp_padu) or gamepad_check_axis_pressed(0, "gp_axis_lup");
		Up	    = gamepad_button_check(0, gp_padu) or gamepad_axis_value(0, gp_axislv) < 0;
	
		// Down
		DownPress = gamepad_button_check_pressed(0, gp_padd) or gamepad_check_axis_pressed(0, "gp_axis_ldown");
		Down      = gamepad_button_check(0, gp_padd) or gamepad_axis_value(0, gp_axislv) > 0;
	
		// Left
		LeftPress = gamepad_button_check_pressed(0, gp_padl) or gamepad_check_axis_pressed(0, "gp_axis_lleft");
		Left      = gamepad_button_check(0, gp_padl) or gamepad_axis_value(0, gp_axislh) < 0;
	
		// Right
		RightPress = gamepad_button_check_pressed(0, gp_padr) or gamepad_check_axis_pressed(0, "gp_axis_lright");
		Right      = gamepad_button_check(0, gp_padr) or gamepad_axis_value(0, gp_axislh) > 0;
	
		// A
		APress = gamepad_button_check_pressed(0, gp_face1);
		A      = gamepad_button_check(0, gp_face1);
	
		// B
		BPress = gamepad_button_check_pressed(0, gp_face2);
		B      = gamepad_button_check(0, gp_face2);
	
		// C
		CPress = gamepad_button_check_pressed(0, gp_face3);
		C	   = gamepad_button_check(0, gp_face3);
	
		// ABC
		ABCPress = APress or BPress or CPress;
		ABC		 = A or B or C;
	
		// Start
		StartPress = keyboard_check_pressed(gp_start);
	}
}