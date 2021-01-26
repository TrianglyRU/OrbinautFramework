function InputDeviceUpdate() 
{	
	switch Type 
	{	
		// Update to gamepad
		case "Keyboard":
			if gamepad_button_check_pressed(0, gp_select) 
			{
				Type = "Gamepad";
			}
		break;
		
		// Update to keyboard
		case "Gamepad":
			if keyboard_check_pressed(vk_anykey) 
			{
				Type = "Keyboard";
			}
		break;	
	}	
}