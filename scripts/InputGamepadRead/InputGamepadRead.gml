function InputGamepadRead() 
{
	// Check if input is not ignored and we do not use keyboard
	if !IgnoreInput and Type != "Keyboard" 
	{
		// Up
		UpPress = gamepad_button_check_pressed(0, gp_padu) or input_gp_axis_pressed(0, "gp_axis_lup");
		Up	    = gamepad_button_check(0, gp_padu) or gamepad_axis_value(0, gp_axislv) < 0;
	
		// Down
		DownPress = gamepad_button_check_pressed(0, gp_padd) or input_gp_axis_pressed(0, "gp_axis_ldown");
		Down      = gamepad_button_check(0, gp_padd) or gamepad_axis_value(0, gp_axislv) > 0;
	
		// Left
		LeftPress = gamepad_button_check_pressed(0, gp_padl) or input_gp_axis_pressed(0, "gp_axis_lleft");
		Left      = gamepad_button_check(0, gp_padl) or gamepad_axis_value(0, gp_axislh) < 0;
	
		// Right
		RightPress = gamepad_button_check_pressed(0, gp_padr) or input_gp_axis_pressed(0, "gp_axis_lright");
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
		StartPress = gamepad_button_check(0, gp_start);
		
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
}