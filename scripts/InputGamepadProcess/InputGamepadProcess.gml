function InputGamepadProcess() 
{
	// Exit if we ignore input or keyboard input is active
	if IgnoreInput or Type == "Keyboard"
	{
		exit;
	}
	
	// Script subfunction
	function InputGamepadProcess_SubFunc(device, axisindex)
	{
		// Check if gamepad axis is modified once
		switch axisindex
		{
            case "gp_axis_lup":    
                return !Up    and gamepad_axis_value(device, gp_axislv) < 0;
            break;
            case "gp_axis_ldown":  
                return !Down  and gamepad_axis_value(device, gp_axislv) > 0;  
            break;
            case "gp_axis_lleft":  
                return !Left  and gamepad_axis_value(device, gp_axislh) < 0;  
            break;
            case "gp_axis_lright":
                return !Right and gamepad_axis_value(device, gp_axislh) > 0; 
            break;
        }
	}
	
	// Process single press
	UpPress    = gamepad_button_check_pressed(0, gp_padu) or InputGamepadProcess_SubFunc(0, "gp_axis_lup");
	DownPress  = gamepad_button_check_pressed(0, gp_padd) or InputGamepadProcess_SubFunc(0, "gp_axis_ldown");
	LeftPress  = gamepad_button_check_pressed(0, gp_padl) or InputGamepadProcess_SubFunc(0, "gp_axis_lleft");
	RightPress = gamepad_button_check_pressed(0, gp_padr) or InputGamepadProcess_SubFunc(0, "gp_axis_lright");
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