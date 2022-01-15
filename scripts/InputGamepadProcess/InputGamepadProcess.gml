function InputGamepadProcess() 
{	
	// Check if we should exit
	if IgnoreInput or Type != "Gamepad"
	{
		exit;
	}
	
	// Choose between XInput and DirectInput. XInput is priority
	var PadID = gamepad_is_connected(0) ? 0 : 4;
	
	var LVAxisValue = gamepad_axis_value(PadID, gp_axislv);
	var LHAxisValue = gamepad_axis_value(PadID, gp_axislh);
	
	// Key Press
	UpPress    = (LVAxisValue < 0 and !Up)    or gamepad_button_check_pressed(PadID, gp_padu);
	DownPress  = (LVAxisValue > 0 and !Down)  or gamepad_button_check_pressed(PadID, gp_padd);
	LeftPress  = (LHAxisValue < 0 and !Left)  or gamepad_button_check_pressed(PadID, gp_padl);
	RightPress = (LHAxisValue > 0 and !Right) or gamepad_button_check_pressed(PadID, gp_padr);
	APress     = gamepad_button_check_pressed(PadID, gp_face1);
	BPress     = gamepad_button_check_pressed(PadID, gp_face2);
	CPress     = gamepad_button_check_pressed(PadID, gp_face3);
	ModePress  = gamepad_button_check_pressed(PadID, gp_select);
	StartPress = gamepad_button_check_pressed(PadID, gp_start);
	ABCPress   = APress or BPress or CPress;
	
	// Key Down
	Up	  = LVAxisValue < 0 or gamepad_button_check(PadID, gp_padu);
	Down  = LVAxisValue > 0 or gamepad_button_check(PadID, gp_padd);
	Left  = LHAxisValue < 0 or gamepad_button_check(PadID, gp_padl);
	Right = LHAxisValue > 0 or gamepad_button_check(PadID, gp_padr);
	A     = gamepad_button_check(PadID, gp_face1);
	B     = gamepad_button_check(PadID, gp_face2);
	C	  = gamepad_button_check(PadID, gp_face3);
	Mode  = gamepad_button_check(PadID, gp_select);
	Start = gamepad_button_check(PadID, gp_start);
	ABC   = A or B or C;
}