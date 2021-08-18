function InputGamepadProcess() 
{
	// Exit if we ignore input or keyboard input is active
	if Input.IgnoreInput or Input.Type == "Keyboard"
	{
		exit;
	}
	
	// Gamepad axis "pressed" function
	function gamepad_axis_check(device, axisindex)
	{
		switch Input.Axis 
		{
			case "gp_axis_lup":    
				return gamepad_axis_value(Input.Device, gp_axislv) < 0 and !Input.Up;
			break;
			case "gp_axis_ldown":  
				return gamepad_axis_value(Input.Device, gp_axislv) > 0 and !Input.Down;  
			break;
			case "gp_axis_lleft":  
				return gamepad_axis_value(Input.Device, gp_axislh) < 0 and !Input.Left;  
			break;
			case "gp_axis_lright":
				return gamepad_axis_value(Input.Device, gp_axislh) > 0 and !Input.Right; 
			break;
		}
	}
	
	// Process single press
	Input.UpPress    = gamepad_button_check_pressed(0, gp_padu) or input_gp_axis_pressed(0, "gp_axis_lup");
	Input.DownPress  = gamepad_button_check_pressed(0, gp_padd) or input_gp_axis_pressed(0, "gp_axis_ldown");
	Input.LeftPress  = gamepad_button_check_pressed(0, gp_padl) or input_gp_axis_pressed(0, "gp_axis_lleft");
	Input.RightPress = gamepad_button_check_pressed(0, gp_padr) or input_gp_axis_pressed(0, "gp_axis_lright");
	Input.APress     = gamepad_button_check_pressed(0, gp_face1);
	Input.BPress     = gamepad_button_check_pressed(0, gp_face2);
	Input.CPress     = gamepad_button_check_pressed(0, gp_face3);
	Input.ModePress  = gamepad_button_check_pressed(0, gp_select);
	Input.StartPress = gamepad_button_check_pressed(0, gp_start);
	Input.ABCPress   = Input.APress or Input.BPress or Input.CPress;
	
	// Process hold
	Input.Up	= gamepad_button_check(0, gp_padu) or gamepad_axis_value(0, gp_axislv) < 0;
	Input.Down  = gamepad_button_check(0, gp_padd) or gamepad_axis_value(0, gp_axislv) > 0;
	Input.Left  = gamepad_button_check(0, gp_padl) or gamepad_axis_value(0, gp_axislh) < 0;
	Input.Right = gamepad_button_check(0, gp_padr) or gamepad_axis_value(0, gp_axislh) > 0;
	Input.A     = gamepad_button_check(0, gp_face1);
	Input.B     = gamepad_button_check(0, gp_face2);
	Input.C	    = gamepad_button_check(0, gp_face3);
	Input.Mode  = gamepad_button_check(0, gp_select);
	Input.Start = gamepad_button_check(0, gp_start);
	Input.ABC   = Input.A or Input.B or Input.C;
}