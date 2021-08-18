function InputGamepadProcess() 
{
	// Exit if we ignore input or keyboard input is active
	if IgnoreInput or Type == "Keyboard"
	{
		exit;
	}
	
	// Gamepad axis "pressed" function
	function gamepad_axis_check(device, axisindex)
	{
		switch Axis 
		{
			case "gp_axis_lup":    
				return gamepad_axis_value(Device, gp_axislv) < 0 and !Up;
			break;
			case "gp_axis_ldown":  
				return gamepad_axis_value(Device, gp_axislv) > 0 and !Down;  
			break;
			case "gp_axis_lleft":  
				return gamepad_axis_value(Device, gp_axislh) < 0 and !Left;  
			break;
			case "gp_axis_lright":
				return gamepad_axis_value(Device, gp_axislh) > 0 and !Right; 
			break;
		}
	}
	
	// Process single press
	UpPress    = gamepad_button_check_pressed(0, gp_padu) or input_gp_axis_pressed(0, "gp_axis_lup");
	DownPress  = gamepad_button_check_pressed(0, gp_padd) or input_gp_axis_pressed(0, "gp_axis_ldown");
	LeftPress  = gamepad_button_check_pressed(0, gp_padl) or input_gp_axis_pressed(0, "gp_axis_lleft");
	RightPress = gamepad_button_check_pressed(0, gp_padr) or input_gp_axis_pressed(0, "gp_axis_lright");
	APress     = gamepad_button_check_pressed(0, gp_face1);
	BPress     = gamepad_button_check_pressed(0, gp_face2);
	CPress     = gamepad_button_check_pressed(0, gp_face3);
	ModePress  = gamepad_button_check_pressed(0, gp_select);
	StartPress = gamepad_button_check_pressed(0, gp_start);
	ABCPress   = APress or BPress or CPress;
	
	// Process hold
	Up	  = gamepad_button_check(0, gp_padu) or gamepad_axis_value(0, gp_axislv) < 0;
	Down  = gamepad_button_check(0, gp_padd) or gamepad_axis_value(0, gp_axislv) > 0;
	Left  = gamepad_button_check(0, gp_padl) or gamepad_axis_value(0, gp_axislh) < 0;
	Right = gamepad_button_check(0, gp_padr) or gamepad_axis_value(0, gp_axislh) > 0;
	A     = gamepad_button_check(0, gp_face1);
	B     = gamepad_button_check(0, gp_face2);
	C	  = gamepad_button_check(0, gp_face3);
	Mode  = gamepad_button_check(0, gp_select);
	Start = gamepad_button_check(0, gp_start);
	ABC   = A or B or C;
}