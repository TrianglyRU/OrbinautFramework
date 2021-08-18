function InputUpdate() 
{	
	// Gamepad any button pressed function
	function gamepad_anybutton_check_pressed()
	{
		for (var i = gp_face1; i < gp_axisrv; i++)
		{
			if gamepad_button_check(0, i)
			{
				return i;
			}		
		}
		return false;
	}
	
	switch Input.Type 
	{	
		// Switch from keyboard to gamepad
		case "Keyboard":
		{
			if gamepad_anybutton_check_pressed()
			{
				Input.Type = "Gamepad";
			}
		}
		break;
		
		// Switch from gamepad to keyboard
		case "Gamepad":
		{
			if keyboard_check_pressed(vk_anykey) 
			{
				Input.Type = "Keyboard";
			}				
		}
		break;
		
		// Use keyboard by default
		default:
		{
			Input.Type = "Keyboard";	
		}
		break;
	}	
}