function InputDeviceUpdate() 
{	
	switch Type 
	{	
		// Switch from keyboard to gamepad
		case "Keyboard":
			if gamepad_button_check_pressed(0, gp_select) 
			{
				Type = "Gamepad";
			}
		break;
		
		// Switch from gamepad to keyboard
		case "Gamepad":
			if keyboard_check_pressed(vk_anykey) 
			{
				Type = "Keyboard";
			}
		break;	
	}	
}