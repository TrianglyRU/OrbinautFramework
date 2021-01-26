function InputGamepadRead() 
{
	if !IgnoreInput and Type != "Keyboard" 
	{
		// Up
		Up	    = gamepad_button_check(0, gp_padu) or gamepad_axis_value(0, gp_axislv) < 0;
		UpPress = gamepad_button_check_pressed(0, gp_padu) or gamepad_check_axis_pressed(0, "gp_axis_lup");
	
		// Down
		Down      = gamepad_button_check(0, gp_padd) or gamepad_axis_value(0, gp_axislv) > 0;
		DownPress = gamepad_button_check_pressed(0, gp_padd) or gamepad_check_axis_pressed(0, "gp_axis_ldown");
	
		// Left
		Left      = gamepad_button_check(0, gp_padl) or gamepad_axis_value(0, gp_axislh) < 0;
		LeftPress = gamepad_button_check_pressed(0, gp_padl) or gamepad_check_axis_pressed(0, "gp_axis_lleft");
	
		// Right
		Right      = gamepad_button_check(0, gp_padr) or gamepad_axis_value(0, gp_axislh) > 0;
		RightPress = gamepad_button_check_pressed(0, gp_padr) or gamepad_check_axis_pressed(0, "gp_axis_lright");
	
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