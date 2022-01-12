function InputGamepadProcess() 
{	
	// Check if we should exit
	if IgnoreInput or Type != "Gamepad"
	{
		exit;
	}
	var LVAxisValue = gamepad_axis_value(0, gp_axislv);
	var LHAxisValue = gamepad_axis_value(0, gp_axislh);
	
	// Key Press
	UpPress    = (LVAxisValue < 0 and !Up)    or gamepad_button_check_pressed(0, gp_padu);
	DownPress  = (LVAxisValue > 0 and !Down)  or gamepad_button_check_pressed(0, gp_padd);
	LeftPress  = (LHAxisValue < 0 and !Left)  or gamepad_button_check_pressed(0, gp_padl);
	RightPress = (LHAxisValue > 0 and !Right) or gamepad_button_check_pressed(0, gp_padr);
	APress     = gamepad_button_check_pressed(0, gp_face1);
	BPress     = gamepad_button_check_pressed(0, gp_face2);
	CPress     = gamepad_button_check_pressed(0, gp_face3);
	ModePress  = gamepad_button_check_pressed(0, gp_select);
	StartPress = gamepad_button_check_pressed(0, gp_start);
	ABCPress   = APress or BPress or CPress;
	
	// Key Down
	Up	  = LVAxisValue < 0 or gamepad_button_check(0, gp_padu);
	Down  = LVAxisValue > 0 or gamepad_button_check(0, gp_padd);
	Left  = LHAxisValue < 0 or gamepad_button_check(0, gp_padl);
	Right = LHAxisValue > 0 or gamepad_button_check(0, gp_padr);
	A     = gamepad_button_check(0, gp_face1);
	B     = gamepad_button_check(0, gp_face2);
	C	  = gamepad_button_check(0, gp_face3);
	Mode  = gamepad_button_check(0, gp_select);
	Start = gamepad_button_check(0, gp_start);
	ABC   = A or B or C;
}